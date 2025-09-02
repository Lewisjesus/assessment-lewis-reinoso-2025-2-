# outputs.tf del módulo Parameter Store

# Output consolidado con todos los parámetros creados
output "ssm_parameters" {
  description = "Map of all SSM Parameters details"
  value = {
    for key, param in aws_ssm_parameter.parameter_store : key => {
      name        = param.name
      arn         = param.arn
      type        = param.type
      tier        = param.tier
      version     = param.version
      data_type   = param.data_type
      key_id      = param.key_id
      description = param.description
    }
  }
}

# Output específico para nombres de parámetros
output "parameter_names" {
  description = "Map of parameter names by alias"
  value = {
    for alias, config in local.parameter_store_config_map : alias => local.resolved_parameter_names[alias]
  }
}

# Output específico para ARNs de parámetros
output "parameter_arns" {
  description = "Map of parameter ARNs by alias"
  value = {
    for key, param in aws_ssm_parameter.parameter_store : key => param.arn
  }
}
