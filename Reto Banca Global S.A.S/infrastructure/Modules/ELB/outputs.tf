# outputs.tf del módulo lb

# Output consolidado con todos los load balancers
output "load_balancers" {
  description = "Map of all Application Load Balancers details"
  value = {
    for key, lb in aws_lb.loadbalancer : key => {
      name               = lb.name
      arn                = lb.arn
      dns_name           = lb.dns_name
      zone_id            = lb.zone_id
      hosted_zone_id     = lb.zone_id
      internal           = lb.internal
      load_balancer_type = lb.load_balancer_type
      alias              = lb.tags["alias"]
      application        = lb.tags["alias"]
    }
  }
}

# Output específico para nombres de lbs
output "lb_names" {
  description = "Map of lb names by alias"
  value = {
    for config in var.lb_config : config.alias => 
    join("-", [var.project, var.domain, var.environment, "lb", config.alias])
  }
}

# Output específico para DNS names
output "lb_dns_names" {
  description = "Map of lb DNS names by alias"
  value = {
    for key, lb in aws_lb.loadbalancer : key => lb.dns_name
  }
}

# Output específico para ARNs
output "lb_arns" {
  description = "Map of lb ARNs by alias"
  value = {
    for key, lb in aws_lb.loadbalancer : key => lb.arn
  }
}

# Output consolidado de target groups
output "target_groups" {
  description = "Map of all Target Groups details"
  value = {
    for key, tg in aws_lb_target_group.target_groups : key => {
      name               = tg.name
      arn                = tg.arn
      port               = tg.port
      protocol           = tg.protocol
      target_type        = tg.target_type
      vpc_id             = tg.vpc_id
      target_application = tg.tags["target_application"]
      lb_alias          = tg.tags["lb_alias"]
    }
  }
}

# Output específico para ARNs de target groups
output "target_group_arns" {
  description = "Map of Target Group ARNs by target application"
  value = {
    for key, tg in aws_lb_target_group.target_groups : tg.tags["target_application"] => tg.arn
  }
}

# Output para compatibilidad con módulo anterior
output "target_group_info" {
  description = "Target group information in legacy format"
  value = {
    for key, tg in aws_lb_target_group.target_groups : tg.tags["target_application"] => {
      "target_arn"  = tg.arn
      "target_name" = tg.name
    }
  }
}

# Output consolidado de listeners
output "listeners" {
  description = "Map of all Listeners details"
  value = {
    for key, listener in aws_lb_listener.listeners : key => {
      arn           = listener.arn
      port          = listener.port
      protocol      = listener.protocol
      lb_alias     = listener.tags["lb_alias"]
      certificate_arn = listener.certificate_arn
    }
  }
}

# Output específico por tipo de balanceador
output "lbs_by_type" {
  description = "lbs grouped by type"
  value = {
    application = {
      for key, lb in aws_lb.loadbalancer : key => {
        name     = lb.name
        dns_name = lb.dns_name
        arn      = lb.arn
      }
      if lb.load_balancer_type == "application"
    }
    network = {
      for key, lb in aws_lb.loadbalancer : key => {
        name     = lb.name
        dns_name = lb.dns_name
        arn      = lb.arn
      }
      if lb.load_balancer_type == "network"
    }
  }
}

# Output específico por acceso interno/externo
output "lbs_by_access" {
  description = "lbs grouped by internal/external access"
  value = {
    internal = {
      for key, lb in aws_lb.loadbalancer : key => {
        name     = lb.name
        dns_name = lb.dns_name
        arn      = lb.arn
      }
      if lb.internal == true
    }
    external = {
      for key, lb in aws_lb.loadbalancer : key => {
        name     = lb.name
        dns_name = lb.dns_name
        arn      = lb.arn
      }
      if lb.internal == false
    }
  }
}

# Output de estadísticas
output "lb_statistics" {
  description = "Statistics about lb infrastructure created"
  value = {
    total_lbs         = length(aws_lb.loadbalancer)
    total_target_groups = length(aws_lb_target_group.target_groups)
    total_listeners    = length(aws_lb_listener.listeners)
    total_rules        = length(aws_lb_listener_rule.listener_rules)
    application_lbs   = length(local.application_load_balancers)
    network_lbs       = length(local.network_load_balancers)
    internal_lbs      = length(local.internal_lbs)
    external_lbs      = length(local.external_lbs)
    lbs_with_waf      = length(local.lbs_with_waf)
  }
}

# Output para conexiones de microservicios
output "microservices_endpoints" {
  description = "Microservices endpoints for applications"
  value = {
    for tg_key, tg in aws_lb_target_group.target_groups : tg.tags["target_application"] => {
      target_group_arn = tg.arn
      lb_dns_name     = aws_lb.loadbalancer[tg.tags["lb_alias"]].dns_name
      service_port     = tg.port
      health_check_path = tg.health_check[0].path
    }
  }
}

# Output para load balancer info (compatibilidad)
output "load_balancer_info" {
  description = "Load balancer information in legacy format"
  value = [
    for lb in aws_lb.loadbalancer : {
      "lb_arn"  = lb.arn
      "lb_dns"  = lb.dns_name
      "lb_zone" = lb.zone_id
    }
  ]
}