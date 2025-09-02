# # ######################################################################
# # #  WAF - Amazon Web Application Firewall
# # ######################################################################

# Create Web ACL
resource "aws_wafv2_web_acl" "web_acl" {
  for_each    = { for item in var.web_acl_config : item.name => item }
  name        = join("-", tolist([var.project, var.domain, var.environment, "waf", each.value.name]))
  description = each.value.description
  scope       = each.value.scope

  default_action {
    dynamic "allow" {
      for_each = each.value.default_action == "allow" ? [1] : []
      content {}
    }

    dynamic "block" {
      for_each = each.value.default_action == "block" ? [1] : []
      content {}
    }
  }

  # Rules defined in the configuration
  dynamic "rule" {
    for_each = each.value.rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      # Action configuration para reglas que no son de tipo managed_rule_group
      dynamic "action" {
        for_each = rule.value.statement_type != "managed_rule_group" ? [1] : []
        content {
          dynamic "allow" {
            for_each = rule.value.action == "allow" ? [1] : []
            content {}
          }
  
          dynamic "block" {
            for_each = rule.value.action == "block" ? [1] : []
            content {}
          }
  
          dynamic "count" {
            for_each = rule.value.action == "count" ? [1] : []
            content {}
          }
        }
      }
      
      # override_action para reglas de tipo managed_rule_group
      dynamic "override_action" {
        for_each = rule.value.statement_type == "managed_rule_group" ? [1] : []
        content {
          dynamic "count" {
            for_each = rule.value.action == "count" ? [1] : []
            content {}
          }
          
          dynamic "none" {
            for_each = rule.value.action != "count" ? [1] : []
            content {}
          }
        }
      }

      # Statement configuration based on type
      statement {
        # IP Set reference statements
        dynamic "ip_set_reference_statement" {
          for_each = rule.value.statement_type == "ip_set_reference" ? [1] : []
          content {
            arn = rule.value.ip_set_arn
            
            dynamic "ip_set_forwarded_ip_config" {
              for_each = rule.value.header_name != null ? [1] : []
              content {
                fallback_behavior = rule.value.fallback_behavior
                header_name       = rule.value.header_name
                position          = rule.value.position
              }
            }
          }
        }

        # Geo match statements
        dynamic "geo_match_statement" {
          for_each = rule.value.statement_type == "geo_match" ? [1] : []
          content {
            country_codes = rule.value.country_codes
          }
        }

        # Rate-based statements
        dynamic "rate_based_statement" {
          for_each = rule.value.statement_type == "rate_based" ? [1] : []
          content {
            limit              = rule.value.rate_limit
            aggregate_key_type = rule.value.aggregate_key_type
          }
        }

        # Managed rule group statements
        dynamic "managed_rule_group_statement" {
          for_each = rule.value.statement_type == "managed_rule_group" ? [1] : []
          content {
            name        = rule.value.managed_rule_name
            vendor_name = rule.value.vendor_name
            
            # Usamos rule_action_override para excluir reglas
            dynamic "rule_action_override" {
              for_each = rule.value.excluded_rules != null ? rule.value.excluded_rules : []
              content {
                name = rule_action_override.value
                action_to_use {
                  count {}
                }
              }
            }
          }
        }

        # SQL injection match statements
        dynamic "sqli_match_statement" {
          for_each = rule.value.statement_type == "sqli_match" ? [1] : []
          content {
            field_to_match {
              dynamic "all_query_arguments" {
                for_each = rule.value.field_to_match == "all_query_arguments" ? [1] : []
                content {}
              }
              
              dynamic "body" {
                for_each = rule.value.field_to_match == "body" ? [1] : []
                content {}
              }
              
              dynamic "uri_path" {
                for_each = rule.value.field_to_match == "uri_path" ? [1] : []
                content {}
              }
            }
            
            text_transformation {
              priority = rule.value.text_transformation_priority
              type     = rule.value.text_transformation_type
            }
          }
        }

        # XSS match statements
        dynamic "xss_match_statement" {
          for_each = rule.value.statement_type == "xss_match" ? [1] : []
          content {
            field_to_match {
              dynamic "all_query_arguments" {
                for_each = rule.value.field_to_match == "all_query_arguments" ? [1] : []
                content {}
              }
              
              dynamic "body" {
                for_each = rule.value.field_to_match == "body" ? [1] : []
                content {}
              }
              
              dynamic "uri_path" {
                for_each = rule.value.field_to_match == "uri_path" ? [1] : []
                content {}
              }
            }
            
            text_transformation {
              priority = rule.value.text_transformation_priority
              type     = rule.value.text_transformation_type
            }
          }
        }
      }

      # Visibility configuration
      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  # IP Sets rules
  dynamic "rule" {
    for_each = each.value.ip_sets != null ? each.value.ip_sets : []
    content {
      name     = rule.value.name
      priority = rule.value.priority

      action {
        dynamic "allow" {
          for_each = rule.value.action == "allow" ? [1] : []
          content {}
        }
        
        dynamic "block" {
          for_each = rule.value.action == "block" ? [1] : []
          content {}
        }
        
        dynamic "count" {
          for_each = rule.value.action == "count" ? [1] : []
          content {}
        }
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.ip_set[rule.value.ip_set_key].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  # Overall visibility configuration
  visibility_config {
    cloudwatch_metrics_enabled = each.value.cloudwatch_metrics_enabled
    metric_name                = each.value.metric_name
    sampled_requests_enabled   = each.value.sampled_requests_enabled
  }

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "waf", each.value.name])) },
    var.resource_tags
  )
}

# Create IP Sets
resource "aws_wafv2_ip_set" "ip_set" {
  for_each    = { for item in var.ip_set_config : item.name => item }
  name        = join("-", tolist([var.project, var.domain, var.environment, "ipset", each.value.name]))
  description = each.value.description
  scope       = each.value.scope
  ip_address_version = each.value.ip_address_version
  addresses   = each.value.addresses

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "ipset", each.value.name])) },
    var.resource_tags
  )
}

# Associate Web ACL with resources (opcional)
resource "aws_wafv2_web_acl_association" "web_acl_association" {
  for_each     = length(var.web_acl_association_config) > 0 ? { for item in var.web_acl_association_config : "${item.web_acl_key}-${item.resource_arn}" => item } : {}
  web_acl_arn  = aws_wafv2_web_acl.web_acl[each.value.web_acl_key].arn
  resource_arn = each.value.resource_arn
}

# Create Logging Configuration (opcional)
resource "aws_wafv2_web_acl_logging_configuration" "logging_config" {
  for_each = length(var.logging_config) > 0 ? { for item in var.logging_config : item.web_acl_key => item if item.log_destination_configs != null && length(item.log_destination_configs) > 0 } : {}
  
  resource_arn            = aws_wafv2_web_acl.web_acl[each.value.web_acl_key].arn
  log_destination_configs = each.value.log_destination_configs
  
  dynamic "redacted_fields" {
    for_each = each.value.redacted_fields_single_header != null && length(each.value.redacted_fields_single_header) > 0 ? [1] : []
    content {
      dynamic "single_header" {
        for_each = each.value.redacted_fields_single_header
        content {
          name = single_header.value
        }
      }
    }
  }
}