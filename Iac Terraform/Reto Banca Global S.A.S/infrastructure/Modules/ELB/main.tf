# main.tf del módulo lb

# Application Load Balancer
resource "aws_lb" "loadbalancer" {
  for_each = local.lb_config_map

  name                             = join("-", [var.project, var.domain, var.environment, "lb", each.value.alias])
  internal                         = each.value.internal
  load_balancer_type               = each.value.load_balancer_type
  subnets                          = each.value.subnets
  security_groups                  = each.value.security_groups
  idle_timeout                     = each.value.idle_timeout
  drop_invalid_header_fields       = each.value.drop_invalid_header_fields
  enable_deletion_protection       = each.value.enable_deletion_protection
  enable_cross_zone_load_balancing = each.value.enable_cross_zone_load_balancing

  tags = merge(
    {
      Name  = join("-", [var.project, var.domain, var.environment, "lb", each.value.alias])
      alias = each.value.alias

      internal = each.value.internal ? "true" : "false"
    },
    var.resource_tags
  )
}

# WAF Association
resource "aws_wafv2_web_acl_association" "waf_lb" {
  for_each = local.lbs_with_waf

  resource_arn = aws_lb.loadbalancer[each.key].arn
  web_acl_arn  = each.value.waf_arn
}

# Target Groups
resource "aws_lb_target_group" "target_groups" {
  for_each = local.target_groups_map

  name             = join("-", [var.project, var.domain, var.environment, "tg", each.value.target_application])
  port             = each.value.port
  protocol         = each.value.protocol
  vpc_id           = each.value.vpc_id
  target_type      = each.value.target_type
  protocol_version = each.value.protocol_version

  dynamic "health_check" {
    for_each = [1]
    content {
      enabled             = true
      healthy_threshold   = each.value.healthy_threshold
      interval            = each.value.interval
      port                = "traffic-port"
      protocol            = each.value.protocol
      timeout             = each.value.timeout
      unhealthy_threshold = each.value.unhealthy_threshold
      
      # Solo incluir matcher y path para protocolos HTTP/HTTPS
      matcher = contains(["HTTP", "HTTPS"], each.value.protocol) ? each.value.matcher : null
      path    = contains(["HTTP", "HTTPS"], each.value.protocol) ? each.value.path : null
    }
  }

  # Stickiness configuration (opcional)
  dynamic "stickiness" {
    for_each = each.value.stickiness != null ? [each.value.stickiness] : []
    content {
      enabled         = stickiness.value.enabled
      type            = stickiness.value.type
      cookie_duration = stickiness.value.cookie_duration
      cookie_name     = stickiness.value.cookie_name
    }
  }

  tags = merge(
    {
      Name               = join("-", [var.project, var.domain, var.environment, "tg", each.value.target_application])
      target_application = each.value.target_application
      lb_alias          = each.value.lb_alias
    },
    var.resource_tags
  )
}

# Listeners
resource "aws_lb_listener" "listeners" {
  for_each = local.listeners_map

  load_balancer_arn = aws_lb.loadbalancer[each.value.lb_alias].arn
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = each.value.certificate_arn != "" ? each.value.certificate_arn : null
  ssl_policy        = each.value.protocol == "HTTPS" ? each.value.ssl_policy : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups["${each.value.lb_alias}-${each.value.default_target_group_id}"].arn
  }

  tags = merge(
    {
      Name      = join("-", [var.project, var.domain, var.environment, "listener", each.value.lb_alias, each.value.port])
      lb_alias = each.value.lb_alias
      port      = each.value.port
      protocol  = each.value.protocol
    },
    var.resource_tags
  )
}

# Listener Rules
resource "aws_lb_listener_rule" "listener_rules" {
  for_each = local.listener_rules_map

  listener_arn = aws_lb_listener.listeners[each.value.listener_key].arn
  priority     = each.value.priority

  # Action configuration
  action {
    type = each.value.action.type

    # Forward action
    target_group_arn = each.value.action.type == "forward" ? aws_lb_target_group.target_groups["${each.value.lb_alias}-${each.value.target_application}"].arn : null

    # Redirect action
    dynamic "redirect" {
      for_each = each.value.action.type == "redirect" && each.value.action.redirect_config != null ? [each.value.action.redirect_config] : []
      content {
        host        = redirect.value.host
        path        = redirect.value.path
        port        = redirect.value.port
        protocol    = redirect.value.protocol
        query       = redirect.value.query
        status_code = redirect.value.status_code
      }
    }

    # Fixed response action
    dynamic "fixed_response" {
      for_each = each.value.action.type == "fixed-response" && each.value.action.fixed_response != null ? [each.value.action.fixed_response] : []
      content {
        content_type = fixed_response.value.content_type
        message_body = fixed_response.value.message_body
        status_code  = fixed_response.value.status_code
      }
    }
  }

  # Conditions
  dynamic "condition" {
    for_each = each.value.conditions
    content {
      # Host header condition
      dynamic "host_header" {
        for_each = length(condition.value.host_headers) > 0 ? condition.value.host_headers : []
        content {
          values = host_header.value.headers
        }
      }

      # Path pattern condition
      dynamic "path_pattern" {
        for_each = length(condition.value.path_patterns) > 0 ? condition.value.path_patterns : []
        content {
          values = path_pattern.value.patterns
        }
      }

      # HTTP header condition
      dynamic "http_header" {
        for_each = length(condition.value.http_headers) > 0 ? condition.value.http_headers : []
        content {
          http_header_name = http_header.value.name
          values           = http_header.value.values
        }
      }

      # Query string condition
      dynamic "query_string" {
        for_each = length(condition.value.query_strings) > 0 ? condition.value.query_strings : []
        content {
          key   = query_string.value.key
          value = query_string.value.value
        }
      }

      # Source IP condition
      dynamic "source_ip" {
        for_each = length(condition.value.source_ips) > 0 ? condition.value.source_ips : []
        content {
          values = source_ip.value.values
        }
      }
    }
  }

  tags = merge(
    {
      Name       = join("-", [var.project, var.domain, var.environment, "rule", each.value.lb_alias, each.value.priority])
      lb_alias  = each.value.lb_alias
      priority   = each.value.priority
      target_app = each.value.target_application
    },
    var.resource_tags
  )
}

# ######################################################################
# #  VPC Link para API Gateway → lb
# ######################################################################

