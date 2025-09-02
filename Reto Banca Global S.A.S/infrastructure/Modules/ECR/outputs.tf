# outputs.tf del módulo ECR

# Output consolidado con todos los repositorios ECR creados
output "ecr_info" {
  description = "Map of all ECR repositories details"
  value = {
    for key, repository in aws_ecr_repository.ecr_repository : key => {
      name              = repository.name
      arn               = repository.arn
      repository_url    = repository.repository_url
      registry_id       = repository.registry_id
      access_type       = repository.tags["access_type"]
      alias             = repository.tags["alias"]
      force_delete      = repository.force_delete
      image_tag_mutability = repository.image_tag_mutability
      encryption_configuration = repository.encryption_configuration
      image_scanning_configuration = repository.image_scanning_configuration
      has_lifecycle_policy = contains(keys(local.repositories_with_lifecycle), key)
    }
  }
}

# Output específico para nombres de repositorios
output "ecr_repository_names" {
  description = "Map of ECR repository names by alias"
  value = {
    for config in var.ecr_config : config.alias => 
    join("-", [var.project, var.domain, var.environment, "ecr", config.alias])
  }
}

# Output específico para URLs de repositorios
output "ecr_repository_urls" {
  description = "Map of ECR repository URLs by alias"
  value = {
    for key, repository in aws_ecr_repository.ecr_repository : key => "${repository.repository_url}:latest"
  }
}

# Output específico para ARNs de repositorios
output "ecr_repository_arns" {
  description = "Map of ECR repository ARNs by alias"
  value = {
    for key, repository in aws_ecr_repository.ecr_repository : key => repository.arn
  }
}

# Output específico por tipo de acceso
output "ecr_repositories_by_access_type" {
  description = "ECR repositories grouped by access type"
  value = {
    private = {
      for key, repository in aws_ecr_repository.ecr_repository : key => {
        name           = repository.name
        repository_url = repository.repository_url
        arn           = repository.arn
      }
      if repository.tags["access_type"] == "private"
    }
    public = {
      for key, repository in aws_ecr_repository.ecr_repository : key => {
        name           = repository.name
        repository_url = repository.repository_url
        arn           = repository.arn
      }
      if repository.tags["access_type"] == "public"
    }
  }
}

# Output específico por funcionalidad - REMOVIDO
# output "ecr_repositories_by_functionality" {
#   description = "ECR repositories grouped by functionality"
#   value = {
#     for functionality in distinct([for config in var.ecr_config : config.functionality]) :
#     functionality => {
#       for key, repository in aws_ecr_repository.ecr_repository : key => {
#         name           = repository.name
#         repository_url = repository.repository_url
#         arn           = repository.arn
#         alias         = repository.tags["alias"]
#       }
#       if repository.tags["functionality"] == functionality
#     }
#   }
# }

# Output para políticas de ciclo de vida
output "ecr_lifecycle_policies" {
  description = "Map of ECR repositories with lifecycle policies"
  value = {
    for key, policy in aws_ecr_lifecycle_policy.lifecycle_policy : key => {
      repository_name = policy.repository
      policy_text     = policy.policy
    }
  }
}

# Output de métricas y estadísticas
output "ecr_statistics" {
  description = "Statistics about ECR repositories created"
  value = {
    total_repositories     = length(aws_ecr_repository.ecr_repository)
    private_repositories   = length(local.private_repositories)
    public_repositories    = length(local.public_repositories)
    repositories_with_lifecycle = length(local.repositories_with_lifecycle)
    kms_encrypted_repositories = length(local.kms_encrypted_repositories)
    scan_enabled_repositories = length(local.scan_enabled_repositories)
  }
}