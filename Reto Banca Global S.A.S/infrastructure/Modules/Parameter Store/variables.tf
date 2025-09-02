# variables.tf del módulo Parameter Store

# Variables básicas del proyecto
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

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

# Variable principal para la configuración de Parameter Store
variable "parameter_store_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias = string # Identificador único para el parámetro
    name  = string # Nombre completo del parámetro (puede incluir path)
    value = string # Valor del parámetro
    
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description = optional(string)
    type        = optional(string) # String, StringList, SecureString
    tier        = optional(string) # Standard, Advanced, Intelligent-Tiering
    
    # Configuración de encriptación (para SecureString)
    key_id = optional(string) # KMS Key ID
    
    # Configuración de políticas
    allowed_pattern = optional(string) # Regex pattern para validación
    
    # Configuración de datos de políticas
    data_type = optional(string) # text, aws:ec2:image, aws:ssm:integration
    
    # Configuración de overwrite
    overwrite = optional(bool)
  }))
  
  description = "Configuration for SSM Parameter Store parameters"
  
  validation {
    condition = alltrue([
      for config in var.parameter_store_config :
      contains(["String", "StringList", "SecureString"], config.type != null ? config.type : "String")
    ])
    error_message = "type debe ser String, StringList o SecureString"
  }
  
  validation {
    condition = alltrue([
      for config in var.parameter_store_config :
      config.tier == null || contains(["Standard", "Advanced", "Intelligent-Tiering"], config.tier)
    ])
    error_message = "tier debe ser Standard, Advanced o Intelligent-Tiering"
  }
  
  validation {
    condition = alltrue([
      for config in var.parameter_store_config :
      length(regexall("^[a-zA-Z0-9_-]+$", config.alias)) > 0
    ])
    error_message = "alias debe contener solo letras, números, guiones y guiones bajos."
  }
  
  validation {
    condition = alltrue([
      for config in var.parameter_store_config :
      length(config.name) <= 2048
    ])
    error_message = "El nombre del parámetro no puede exceder 2048 caracteres."
  }
}