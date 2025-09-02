# variables.tf del módulo ECS simplificado

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "domain" {
  type        = string
  description = "Domain declaration"
}


variable "ecs_config" {
  type = list(object({
    # CAMPOS OBLIGATORIOS
    alias = string

    # CAMPOS OPCIONALES
    description            = optional(string, "ECS Cluster")
    container_insights     = optional(string) # Default disabled para ahorrar costos
    enable_execute_command = optional(bool, false)


  }))

  description = "Configuration for ECS clusters"





  validation {
    condition = alltrue([
      for config in var.ecs_config :
      contains(["enabled", "disabled"], config.container_insights)
    ])
    error_message = "container_insights must be one of: enabled, disabled"
  }

  validation {
    condition = alltrue([
      for config in var.ecs_config :
      can(regex("^[a-zA-Z0-9][a-zA-Z0-9-_]*$", config.alias))
    ])
    error_message = "alias must start with a letter or number and contain only letters, numbers, hyphens, and underscores"
  }
}

# Habilitar Service Discovery
variable "service_discovery_alias" {
  type        = string
  description = "Alias para services discovery"
  default     = null
}

variable "vpc_id" {
  description = "VPC ID where the DNS namespace will be created"
  type        = string
  default     = null
}