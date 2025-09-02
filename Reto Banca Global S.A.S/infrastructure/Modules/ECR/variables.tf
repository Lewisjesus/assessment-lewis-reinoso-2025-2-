# variables.tf del módulo ECR - CORREGIDO: Estructura de LISTA

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

variable "default_kms_key_arn" {
  description = "ARN de la clave KMS por defecto para encriptación ECR"
  type        = string
  default     = null
}

variable "ecr_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias                = string
    
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description          = optional(string)
    force_delete         = optional(bool)
    image_tag_mutability = optional(string)
    access_type          = optional(string)
    
    # Configuración de encriptación (opcional)
    encryption_configuration = optional(list(object({
      encryption_type = string
      kms_key         = optional(string)
    })), [])
    
    # Configuración de escaneo (opcional)
    image_scanning_configuration = optional(list(object({
      scan_on_push = bool
    })), [])
    
    # Políticas de ciclo de vida (opcional)
    lifecycle_rules = optional(list(object({
      rulePriority = number
      description  = string
      selection = object({
        tagStatus     = string
        countType     = string
        countUnit     = optional(string)
        countNumber   = number
        tagPrefixList = optional(list(string))
      })
      action = object({
        type = string
      })
    })), [])
  }))
  
  description = "Configuration for ECR repositories as a list"
  
  validation {
    condition = alltrue([
      for config in var.ecr_config : 
      config.image_tag_mutability == null || contains(["MUTABLE", "IMMUTABLE"], config.image_tag_mutability)
    ])
    error_message = "image_tag_mutability must be one of: MUTABLE, IMMUTABLE"
  }
  
  validation {
    condition = alltrue([
      for config in var.ecr_config : 
      config.access_type == null || contains(["private", "public"], config.access_type)
    ])
    error_message = "access_type must be one of: private, public"
  }
  
  validation {
    condition = alltrue([
      for config in var.ecr_config :
      alltrue([
        for enc in config.encryption_configuration != null ? config.encryption_configuration : [] :
        contains(["AES256", "KMS"], enc.encryption_type)
      ])
    ])
    error_message = "encryption_type must be one of: AES256, KMS"
  }
}