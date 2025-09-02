# variables.tf del módulo Glue Connections - SIN validación problemática

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

variable "security_groups_map" {
  type        = map(string)
  description = "Map of security group names to IDs for dynamic assignment"
  default     = {}
}

# Network (solo para conexiones de red)
variable "physical_connection_requirements" {
  type = map(object({
    availability_zone      = optional(string)
    security_group_id_list = optional(list(string))
    subnet_id              = optional(string)
  }))
  default = {}
}

variable "glue_connections_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias           = string
    connection_type = string

    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description = optional(string)

    # Configuración JDBC (opcional)
    jdbc_url                       = optional(string)
    class_name                     = optional(string)
    url_parameter_delimiter        = optional(string)
    require_ssl                    = optional(bool)
    skip_certificate_validation    = optional(bool)
    custom_jdbc_certificate        = optional(string)
    custom_jdbc_certificate_string = optional(string)

    # Opción 1: Usar Secrets Manager (RECOMENDADO)
    secrets_manager_secret_arn = optional(string) # ARN del secret que contiene username/password

    # Configuración de credenciales (opcional)
    username = optional(string)
    password = optional(string)
    # Propiedades adicionales de conexión (opcional)
    connection_properties = optional(map(string))

    # Configuración específica para diferentes tipos de conexión
    # Kafka
    kafka_bootstrap_servers           = optional(string)
    kafka_ssl_enabled                 = optional(bool)
    kafka_custom_cert                 = optional(string)
    kafka_skip_custom_cert_validation = optional(bool)

    # MongoDB
    mongodb_host     = optional(string)
    mongodb_port     = optional(string)
    mongodb_database = optional(string)


  }))

  description = "Configuration for Glue connections"

  # Solo validaciones esenciales que no causen problemas
  validation {
    condition = alltrue([
      for config in var.glue_connections_config :
      contains(["JDBC", "KAFKA", "MONGODB", "NETWORK", "MARKETPLACE", "CUSTOM"], config.connection_type)
    ])
    error_message = "connection_type must be one of: JDBC, KAFKA, MONGODB, NETWORK, MARKETPLACE, CUSTOM"
  }

  # Validación condicional: JDBC requiere jdbc_url cuando se especifica
  validation {
    condition = alltrue([
      for config in var.glue_connections_config :
      config.connection_type != "JDBC" || (config.connection_type == "JDBC" && config.jdbc_url != null)
    ])
    error_message = "JDBC connections require jdbc_url to be specified"
  }
}
