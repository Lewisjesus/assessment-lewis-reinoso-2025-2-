
# outputs.tf
output "api_gateway_details" {
  description = "Map of API Gateway details"
  value = {
    for name, api in aws_api_gateway_rest_api.api : name => {
      id           = api.id
      name         = api.name
      endpoint_url = "${api.execution_arn}/${var.environment}"
      stage_name   = var.environment
      stage_url    = aws_api_gateway_stage.stage[name].invoke_url
    }
  }
}

output "api_execution_arn" {
  description = "ARN de ejecución para cada API Gateway"
  value       = { for name, api in aws_api_gateway_rest_api.api : name => api.execution_arn }
}

# *** OUTPUT PARA VPC LINK ***
output "vpc_link_id" {
  description = "ID del VPC Link creado (si está habilitado)"
  value       = var.vpc_link_config.enabled ? aws_api_gateway_vpc_link.lb_vpc_link[0].id : null
}

output "vpc_link_arn" {
  description = "ARN del VPC Link creado (si está habilitado)"
  value       = var.vpc_link_config.enabled ? aws_api_gateway_vpc_link.lb_vpc_link[0].arn : null
}