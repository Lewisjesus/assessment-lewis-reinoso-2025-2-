# locals.tf del módulo ECS Cluster - VERSIÓN CORREGIDA

locals {
  # Crear mapa para each con la configuración
  ecs_config_map = {
    for config in var.ecs_config : config.alias => config
  }

  # Generación de nombres de clusters
  cluster_names = {
    for alias, config in local.ecs_config_map : alias => 
    join("-", [var.project, var.domain, var.environment, "ecs", alias])
  }

  # CORREGIR: Clusters con service connect configurado
  # CAMBIAR DE service_connect_defaults A create_service_discovery
  # clusters_with_service_connect = {
  #   for alias, config in local.ecs_config_map : alias => config
  #   if config.create_service_discovery != null
  # }
}