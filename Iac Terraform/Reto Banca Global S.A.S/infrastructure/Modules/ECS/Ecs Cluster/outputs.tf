# outputs.tf del módulo ECS Cluster - VERSIÓN FINAL COMPLETA

# Output consolidado con todos los clusters ECS
output "ecs_clusters" {
  description = "Map of all ECS clusters details"
  value = {
    for key, cluster in aws_ecs_cluster.clusters : key => {
      name               = cluster.name
      id                 = cluster.id
      arn                = cluster.arn
      alias              = cluster.tags["alias"]
      container_insights = cluster.tags["insights"]
      description        = cluster.tags["description"]
      # has_service_connect = contains(keys(local.clusters_with_service_connect), key)
    }
  }
}

# Output específico para nombres de clusters
output "ecs_cluster_names" {
  description = "Map of ECS cluster names by alias"
  value = {
    for config in var.ecs_config : config.alias => 
    join("-", [var.project, var.domain, var.environment, "ecs", config.alias])
  }
}

# Output específico para ARNs de clusters
output "ecs_cluster_arns" {
  description = "Map of ECS cluster ARNs by alias"
  value = {
    for key, cluster in aws_ecs_cluster.clusters : key => cluster.arn
  }
}

# Output específico para IDs de clusters
output "ecs_cluster_ids" {
  description = "Map of ECS cluster IDs by alias"
  value = {
    for key, cluster in aws_ecs_cluster.clusters : key => cluster.id
  }
}



