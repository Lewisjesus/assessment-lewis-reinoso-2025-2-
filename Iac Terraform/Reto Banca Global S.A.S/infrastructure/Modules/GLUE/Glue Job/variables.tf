# variables.tf del módulo Glue

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

variable "glue_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias                = string
    job_type            = string
    bucket_id           = string
    
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description         = optional(string)
    script_location     = optional(string)
    temp_location       = optional(string)
    spark_logs_location = optional(string)
    
    # Configuración para glueetl y glueray (opcionales)
    glue_version        = optional(string)
    worker_type         = optional(string)
    number_of_workers   = optional(number)
    job_language        = optional(string)
    runtime             = optional(string)  # Solo para glueray
    
    # Configuración para pythonshell (opcionales)
    max_capacity        = optional(number)
    python_version      = optional(string)
    
    # CloudWatch logs (opcional)
    log_retention_days  = optional(number)
    
    # Argumentos adicionales (opcional)
    additional_default_arguments = optional(map(string))
    
    # NUEVA CONFIGURACIÓN DE CONEXIONES
    connections = optional(list(string), [])  # Lista de nombres/alias de conexiones a asociar
    
    # Configuración de políticas IAM personalizadas (opcional)
    iam_statements = optional(list(object({
      sid                   = string
      effect                = string
      actions               = list(string)
      resources             = list(string)
      principals            = optional(list(object({
        type                = string
        identifiers         = list(string)
      })), [])
      conditions           = optional(list(object({
        test               = string
        variable           = string
        values             = list(string)
      })), [])
    })), [])
  }))
  
  description = "Configuration for Glue jobs"
  
  validation {
    condition = alltrue([
      for config in var.glue_config : 
      contains(["pythonshell", "glueetl", "glueray"], config.job_type)
    ])
    error_message = "job_type must be one of: pythonshell, glueetl, glueray"
  }
  
  validation {
    condition = alltrue([
      for config in var.glue_config : 
      config.glue_version == null || contains(["1.0", "2.0", "3.0", "4.0", "5.0"], config.glue_version)
    ])
    error_message = "glue_version must be one of: 1.0, 2.0, 3.0, 4.0, 5.0"
  }
  
  validation {
    condition = alltrue([
      for config in var.glue_config : 
      config.worker_type == null || contains(["Standard", "G.1X", "G.2X", "G.025X", "Z.2X"], config.worker_type)
    ])
    error_message = "worker_type must be one of: Standard, G.1X, G.2X, G.025X, Z.2X"
  }
  
  validation {
    condition = alltrue([
      for config in var.glue_config : 
      config.job_language == null || contains(["python", "scala", "pyspark", "spark"], config.job_language)
    ])
    error_message = "job_language must be one of: python, scala, pyspark, spark"
  }
  
  validation {
    condition = alltrue([
      for config in var.glue_config : 
      length(config.connections != null ? config.connections : []) <= 10
    ])
    error_message = "A Glue job can have a maximum of 10 connections"
  }
}

# NUEVA VARIABLE PARA RECIBIR CONEXIONES DESDE EL MÓDULO PADRE
variable "available_connections" {
  type = map(object({
    name = string
    arn  = string
  }))
  description = "Map of available Glue connections from the connections module"
  default     = {}
}