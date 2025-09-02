# variables.tf - Variables principales (fuera del módulo)

variable "project" {
  type        = string
  description = "Project name"
}

variable "domain" {
  type        = string
  description = "Domain declaration"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

# Variable principal para la configuración de Glue
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
}