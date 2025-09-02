# variables.tf (en el módulo API Gateway)
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

# Variable para Cognito
# variable "cognito_user_pool_arn" {
#   description = "ARN of the Cognito User Pool to use for API authorization"
#   type        = string
# }

# Variable para pasar los nombres de funciones Lambda
variable "lambda_function_names" {
  description = "Map of API name to Lambda function names"
  type        = map(string)
}

variable "lambda_authorizer_invoke_arn" {
  description = "ARN de invocación de la función Lambda autorizadora"
  type        = string
}

variable "lambda_authorizer_arn" {
  description = "ARN de la función Lambda autorizadora"
  type        = string
}

variable "lambda_authorizer_function_name" {
  description = "Nombre de la función Lambda autorizadora"
  type        = string
}

variable "token_function_name" {
  description = "Nombre de la función Lambda que genera tokens"
  type        = string
}

variable "refresh_token_function_name" {
  description = "Nombre de la función Lambda que refresca tokens"
  type        = string
}

variable "api_gateway_config" {
  description = "Configuración para la API Gateway"
  type = list(object({
    name           = string
    description    = string
    endpoint_types = list(string)
    resources = list(object({
      path_part = optional(string)
      path      = string
      parent_id = string
      methods = list(object({
        http_method          = string
        authorization        = string
        authorization_scopes = optional(list(string), [])
        request_parameters   = map(bool)
        integration = object({
          integration_http_method = string
          type                    = string
          uri                     = string
          request_templates       = map(string)
          request_parameters      = optional(map(string), {})
          connection_type         = optional(string, "INTERNET")
          connection_id           = optional(string)
          timeout_milliseconds    = optional(number, 29000)
        })
        responses = list(object({
          status_code                    = string
          response_models                = map(string)
          response_parameters            = map(bool)
          integration_response_templates = map(string)
        }))
      }))
    }))
  }))
}

variable "api_method_settings" {
  description = "Configuración de método para API Gateway (throttling, logging, métricas)"
  type = object({
    method_path            = string
    throttling_rate_limit  = number
    throttling_burst_limit = number
    metrics_enabled        = bool
    logging_level          = string
    caching_enabled        = bool
    cache_ttl_in_seconds   = number
  })
}

# *** VARIABLE PARA VPC LINK (REST API) ***
variable "vpc_link_config" {
  description = "Configuración del VPC Link para conectar API Gateway REST API con ALB"
  type = object({
    enabled     = bool
    name        = string
    target_arns = list(string) # ARNs del ALB/NLB
  })
  default = {
    enabled     = false
    name        = ""
    target_arns = []
  }
}