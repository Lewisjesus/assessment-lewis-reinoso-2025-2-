# data.tf del módulo ECS Services - Adaptado

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Obtener información del cluster ECS
data "aws_ecs_cluster" "ecs" {
  for_each = var.ecs_services
  
  cluster_name = each.value.cluster_name
}