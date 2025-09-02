# data.tf del módulo ECS simplificado

# Obtener información de la cuenta actual
data "aws_caller_identity" "current" {}

# Obtener información de la región actual
data "aws_region" "current" {}

# COMENTADO TEMPORALMENTE: Validar que los namespaces de service connect existan
# data "aws_service_discovery_dns_namespace" "service_connect_namespaces" {
#   for_each = {
#     for alias, config in local.ecs_config_map : alias => config.service_connect_defaults.namespace
#     if config.service_connect_defaults != null
#   }
#   
#   name = each.value
#   type = "DNS_PRIVATE"
# }

