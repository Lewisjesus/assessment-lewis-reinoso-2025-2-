# main.tf del módulo ECS simplificado

# ECS Cluster
resource "aws_ecs_cluster" "clusters" {
  for_each = local.ecs_config_map

  name = local.cluster_names[each.key]

  # Container Insights
  setting {
    name  = "containerInsights"
    value = each.value.container_insights
  }

  # # Service Connect defaults (opcional)
  # dynamic "service_connect_defaults" {
  #   for_each = each.value.service_connect_defaults != null ? [each.value.service_connect_defaults] : []
  #   content {
  #     namespace = service_connect_defaults.value.namespace
  #   }
  # }



  # Configuration para execute command (opcional)
  dynamic "configuration" {
    for_each = each.value.enable_execute_command ? [1] : []
    content {
      execute_command_configuration {
        logging = "DEFAULT"
      }
    }
  }

  tags = merge(
    {
      Name        = local.cluster_names[each.key]
      alias       = each.value.alias
      insights    = each.value.container_insights
      description = each.value.description
    },
    var.resource_tags
  )


}


# Crear Service Discovery Namespace cuando se especifica 

# resource "aws_service_discovery_http_namespace" "namespace" {
#   # for_each = var.service_discovery_alias != null ? toset([var.service_discovery_alias]) : toset([])
#    for_each = var.service_discovery_alias != null ? toset(["namespace"]) : toset([])

#   name        = "${var.project}-${var.domain}-${var.environment}-sc-${var.service_discovery_alias}"
#   description = "Service Discovery namespace for ECS services"
# }

resource "aws_service_discovery_private_dns_namespace" "namespace" {
  for_each = var.service_discovery_alias != null ? toset(["namespace"]) : toset([])
  
  name        = "${var.project}-${var.domain}-${var.environment}-sc-${var.service_discovery_alias}.local"
  description = "Private DNS namespace for ECS Service Connect"
  vpc         = var.vpc_id
  
  tags = merge(
    {
      Name        = "${var.project}-${var.domain}-${var.environment}-sc-${var.service_discovery_alias}.local"
      Alias       = var.service_discovery_alias
      Type        = "DNS"
    },
    var.resource_tags
  )
}
