# locals.tf del módulo Parameter Store

locals {
  # Valores por defecto para todos los parámetros
  default_config = {
    description     = "SSM Parameter managed by Terraform"
    type           = "String"
    tier           = "Standard"
    key_id         = null
    allowed_pattern = null
    data_type      = "text"
    overwrite      = false
  }

  # Merge de configuración por defecto con configuración del usuario
  parameter_store_config_merged = [
    for config in var.parameter_store_config : merge(local.default_config, config)
  ]

  # Crear mapas para each con la configuración merged
  parameter_store_config_map = {
    for config in local.parameter_store_config_merged : config.alias => config
  }

  # Parámetros por tipo
  string_parameters = {
    for alias, config in local.parameter_store_config_map : alias => config
    if config.type == "String"
  }

  string_list_parameters = {
    for alias, config in local.parameter_store_config_map : alias => config
    if config.type == "StringList"
  }

  secure_string_parameters = {
    for alias, config in local.parameter_store_config_map : alias => config
    if config.type == "SecureString"
  }

  # Parámetros con tier Advanced
  advanced_parameters = {
    for alias, config in local.parameter_store_config_map : alias => config
    if config.tier == "Advanced"
  }

  # Generar nombres de parámetros agregando solo el ambiente si no comienza con /
  resolved_parameter_names = {
    for alias, config in local.parameter_store_config_map : alias => 
    startswith(config.name, "/") ? config.name : "/${var.environment}/${config.name}"
  }
}