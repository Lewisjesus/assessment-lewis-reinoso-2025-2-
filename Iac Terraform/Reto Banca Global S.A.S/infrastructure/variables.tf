################################################################################
# Variables TAGS
################################################################################
variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}

variable "project" {
  description = "Nombre del proyecto en el que se esta trabajando."
  type        = string
  nullable    = false
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type    = map(string)
  default = { Project = "apificacion", Owner = "Luis Quibano" }
}

variable "owner" {
  description = "Nombre del responsable del proyecto"
  type        = string
}

variable "cost_center" {
  description = "numero de identificacion del cost explorer"
  type        = string
}

variable "domain" {
  description = "d1"
  type        = string
}
# variable "deploy_role_arn" {
#   description = "ARN del rol a asumir para el despliegue"
#   type        = string
# }
################################################################################
# Variable VPC
# VPC Configuration Variables
variable "cidrblock" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
}

variable "instance_tenancy" {
  description = "Instance tenancy for VPC"
  type        = string
}

# Resource Names Variables
variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "ngw_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "eip_name" {
  description = "Name of the Elastic IP"
  type        = string
}

variable "subnet_name" {
  description = "Base name for subnets"
  type        = string
}

# Description Variables
variable "description" {
  description = "Description for WEB Access"
  type        = string
}

variable "description_sg" {
  description = "Description for HTTP traffic"
  type        = string
}

variable "description_sg2" {
  description = "Description for terminal traffic"
  type        = string
}

variable "description_ingress" {
  description = "Description for private security group"
  type        = string
}

variable "description_ingress2" {
  description = "Description for public subnet access"
  type        = string
}

variable "description_ingress3" {
  description = "Description for private DB subnet access"
  type        = string
}

variable "endpoint_tags" {
  description = "Tags adicionales para los endpoints"
  type        = map(string)
  default     = {}
}

variable "endpoint_service_name" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}

variable "endpoint_type" {
  description = "Tipo de VPC endpoint"
  type        = string
}

variable "endpoint_auto_accept" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}

variable "endpoint_policy" {
  description = "Política JSON para el endpoint"
  type        = string
}



# Variables de vpc endpoint interface para Secret Manager
variable "endpoint_service_name_secretmanager" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}

variable "endpoint_type_secretmanager" {
  description = "Tipo de VPC endpoint"
  type        = string
}

variable "endpoint_auto_accept_secretmanager" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}

variable "endpoint_policy_secretmanager" {
  description = "Política JSON para el endpoint"
  type        = string
}

# Variables de vpc endpoint interface para Api Gateway
variable "endpoint_service_name_apigateway" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_apigateway" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_apigateway" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_apigateway" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para Parameter Store
variable "endpoint_service_name_parameter_store" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_parameter_store" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_parameter_store" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_parameter_store" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para Ecr
variable "endpoint_service_name_ecr_api" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_ecr_api" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_ecr_api" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_ecr_api" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para Ecr DkR
variable "endpoint_service_name_ecr_dkr" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_ecr_dkr" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_ecr_dkr" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_ecr_dkr" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para Glue
variable "endpoint_service_name_glue" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_glue" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_glue" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_glue" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para CloudWatch Logs
variable "endpoint_service_name_cloudWatch_logs" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_cloudWatch_logs" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_cloudWatch_logs" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_cloudWatch_logs" {
  description = "Política JSON para el endpoint"
  type        = string
}
# Variables de vpc endpoint interface para ECS
variable "endpoint_service_name_ecs" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_ecs" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_ecs" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_ecs" {
  description = "Política JSON para el endpoint"
  type        = string
}


# Variables de vpc endpoint interface para ELB
variable "endpoint_service_name_elb" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}
variable "endpoint_type_elb" {
  description = "Tipo de VPC endpoint"
  type        = string
}
variable "endpoint_auto_accept_elb" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}
variable "endpoint_policy_elb" {
  description = "Política JSON para el endpoint"
  type        = string
}

# Variables de vpc endpoint Gateway para Dynamo DB
variable "endpoint_service_name_dynamo" {
  description = "Nombre del servicio para el endpoint"
  type        = string
}

variable "endpoint_type_dynamo" {
  description = "Tipo de VPC endpoint"
  type        = string
}

variable "endpoint_auto_accept_dynamo" {
  description = "Especifica si se aceptan automáticamente las conexiones al endpoint"
  type        = bool
}

variable "endpoint_policy_dynamo" {
  description = "Política JSON para el endpoint"
  type        = string
}

variable "endpoint_route_table_association_enabled" {
  description = "Habilitar/Deshabilitar la asociación de endpoints con route tables"
  type        = bool
}

# Subnet 1a Variables
variable "subnet_1a_name" {
  description = "Name of the first private subnet"
  type        = string
}

variable "subnet_1a_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "subnet_1a_private" {
  description = "Boolean indicating if subnet 1a is private"
  type        = bool
}

variable "subnet_1a_tags" {
  description = "Tags for the first private subnet"
  type        = map(string)
}

# Subnet 1b Variables
variable "subnet_1b_name" {
  description = "Name of the second private subnet"
  type        = string
}

variable "subnet_1b_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "subnet_1b_private" {
  description = "Boolean indicating if subnet 1b is private"
  type        = bool
}

variable "subnet_1b_tags" {
  description = "Tags for the second private subnet"
  type        = map(string)
}
# Subnet 1a Variables  -  Impresión de precios 
variable "subnet_1a_name_second_project" {
  description = "Name of the first private subnet"
  type        = string
}
variable "subnet_1a_cidr_second_project" {
  description = "CIDR block for the first private subnet"
  type        = string
}
variable "subnet_1a_private_second_project" {
  description = "Boolean indicating if subnet 1a is private"
  type        = bool
}
variable "subnet_1a_tags_second_project" {
  description = "Tags for the first private subnet"
  type        = map(string)
}
#Subnet 1b Variables  -  Impresión de precios 
variable "subnet_1b_name_second_project" {
  description = "Name of the second private subnet"
  type        = string
}
variable "subnet_1b_cidr_second_project" {
  description = "CIDR block for the second private subnet"
  type        = string
}
variable "subnet_1b_private_second_project" {
  description = "Boolean indicating if subnet 1b is private"
  type        = bool
}
variable "subnet_1b_tags_second_project" {
  description = "Tags for the second private subnet"
  type        = map(string)
}

# Route Configuration Variables
variable "route_cidr_block" {
  description = "CIDR block for route table"
  type        = string
}

variable "route_cidr_block_new" {
  description = "CIDR block for route table"
  type        = string
}

variable "route_cidr_block_db" {
  description = "CIDR block for route table"
  type        = string
}

variable "id_tgw_db" {
  description = "External Database ID"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  type        = string
}

# ######################################################################
# # S3 - Amazon 
# ######################################################################
# variables.tf del proyecto
variable "kms_key_arn" {
  type    = string
  default = null
}

variable "s3_notification_events" {
  description = "List of S3 events that trigger notifications"
  type        = list(string)
}

variable "s3_notification_filter_prefix" {
  description = "Filter prefix for S3 notifications"
  type        = string
}

variable "notification_events" {
  description = "Eventos para notificaciones S3"
  type        = list(string)
  default     = ["s3:ObjectCreated:Put"]
}

variable "notification_prefixes" {
  description = "Prefijos de filtro para notificaciones"
  type        = map(string)
  default = {
    stores            = "stores/"
    normalized_stores = "normalized_stores/"
    users             = "users/"
    normalized_users  = "normalized_users/"
  }
}

variable "notification_names" {
  description = "Nombres para las notificaciones"
  type        = map(string)
  default = {
    normalization_store = "normalization-store-notification"
    comparison_store    = "comparison_store-notification"
    normalization_user  = "normalization-user-notification"
    comparison_user     = "comparison_user-notification"
  }
}

# ######################################################################
# # Lambda
# ######################################################################

# Common Lambda variables
variable "lambda_runtime" {
  description = "Runtime for all Lambda functions"
  type        = string
}

variable "lambda_handler" {
  description = "Handler for all Lambda functions"
  type        = string
}

variable "lambda_handler_api_store" {
  description = "Handler for all Lambda functions"
  type        = string
}

variable "memory_size" {
  description = "Memory size for all Lambda functions"
  type        = number
}

variable "timeout" {
  description = "Timeout for all Lambda functions"
  type        = number
}

# Extraction Store Lambda variables (renombradas)
variable "extraction_store_function_name" {
  description = "Name of the extraction store Lambda function"
  type        = string
}

variable "extraction_store_description" {
  description = "Description of the extraction store Lambda function"
  type        = string
}

variable "extraction_store_s3_key" {
  description = "S3 key for extraction store Lambda function code"
  type        = string
}

variable "extraction_store_tags" {
  description = "Tags for extraction store Lambda"
  type        = map(string)
}

# Extraction User Lambda variables (nuevas)
variable "extraction_user_function_name" {
  description = "Name of the extraction user Lambda function"
  type        = string
}

variable "extraction_user_description" {
  description = "Description of the extraction user Lambda function"
  type        = string
}

variable "extraction_user_s3_key" {
  description = "S3 key for extraction user Lambda function code"
  type        = string
}

variable "extraction_user_tags" {
  description = "Tags for extraction user Lambda"
  type        = map(string)
}

# DynamoDB permissions variables
variable "dynamo_statement_id" {
  description = "Statement ID for DynamoDB permissions"
  type        = string
}

variable "dynamo_actions" {
  description = "List of DynamoDB actions for permissions"
  type        = list(string)
}

variable "dynamo_principal" {
  description = "Principal for DynamoDB permissions"
  type        = string
}

# S3 permissions variables
variable "s3_statement_id" {
  description = "Statement ID for S3 permissions"
  type        = string
}

variable "s3_actions" {
  description = "List of S3 actions for permissions"
  type        = list(string)
}

variable "s3_principal" {
  description = "Principal for S3 permissions"
  type        = string
}

# kms permissions variables
variable "kms_statement_id_lambda" {
  description = "Statement ID for KMS permissions"
  type        = string
}

variable "kms_actions_lambda" {
  description = "List of KMS actions for Lambda permissions"
  type        = list(string)
}

variable "kms_principal_lambda" {
  description = "Principal for KMS permissions"
  type        = string
}

# Comparison Store Lambda variables (renombradas)
variable "comparison_store_function_name" {
  description = "Name of the comparison store Lambda function"
  type        = string
}

variable "comparison_store_description" {
  description = "Description of the comparison store Lambda function"
  type        = string
}

variable "comparison_store_s3_key" {
  description = "S3 key for comparison store Lambda function code"
  type        = string
}

variable "comparison_store_tags" {
  description = "Tags for comparison store Lambda"
  type        = map(string)
}

# Comparison User Lambda variables (nuevas)
variable "comparison_user_function_name" {
  description = "Name of the comparison user Lambda function"
  type        = string
}

variable "comparison_user_description" {
  description = "Description of the comparison user Lambda function"
  type        = string
}

variable "comparison_user_s3_key" {
  description = "S3 key for comparison user Lambda function code"
  type        = string
}

variable "comparison_user_tags" {
  description = "Tags for comparison user Lambda"
  type        = map(string)
}

# SQS permissions variables
variable "sqs_statement_id" {
  description = "Statement ID for SQS permissions"
  type        = string
}

variable "sqs_actions" {
  description = "List of SQS actions for permissions"
  type        = list(string)
}

variable "sqs_principal" {
  description = "Principal for SQS permissions"
  type        = string
}

variable "batch_size" {
  description = "The largest number of records that Lambda will retrieve from SQS at once"
  type        = number
}

variable "maximum_batching_window_in_seconds" {
  description = "The maximum amount of time to gather records before invoking the function"
  type        = number
}

variable "sqs_trigger_enabled" {
  description = "Determines if the event source mapping is enabled"
  type        = bool
}
# Normalization Store Lambda variables (renombradas)
variable "normalization_store_function_name" {
  description = "Name of the normalization store Lambda function"
  type        = string
}

variable "normalization_store_description" {
  description = "Description of the normalization store Lambda function"
  type        = string
}

variable "normalization_store_s3_key" {
  description = "S3 key for normalization store Lambda function code"
  type        = string
}

variable "normalization_store_tags" {
  description = "Tags for normalization store Lambda"
  type        = map(string)
}

# Normalization User Lambda variables (nuevas)
variable "normalization_user_function_name" {
  description = "Name of the normalization user Lambda function"
  type        = string
}

variable "normalization_user_description" {
  description = "Description of the normalization user Lambda function"
  type        = string
}

variable "normalization_user_s3_key" {
  description = "S3 key for normalization user Lambda function code"
  type        = string
}

variable "normalization_user_tags" {
  description = "Tags for normalization user Lambda"
  type        = map(string)
}

# Variables para Cognito
variable "cognito_statement_id" {
  description = "ID de declaración para el permiso de Cognito"
  type        = string
}

variable "cognito_actions" {
  description = "Acciones permitidas para Cognito"
  type        = list(string)
}

variable "cognito_principal" {
  description = "Principal para los permisos de Cognito"
  type        = string
  default     = "cognito-idp.amazonaws.com"
}

variable "secretsmanager_statement_id" {
  description = "Statement ID for the Secrets Manager IAM policy"
  type        = string
}

variable "secretsmanager_actions" {
  description = "Actions allowed for Secrets Manager"
  type        = list(string)
}

variable "secretsmanager_principal" {
  description = "Principal for Secrets Manager policy"
  type        = string
}

# Variables para API Gateway
variable "api_gateway_statement_id" {
  description = "ID de declaración para el permiso de API Gateway"
  type        = string
}

variable "api_gateway_actions" {
  description = "Acciones permitidas desde API Gateway"
  type        = list(string)
}

variable "api_gateway_principal" {
  description = "Principal para el permiso de API Gateway"
  type        = string
}

# variable "api_gateway_source_arn" {
#   description = "ARN de origen para el permiso de API Gateway"
#   type        = string
# }

# Variables para funciones API
variable "api_user_function_name" {
  description = "Nombre de la función Lambda para API Users"
  type        = string
}

variable "api_store_function_name" {
  description = "Nombre de la función Lambda para API Stores"
  type        = string
}

variable "api_user_description" {
  description = "Descripción de la función Lambda para API Users"
  type        = string
}

variable "api_store_description" {
  description = "Descripción de la función Lambda para API Stores"
  type        = string
}

variable "api_user_tags" {
  description = "Tags para la función Lambda de API Users"
  type        = map(string)
}

variable "api_store_tags" {
  description = "Tags para la función Lambda de API Stores"
  type        = map(string)
}

variable "api_user_s3_key" {
  description = "Clave S3 para el código de la función Lambda de API de usuarios"
  type        = string
}

variable "api_store_s3_key" {
  description = "Clave S3 para el código de la función Lambda de API de tiendas"
  type        = string
}

variable "api_authorizer_function_name" {
  description = "Name of the Lambda function for API authorizer"
  type        = string
}

variable "api_authorizer_description" {
  description = "Description for the API authorizer Lambda function"
  type        = string
}

variable "api_authorizer_s3_key" {
  description = "S3 key for the API authorizer Lambda function code"
  type        = string
}

variable "api_authorizer_tags" {
  description = "Tags for the API authorizer Lambda function"
  type        = map(string)
}

# Actualiza el módulo de API Gateway para utilizar las nuevas Lambdas
variable "users_lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda para el endpoint de usuarios"
  type        = string
}

variable "stores_lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda para el endpoint de tiendas"
  type        = string
}

# Token Lambda Variables
variable "token_function_name" {
  description = "Name of the token Lambda function"
  type        = string
}

variable "token_description" {
  description = "Description for the token Lambda function"
  type        = string
}

variable "token_s3_key" {
  description = "S3 key for the token Lambda function code"
  type        = string
}

variable "token_tags" {
  description = "Tags for the token Lambda function"
  type        = map(string)
}

# Refresh Token Lambda Variables
variable "refresh_token_function_name" {
  description = "Name of the refresh token Lambda function"
  type        = string
}

variable "refresh_token_description" {
  description = "Description for the refresh token Lambda function"
  type        = string
}

variable "refresh_token_s3_key" {
  description = "S3 key for the refresh token Lambda function code"
  type        = string
}

variable "refresh_token_tags" {
  description = "Tags for the refresh token Lambda function"
  type        = map(string)
}

# KMS permissions variables
variable "kms_statement_id" {
  description = "Statement ID for KMS permissions"
  type        = string
}

variable "kms_actions" {
  description = "List of KMS actions for permissions"
  type        = list(string)
}

variable "kms_principal" {
  description = "Principal for KMS permissions"
  type        = string
}

# Lambda layers
variable "cx_oracle_arn" {
  description = "ARN of cx_oracle Lambda layer"
  type        = string
}

variable "instaclient_layer" {
  description = "ARN of cx_oracle Lambda layer"
  type        = string
}

variable "boto3_arn" {
  description = "ARN of boto3 Lambda layer"
  type        = string
}

variable "pyjwt" {
  description = "ARN of pyjwt Lambda layer"
  type        = string
}

variable "jwt" {
  description = "ARN of jwt Lambda layer"
  type        = string
}

variable "cryptography" {
  description = "ARN of cryptography Lambda layer"
  type        = string
}

variable "requests" {
  description = "ARN of requests Lambda layer"
  type        = string
}
# ######################################################################
# # Recurso Security Group - Amazon 
# ######################################################################

# variable "vpc_id" {
#   type        = string
#   description = "VPC ID where security groups will be created"
# }

# VPC Endpoints variables
variable "dynamodb_vpc_endpoints" {
  description = "List of CIDR blocks for DynamoDB VPC endpoints"
  type        = list(string)
}

variable "s3_vpc_endpoints" {
  description = "List of CIDR blocks for S3 VPC endpoints"
  type        = list(string)
}

variable "sqs_vpc_endpoints" {
  description = "List of CIDR blocks for SQS VPC endpoints"
  type        = list(string)
}

variable "kms_vpc_endpoints" {
  description = "List of CIDR blocks for KMS VPC endpoints"
  type        = list(string)
}

variable "oci_endpoints" {
  description = "List of CIDR blocks for KMS VPC endpoints"
  type        = list(string)
}
variable "cidr_blocks_glue_jobs" {
  description = "List of CIDR blocks for Glue jobs"
  type        = list(string)
}
# Extraction Lambda Security Group variables
variable "extraction_lambda_sg_name" {
  description = "Name of the Extraction Lambda security group"
  type        = string
}

variable "extraction_lambda_sg_description" {
  description = "Description of the Extraction Lambda security group"
  type        = string
}

# variable "extraction_lambda_ingress_rules" {
#   description = "List of ingress rules for Extraction Lambda security group"
#   type        = list(any)
# }
variable "extraction_lambda_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}

variable "extraction_lambda_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}

variable "extraction_lambda_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}

variable "extraction_lambda_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}

variable "extraction_lambda_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}

variable "secretsmanager_vpc_endpoints" {
  description = "CIDR blocks for Secrets Manager VPC endpoints"
  type        = list(string)
}

variable "extraction_lambda_egress_description" {
  description = "Description for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_from_port" {
  description = "From port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_to_port" {
  description = "To port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_protocol" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_description_s3" {
  description = "Description for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_from_port_s3" {
  description = "From port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_to_port_s3" {
  description = "To port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_protocol_s3" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_description_https" {
  description = "Description for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_from_port_https" {
  description = "From port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_to_port_https" {
  description = "To port for Extraction Lambda egress rule"
  type        = number
}

variable "extraction_lambda_egress_protocol_https" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_acceess_oci" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_from_port_acceess_oci" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_to_port_acceess_oci" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

variable "extraction_lambda_egress_protocol_acceess_oci" {
  description = "Protocol for Extraction Lambda egress rule"
  type        = string
}

# Comparison Lambda Security Group variables
variable "comparison_lambda_sg_name" {
  description = "Name of the Comparison Lambda security group"
  type        = string
}

variable "comparison_lambda_sg_description" {
  description = "Description of the Comparison Lambda security group"
  type        = string
}

variable "comparison_lambda_ingress_rules" {
  description = "List of ingress rules for Comparison Lambda security group"
  type        = list(any)
  default     = []
}

variable "comparison_lambda_egress_description" {
  description = "Description for Comparison Lambda egress rule"
  type        = string
}

variable "comparison_lambda_egress_from_port" {
  description = "From port for Comparison Lambda egress rule"
  type        = number
}

variable "comparison_lambda_egress_to_port" {
  description = "To port for Comparison Lambda egress rule"
  type        = number
}

variable "comparison_lambda_egress_protocol" {
  description = "Protocol for Comparison Lambda egress rule"
  type        = string
}

# Normalization Lambda Security Group variables
variable "normalization_lambda_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}

variable "normalization_lambda_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}

variable "normalization_lambda_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}

variable "normalization_lambda_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}

variable "normalization_lambda_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}

variable "normalization_lambda_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}

variable "normalization_lambda_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}

# Extraction  Glue Job Security Group variables
variable "extraction_gluejobs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "extraction_gluejobs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "extraction_gluejobs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "extraction_gluejobs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "extraction_gluejobs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "extraction_gluejobs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "extraction_gluejobs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "extraction_gluejobs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "extraction_gluejobs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "extraction_gluejobs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "extraction_gluejobs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "extraction_gluejobs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}

## Variables para egress desde Glue hacia priceHistory
variable "extraction_gluejobs_egress_description_pricehistory" {
  description = "Description for extraction gluejobs egress rule to priceHistory"
  type        = string
}
variable "extraction_gluejobs_egress_from_port_pricehistory" {
  description = "From port for extraction gluejobs egress rule to priceHistory"
  type        = number
}
variable "extraction_gluejobs_egress_to_port_pricehistory" {
  description = "To port for extraction gluejobs egress rule to priceHistory"
  type        = number
}
variable "extraction_gluejobs_egress_protocol_pricehistory" {
  description = "Protocol for extraction gluejobs egress rule to priceHistory"
  type        = string
}

#  Impresión de precios - Security Group - Vcp Endpoints Ecr - SSM

variable "vpc_endpoints_sg_name" {
  description = "Name of the price printing NLB security group"
  type        = string
}
variable "vpc_endpoints_sg_description" {
  description = "Description of the price printing NLB security group"
  type        = string
}
variable "vpc_endpoints_ingress_rules" {
  description = "List of ingress rules for price printing NLB security group"
  type        = list(any)
  default     = []
}
variable "vpc_endpoints_egress_description" {
  description = "Description for price printing NLB egress rule"
  type        = string
}
variable "vpc_endpoints_egress_from_port" {
  description = "From port for price printing NLB egress rule"
  type        = number
}
variable "vpc_endpoints_egress_to_port" {
  description = "To port for price printing NLB egress rule"
  type        = number
}
variable "vpc_endpoints_egress_protocol" {
  description = "Protocol for price printing NLB egress rule"
  type        = string
}
variable "vpc_endpoints_ingress_description" {
  description = "Description for price printing NLB ingress rule"
  type        = string
}
variable "vpc_endpoints_ingress_from_port" {
  description = "From port for price printing NLB ingress rule"
  type        = number
}
variable "vpc_endpoints_ingress_to_port" {
  description = "To port for price printing NLB ingress rule"
  type        = number
}
variable "vpc_endpoints_ingress_protocol" {
  description = "Protocol for price printing NLB ingress rule"
  type        = string
}
variable "vpc_endpoints_ingress_self" {
  description = "Self reference for price printing NLB ingress rule"
  type        = bool
}
variable "cidr_blocks_vpc_endpoints" {
  description = "List of CIDR blocks for vpc Enpoints"
  type        = list(string)
}

# Materials Ecs Security Group variables
variable "materials_ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "materials_ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "materials_ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "materials_ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "materials_ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "materials_ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "materials_ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "materials_ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "materials_ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "materials_ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "materials_ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "materials_ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
variable "cidr_blocks_ecs" {
  description = "List of CIDR blocks for ECS"
  type        = list(string)
}
# Variables para nuevas reglas de Security Group - Materials desde Prices
variable "materials_ecs_ingress_description_prices" {
  description = "Description for materials ECS ingress rule from prices"
  type        = string
}
variable "materials_ecs_ingress_from_port_prices" {
  description = "From port for materials ECS ingress rule from prices"
  type        = number
}
variable "materials_ecs_ingress_to_port_prices" {
  description = "To port for materials ECS ingress rule from prices"
  type        = number
}
variable "materials_ecs_ingress_protocol_prices" {
  description = "Protocol for materials ECS ingress rule from prices"
  type        = string
}
variable "materials_ecs_ingress_self_prices" {
  description = "Self reference for materials ECS ingress rule from prices"
  type        = bool
}
# Variables para regla Materials desde Notes
variable "materials_ecs_ingress_description_notes" {
  description = "Description for materials ECS ingress rule from notes"
  type        = string
}
variable "materials_ecs_ingress_from_port_notes" {
  description = "From port for materials ECS ingress rule from notes"
  type        = number
}
variable "materials_ecs_ingress_to_port_notes" {
  description = "To port for materials ECS ingress rule from notes"
  type        = number
}
variable "materials_ecs_ingress_protocol_notes" {
  description = "Protocol for materials ECS ingress rule from notes"
  type        = string
}
variable "materials_ecs_ingress_self_notes" {
  description = "Self reference for materials ECS ingress rule from notes"
  type        = bool
}
## Variables para regla Materials desde priceshistory
variable "materials_ecs_ingress_description_priceshistory" {
  description = "Description for materials ECS ingress rule from priceshistory"
  type        = string
}
variable "materials_ecs_ingress_from_port_priceshistory" {
  description = "From port for materials ECS ingress rule from priceshistory"
  type        = number
}
variable "materials_ecs_ingress_to_port_priceshistory" {
  description = "To port for materials ECS ingress rule from priceshistory"
  type        = number
}
variable "materials_ecs_ingress_protocol_priceshistory" {
  description = "Protocol for materials ECS ingress rule from priceshistory"
  type        = string
}
variable "materials_ecs_ingress_self_priceshistory" {
  description = "Self reference for materials ECS ingress rule from priceshistory"
  type        = bool
}
#  Notes Ecs Security Group variables
variable "notes-ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "notes-ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "notes-ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "notes-ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "notes-ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "notes-ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "notes-ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "notes-ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "notes-ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "notes-ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "notes-ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "notes-ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
# Variables para nuevas reglas de Security Group - Notes desde Prices
variable "notes_ecs_ingress_description_prices" {
  description = "Description for notes ECS ingress rule from prices"
  type        = string
}
variable "notes_ecs_ingress_from_port_prices" {
  description = "From port for notes ECS ingress rule from prices"
  type        = number
}
variable "notes_ecs_ingress_to_port_prices" {
  description = "To port for notes ECS ingress rule from prices"
  type        = number
}
variable "notes_ecs_ingress_protocol_prices" {
  description = "Protocol for notes ECS ingress rule from prices"
  type        = string
}
variable "notes_ecs_ingress_self_prices" {
  description = "Self reference for notes ECS ingress rule from prices"
  type        = bool
}
## Variables para nuevas reglas de Security Group - Notes desde priceshistory
variable "notes_ecs_ingress_description_priceshistory" {
  description = "Description for notes ECS ingress rule from priceshistory"
  type        = string
}
variable "notes_ecs_ingress_from_port_priceshistory" {
  description = "From port for notes ECS ingress rule from priceshistory"
  type        = number
}
variable "notes_ecs_ingress_to_port_priceshistory" {
  description = "To port for notes ECS ingress rule from priceshistory"
  type        = number
}
variable "notes_ecs_ingress_protocol_priceshistory" {
  description = "Protocol for notes ECS ingress rule from priceshistory"
  type        = string
}
variable "notes_ecs_ingress_self_priceshistory" {
  description = "Self reference for notes ECS ingress rule from priceshistory"
  type        = bool
}
# Variables para egress adicionales - Notes al NLB
variable "notes_ecs_egress_description_nlb" {
  description = "Description for notes ECS egress rule to NLB"
  type        = string
}
variable "notes_ecs_egress_from_port_nlb" {
  description = "From port for notes ECS egress rule to NLB"
  type        = number
}
variable "notes_ecs_egress_to_port_nlb" {
  description = "To port for notes ECS egress rule to NLB"
  type        = number
}
variable "notes_ecs_egress_protocol_nlb" {
  description = "Protocol for notes ECS egress rule to NLB"
  type        = string
}
#  Prices Ecs -  Security Group variables
variable "prices-ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "prices-ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "prices-ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "prices-ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "prices-ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "prices-ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "prices-ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "prices-ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "prices-ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "prices-ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "prices-ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "prices-ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
# Variables para egress adicionales - Prices a otros servicios
variable "prices_ecs_egress_description_materials" {
  description = "Description for prices ECS egress rule to materials"
  type        = string
}
variable "prices_ecs_egress_from_port_materials" {
  description = "From port for prices ECS egress rule to materials"
  type        = number
}
variable "prices_ecs_egress_to_port_materials" {
  description = "To port for prices ECS egress rule to materials"
  type        = number
}
variable "prices_ecs_egress_protocol_materials" {
  description = "Protocol for prices ECS egress rule to materials"
  type        = string
}
variable "prices_ecs_egress_description_notes" {
  description = "Description for prices ECS egress rule to notes"
  type        = string
}
variable "prices_ecs_egress_from_port_notes" {
  description = "From port for prices ECS egress rule to notes"
  type        = number
}
variable "prices_ecs_egress_to_port_notes" {
  description = "To port for prices ECS egress rule to notes"
  type        = number
}
variable "prices_ecs_egress_protocol_notes" {
  description = "Protocol for prices ECS egress rule to notes"
  type        = string
}
variable "prices_ecs_egress_description_segments" {
  description = "Description for prices ECS egress rule to priceTagSegments"
  type        = string
}
variable "prices_ecs_egress_from_port_segments" {
  description = "From port for prices ECS egress rule to priceTagSegments"
  type        = number
}
variable "prices_ecs_egress_to_port_segments" {
  description = "To port for prices ECS egress rule to priceTagSegments"
  type        = number
}
variable "prices_ecs_egress_protocol_segments" {
  description = "Protocol for prices ECS egress rule to priceTagSegments"
  type        = string
}
variable "prices_ecs_egress_description_rules" {
  description = "Description for prices ECS egress rule to priceTagRules"
  type        = string
}
variable "prices_ecs_egress_from_port_rules" {
  description = "From port for prices ECS egress rule to priceTagRules"
  type        = number
}
variable "prices_ecs_egress_to_port_rules" {
  description = "To port for prices ECS egress rule to priceTagRules"
  type        = number
}
variable "prices_ecs_egress_protocol_rules" {
  description = "Protocol for prices ECS egress rule to priceTagRules"
  type        = string
}
#  Impresión de precios - Security Group NLB
variable "price_printing_nlb_sg_name" {
  description = "Name of the price printing nlb security group"
  type        = string
}
variable "price_printing_nlb_sg_description" {
  description = "Description of the price printing nlb security group"
  type        = string
}
variable "price_printing_nlb_ingress_rules" {
  description = "List of ingress rules for price printing nlb security group"
  type        = list(any)
  default     = []
}
variable "price_printing_nlb_egress_description" {
  description = "Description for price printing nlb egress rule"
  type        = string
}
variable "price_printing_nlb_egress_from_port" {
  description = "From port for price printing nlb egress rule"
  type        = number
}
variable "price_printing_nlb_egress_to_port" {
  description = "To port for price printing nlb egress rule"
  type        = number
}
variable "price_printing_nlb_egress_protocol" {
  description = "Protocol for price printing nlb egress rule"
  type        = string
}
variable "price_printing_nlb_ingress_description" {
  description = "Description for price printing nlb ingress rule"
  type        = string
}
variable "price_printing_nlb_ingress_from_port" {
  description = "From port for price printing nlb ingress rule"
  type        = number
}
variable "price_printing_nlb_ingress_to_port" {
  description = "To port for price printing nlb ingress rule"
  type        = number
}
variable "price_printing_nlb_ingress_protocol" {
  description = "Protocol for price printing nlb ingress rule"
  type        = string
}
variable "price_printing_nlb_ingress_self" {
  description = "Self reference for price printing nlb ingress rule"
  type        = bool
}
#  priceTagSegments Ecs -  Security Group variables
variable "priceTagSegments-ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "priceTagSegments-ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "priceTagSegments-ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "priceTagSegments-ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "priceTagSegments-ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "priceTagSegments-ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "priceTagSegments-ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "priceTagSegments-ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "priceTagSegments-ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "priceTagSegments-ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "priceTagSegments-ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "priceTagSegments-ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
# Variables para nuevas reglas de Security Group - PriceTagSegments desde Prices
variable "priceTagSegments_ecs_ingress_description_prices" {
  description = "Description for priceTagSegments ECS ingress rule from prices"
  type        = string
}
variable "priceTagSegments_ecs_ingress_from_port_prices" {
  description = "From port for priceTagSegments ECS ingress rule from prices"
  type        = number
}
variable "priceTagSegments_ecs_ingress_to_port_prices" {
  description = "To port for priceTagSegments ECS ingress rule from prices"
  type        = number
}
variable "priceTagSegments_ecs_ingress_protocol_prices" {
  description = "Protocol for priceTagSegments ECS ingress rule from prices"
  type        = string
}
variable "priceTagSegments_ecs_ingress_self_prices" {
  description = "Self reference for priceTagSegments ECS ingress rule from prices"
  type        = bool
}
## Variables para nuevas reglas de Security Group - PriceTagSegments desde Priceshistory
variable "priceTagSegments_ecs_ingress_description_priceshistory" {
  description = "Description for priceTagSegments ECS ingress rule from Priceshistory"
  type        = string
}
variable "priceTagSegments_ecs_ingress_from_port_priceshistory" {
  description = "From port for priceTagSegments ECS ingress rule from Priceshistory"
  type        = number
}
variable "priceTagSegments_ecs_ingress_to_port_priceshistory" {
  description = "To port for priceTagSegments ECS ingress rule from Priceshistory"
  type        = number
}
variable "priceTagSegments_ecs_ingress_protocol_priceshistory" {
  description = "Protocol for priceTagSegments ECS ingress rule from Priceshistory"
  type        = string
}
variable "priceTagSegments_ecs_ingress_self_priceshistory" {
  description = "Self reference for priceTagSegments ECS ingress rule from Priceshistory"
  type        = bool
}
# Variables para egress adicionales - PriceTagSegments al NLB
variable "priceTagSegments_ecs_egress_description_nlb" {
  description = "Description for priceTagSegments ECS egress rule to NLB"
  type        = string
}
variable "priceTagSegments_ecs_egress_from_port_nlb" {
  description = "From port for priceTagSegments ECS egress rule to NLB"
  type        = number
}
variable "priceTagSegments_ecs_egress_to_port_nlb" {
  description = "To port for priceTagSegments ECS egress rule to NLB"
  type        = number
}
variable "priceTagSegments_ecs_egress_protocol_nlb" {
  description = "Protocol for priceTagSegments ECS egress rule to NLB"
  type        = string
}
#  priceTagRules Ecs -  Security Group variables
variable "priceTagRules-ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "priceTagRules-ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "priceTagRules-ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "priceTagRules-ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "priceTagRules-ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "priceTagRules-ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "priceTagRules-ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "priceTagRules-ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "priceTagRules-ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "priceTagRules-ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "priceTagRules-ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "priceTagRules-ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
# Variables para nuevas reglas de Security Group - PriceTagRules desde Prices
variable "priceTagRules_ecs_ingress_description_prices" {
  description = "Description for priceTagRules ECS ingress rule from prices"
  type        = string
}
variable "priceTagRules_ecs_ingress_from_port_prices" {
  description = "From port for priceTagRules ECS ingress rule from prices"
  type        = number
}
variable "priceTagRules_ecs_ingress_to_port_prices" {
  description = "To port for priceTagRules ECS ingress rule from prices"
  type        = number
}
variable "priceTagRules_ecs_ingress_protocol_prices" {
  description = "Protocol for priceTagRules ECS ingress rule from prices"
  type        = string
}
variable "priceTagRules_ecs_ingress_self_prices" {
  description = "Self reference for priceTagRules ECS ingress rule from prices"
  type        = bool
}
# Variables para regla PriceTagRules desde PriceTagSegments
variable "priceTagRules_ecs_ingress_description_segments" {
  description = "Description for priceTagRules ECS ingress rule from priceTagSegments"
  type        = string
}
variable "priceTagRules_ecs_ingress_from_port_segments" {
  description = "From port for priceTagRules ECS ingress rule from priceTagSegments"
  type        = number
}
variable "priceTagRules_ecs_ingress_to_port_segments" {
  description = "To port for priceTagRules ECS ingress rule from priceTagSegments"
  type        = number
}
variable "priceTagRules_ecs_ingress_protocol_segments" {
  description = "Protocol for priceTagRules ECS ingress rule from priceTagSegments"
  type        = string
}
variable "priceTagRules_ecs_ingress_self_segments" {
  description = "Self reference for priceTagRules ECS ingress rule from priceTagSegments"
  type        = bool
}
## Variables para regla PriceTagRules desde PriceTagSegments
variable "priceTagRules_ecs_ingress_description_priceshistory" {
  description = "Description for priceTagRules ECS ingress rule from priceshistory"
  type        = string
}
variable "priceTagRules_ecs_ingress_from_port_priceshistory" {
  description = "From port for priceTagRules ECS ingress rule from priceshistory"
  type        = number
}
variable "priceTagRules_ecs_ingress_to_port_priceshistory" {
  description = "To port for priceTagRules ECS ingress rule from priceshistory"
  type        = number
}
variable "priceTagRules_ecs_ingress_protocol_priceshistory" {
  description = "Protocol for priceTagRules ECS ingress rule from priceshistory"
  type        = string
}
variable "priceTagRules_ecs_ingress_self_priceshistory" {
  description = "Self reference for priceTagRules ECS ingress rule from priceshistory"
  type        = bool
}
#  priceHistory Ecs -  Security Group variables
variable "priceHistory-ecs_sg_name" {
  description = "Name of the Normalization Lambda security group"
  type        = string
}
variable "priceHistory-ecs_sg_description" {
  description = "Description of the Normalization Lambda security group"
  type        = string
}
variable "priceHistory-ecs_ingress_rules" {
  description = "List of ingress rules for Normalization Lambda security group"
  type        = list(any)
  default     = []
}
variable "priceHistory-ecs_egress_description" {
  description = "Description for Normalization Lambda egress rule"
  type        = string
}
variable "priceHistory-ecs_egress_from_port" {
  description = "From port for Normalization Lambda egress rule"
  type        = number
}
variable "priceHistory-ecs_egress_to_port" {
  description = "To port for Normalization Lambda egress rule"
  type        = number
}
variable "priceHistory-ecs_egress_protocol" {
  description = "Protocol for Normalization Lambda egress rule"
  type        = string
}
variable "priceHistory-ecs_ingress_description" {
  description = "Description for extraction lambda ingress rule"
  type        = string
}
variable "priceHistory-ecs_ingress_from_port" {
  description = "From port for extraction lambda ingress rule"
  type        = number
}
variable "priceHistory-ecs_ingress_to_port" {
  description = "To port for extraction lambda ingress rule"
  type        = number
}
variable "priceHistory-ecs_ingress_protocol" {
  description = "Protocol for extraction lambda ingress rule"
  type        = string
}
variable "priceHistory-ecs_ingress_self" {
  description = "Self reference for extraction lambda ingress rule"
  type        = bool
}
# Variables para nuevas reglas de Security Group - priceHistory desde Prices
variable "priceHistory_ecs_ingress_description_prices" {
  description = "Description for priceHistory ECS ingress rule from prices"
  type        = string
}
variable "priceHistory_ecs_ingress_from_port_prices" {
  description = "From port for priceHistory ECS ingress rule from prices"
  type        = number
}
variable "priceHistory_ecs_ingress_to_port_prices" {
  description = "To port for priceHistory ECS ingress rule from prices"
  type        = number
}
variable "priceHistory_ecs_ingress_protocol_prices" {
  description = "Protocol for priceHistory ECS ingress rule from prices"
  type        = string
}
variable "priceHistory_ecs_ingress_self_prices" {
  description = "Self reference for priceHistory ECS ingress rule from prices"
  type        = bool
}
# Variables para regla priceHistory desde PriceTagSegments
variable "priceHistory_ecs_ingress_description_segments" {
  description = "Description for priceHistory ECS ingress rule from priceTagSegments"
  type        = string
}
variable "priceHistory_ecs_ingress_from_port_segments" {
  description = "From port for priceHistory ECS ingress rule from priceTagSegments"
  type        = number
}
variable "priceHistory_ecs_ingress_to_port_segments" {
  description = "To port for priceHistory ECS ingress rule from priceTagSegments"
  type        = number
}
variable "priceHistory_ecs_ingress_protocol_segments" {
  description = "Protocol for priceHistory ECS ingress rule from priceTagSegments"
  type        = string
}
variable "priceHistory_ecs_ingress_self_segments" {
  description = "Self reference for priceHistory ECS ingress rule from priceTagSegments"
  type        = bool
}
## Variables para regla priceHistory desde Sg de Glue
variable "priceHistory_ecs_ingress_description_glue" {
  description = "Description for priceHistory ECS ingress rule from Sg de Glue"
  type        = string
}
variable "priceHistory_ecs_ingress_from_port_glue" {
  description = "From port for priceHistory ECS ingress rule from Sg de Glue"
  type        = number
}
variable "priceHistory_ecs_ingress_to_port_glue" {
  description = "To port for priceHistory ECS ingress rule from Sg de Glue"
  type        = number
}
variable "priceHistory_ecs_ingress_protocol_glue" {
  description = "Protocol for priceHistory ECS ingress rule from Sg de Glue"
  type        = string
}
variable "priceHistory_ecs_ingress_self_glue" {
  description = "Self reference for priceHistory ECS ingress rule from Sg de Glue"
  type        = bool
}

# ######################################################################
# # S3 - Amazon 
# ######################################################################

# Lambda bucket variables
variable "lambda_bucket_name" {
  description = "Name of the Lambda code bucket"
  type        = string
}

variable "lambda_bucket_description" {
  description = "Description of the Lambda code bucket"
  type        = string
}

variable "lambda_versioning_enabled" {
  description = "Enable versioning for Lambda code bucket"
  type        = bool
}

variable "lambda_sse_enabled" {
  description = "Enable server-side encryption for Lambda code bucket"
  type        = bool
}

variable "lambda_lifecycle_rules" {
  description = "Lifecycle rules for Lambda code bucket"
  type = list(object({
    id      = string
    enabled = bool
    noncurrent_version_expiration = object({
      days = number
    })
  }))
}

variable "lambda_cors_rules" {
  description = "CORS rules for Lambda code bucket"
  type        = list(any)
  default     = []
}

variable "lambda_statement_sid" {
  description = "Statement ID for Lambda bucket policy"
  type        = string
}

variable "lambda_statement_actions" {
  description = "Actions for Lambda bucket policy"
  type        = list(string)
}

variable "lambda_statement_effect" {
  description = "Effect for Lambda bucket policy"
  type        = string
}

variable "lambda_statement_type" {
  description = "Principal type for Lambda bucket policy"
  type        = string
}

variable "lambda_statement_identifiers" {
  description = "Principal identifiers for Lambda bucket policy"
  type        = list(string)
}

variable "lambda_statement_conditions" {
  description = "Conditions for Lambda bucket policy"
  type        = list(any)
  default     = []
}

# External data bucket variables
variable "external_bucket_name" {
  description = "Name of the external data bucket"
  type        = string
}

variable "external_bucket_description" {
  description = "Description of the external data bucket"
  type        = string
}

variable "external_versioning_enabled" {
  description = "Enable versioning for external data bucket"
  type        = bool
}

variable "external_sse_enabled" {
  description = "Enable server-side encryption for external data bucket"
  type        = bool
}

variable "external_lifecycle_rules" {
  description = "Lifecycle rules for external data bucket"
  type = list(object({
    id      = string
    enabled = bool
    transition = object({
      days          = number
      storage_class = string
    })
  }))
}

variable "enable_notifications" {
  description = "allows the creation of notifications"
  type        = bool
}

variable "external_cors_rules" {
  description = "CORS rules for external data bucket"
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
}

variable "external_statement_sid" {
  description = "Statement ID for external data bucket policy"
  type        = string
}

variable "external_statement_actions" {
  description = "Actions for external data bucket policy"
  type        = list(string)
}

variable "external_statement_effect" {
  description = "Effect for external data bucket policy"
  type        = string
}

variable "external_statement_type" {
  description = "Principal type for external data bucket policy"
  type        = string
}

# variable "external_statement_identifiers" {
#   description = "Principal identifiers for external data bucket policy"
#   type        = list(string)
# }

variable "external_statement_conditions" {
  description = "Conditions for external data bucket policy"
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
}

# variable "external_notification_statement_sid" {
#   description = "Statement ID for S3 notification permissions"
#   type        = string
# }

# # variable "external_notification_statement_actions" {
# #   description = "Actions for S3 notification permissions"
# #   type        = list(string)
# # }

# variable "external_notification_statement_effect" {
#   description = "Effect for S3 notification permissions"
#   type        = string
# }

# variable "external_notification_statement_type" {
#   description = "Principal type for S3 notification permissions"
#   type        = string
# }

# variable "external_notification_statement_identifiers" {
#   description = "Principal identifiers for S3 notification permissions"
#   type        = list(string)
# }

# variable "external_notification_statement_conditions" {
#   description = "Conditions for external data bucket policy"
#   type = list(object({
#     test     = string
#     variable = string
#     values   = list(string)
#   }))
# }


# glue bucket variables
variable "glue_bucket_name" {
  description = "Name of the bucket for glue job"
  type        = string
}
variable "glue_bucket_description" {
  description = "Description of the glue bucket"
  type        = string
}
variable "glue_versioning_enabled" {
  description = "Enable versioning the bucket for glue job"
  type        = bool
}
variable "glue_sse_enabled" {
  description = "Enable server-side encryption the bucket for glue job"
  type        = bool
}
variable "glue_lifecycle_rules" {
  description = "Lifecycle rules the bucket for glue job"
  type = list(object({
    id      = string
    enabled = bool
    noncurrent_version_expiration = object({
      days = number
    })
  }))
}
variable "glue_cors_rules" {
  description = "CORS rules the bucket for glue job"
  type        = list(any)
  default     = []
}
variable "glue_statement_sid" {
  description = "Statement ID the bucket policy for glue job"
  type        = string
}
variable "glue_statement_actions" {
  description = "Actions for glue bucket policy"
  type        = list(string)
}
variable "glue_statement_effect" {
  description = "Effect for glue bucket policy"
  type        = string
}
variable "glue_statement_type" {
  description = "Principal type for glue bucket policy"
  type        = string
}
variable "glue_statement_identifiers" {
  description = "Principal identifiers for glue bucket policy"
  type        = list(string)
}
variable "glue_statement_conditions" {
  description = "Conditions for glue bucket policy"
  type        = list(any)
  default     = []
}
# glue_general bucket variables
variable "glue_general_bucket_name" {
  description = "Name of the bucket for glue_general job"
  type        = string
}
variable "glue_general_bucket_description" {
  description = "Description of the glue_general bucket"
  type        = string
}
variable "glue_general_versioning_enabled" {
  description = "Enable versioning the bucket for glue_general job"
  type        = bool
}
variable "glue_general_sse_enabled" {
  description = "Enable server-side encryption the bucket for glue_general job"
  type        = bool
}
variable "glue_general_lifecycle_rules" {
  description = "Lifecycle rules the bucket for glue_general job"
  type = list(object({
    id      = string
    enabled = bool
    noncurrent_version_expiration = object({
      days = number
    })
  }))
}
variable "glue_general_cors_rules" {
  description = "CORS rules the bucket for glue_general job"
  type        = list(any)
  default     = []
}
variable "glue_general_statement_sid" {
  description = "Statement ID the bucket policy for glue_general job"
  type        = string
}
variable "glue_general_statement_actions" {
  description = "Actions for glue_general bucket policy"
  type        = list(string)
}
variable "glue_general_statement_effect" {
  description = "Effect for glue_general bucket policy"
  type        = string
}
variable "glue_general_statement_type" {
  description = "Principal type for glue_general bucket policy"
  type        = string
}
variable "glue_general_statement_identifiers" {
  description = "Principal identifiers for glue_general bucket policy"
  type        = list(string)
}
variable "glue_general_statement_conditions" {
  description = "Conditions for glue_general bucket policy"
  type        = list(any)
  default     = []
}
# logs_trivi bucket variables
variable "logs_trivi_bucket_name" {
  description = "Name of the bucket for logs_trivi job"
  type        = string
}
variable "logs_trivi_bucket_description" {
  description = "Description of the logs_trivi bucket"
  type        = string
}
variable "logs_trivi_versioning_enabled" {
  description = "Enable versioning the bucket for logs_trivi job"
  type        = bool
}
variable "logs_trivi_sse_enabled" {
  description = "Enable server-side encryption the bucket for logs_trivi job"
  type        = bool
}
variable "logs_trivi_lifecycle_rules" {
  description = "Lifecycle rules the bucket for logs_trivi job"
  type = list(object({
    id      = string
    enabled = bool
    noncurrent_version_expiration = object({
      days = number
    })
  }))
}
variable "logs_trivi_cors_rules" {
  description = "CORS rules the bucket for logs_trivi job"
  type        = list(any)
  default     = []
}
variable "logs_trivi_statement_sid" {
  description = "Statement ID the bucket policy for logs_trivi job"
  type        = string
}
variable "logs_trivi_statement_actions" {
  description = "Actions for logs_trivi bucket policy"
  type        = list(string)
}
variable "logs_trivi_statement_effect" {
  description = "Effect for logs_trivi bucket policy"
  type        = string
}
variable "logs_trivi_statement_type" {
  description = "Principal type for logs_trivi bucket policy"
  type        = string
}
variable "logs_trivi_statement_identifiers" {
  description = "Principal identifiers for logs_trivi bucket policy"
  type        = list(string)
}
variable "logs_trivi_statement_conditions" {
  description = "Conditions for logs_trivi bucket policy"
  type        = list(any)
  default     = []
}
# Step Function bucket variables
variable "stepfunction_bucket_name" {
  description = "Name of the bucket for stepfunction job"
  type        = string
}
variable "stepfunction_bucket_description" {
  description = "Description of the stepfunction bucket"
  type        = string
}
variable "stepfunction_versioning_enabled" {
  description = "Enable versioning the bucket for stepfunction job"
  type        = bool
}
variable "stepfunction_sse_enabled" {
  description = "Enable server-side encryption the bucket for stepfunction job"
  type        = bool
}
variable "stepfunction_lifecycle_rules" {
  description = "Lifecycle rules the bucket for stepfunction job"
  type = list(object({
    id      = string
    enabled = bool
    noncurrent_version_expiration = object({
      days = number
    })
  }))
}
variable "stepfunction_cors_rules" {
  description = "CORS rules the bucket for stepfunction job"
  type        = list(any)
  default     = []
}
variable "stepfunction_statement_sid" {
  description = "Statement ID the bucket policy for stepfunction job"
  type        = string
}
variable "stepfunction_statement_actions" {
  description = "Actions for stepfunction bucket policy"
  type        = list(string)
}
variable "stepfunction_statement_effect" {
  description = "Effect for stepfunction bucket policy"
  type        = string
}
variable "stepfunction_statement_type" {
  description = "Principal type for stepfunction bucket policy"
  type        = string
}
variable "stepfunction_statement_identifiers" {
  description = "Principal identifiers for stepfunction bucket policy"
  type        = list(string)
}
variable "stepfunction_statement_conditions" {
  description = "Conditions for stepfunction bucket policy"
  type        = list(any)
  default     = []
}


# ######################################################################
# # Recurso EventBridge - Amazon 
# ######################################################################

# variables.tf
variable "event_rule_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "event_rule_description" {
  description = "Description of the EventBridge rule"
  type        = string
}

variable "schedule_cron" {
  description = "Cron expression for the EventBridge rule schedule"
  type        = string
}

variable "event_target_id" {
  description = "ID for the EventBridge target permission statement"
  type        = string
}

variable "event_rule_lambda_action" {
  description = "Lambda action for the EventBridge rule"
  type        = string
}

variable "event_rule_lambda_principal" {
  description = "Principal for the EventBridge rule Lambda permission"
  type        = string
}

# Step Functions EventBridge variables
variable "stepfunction_rule_name" {
  description = "Name of the EventBridge rule for Step Functions"
  type        = string
}
variable "stepfunction_rule_description" {
  description = "Description of the EventBridge rule for Step Functions"
  type        = string
}
variable "stepfunction_schedule_cron" {
  description = "Cron expression for the Step Functions EventBridge rule schedule"
  type        = string
}
variable "stepfunction_role_arn" {
  description = "ARN of the IAM role for EventBridge to execute Step Functions (optional if Step Function module manages roles)"
  type        = string
  default     = null
}

# ######################################################################
# # SQS - Amazon 
# ######################################################################

# Nombres de colas SQS
variable "normalization_store_sqs_name" {
  description = "Name for the normalization store SQS queue"
  type        = string
}

variable "comparison_store_sqs_name" {
  description = "Name for the comparison store SQS queue"
  type        = string
}

variable "normalization_user_sqs_name" {
  description = "Name for the normalization user SQS queue"
  type        = string
}

variable "comparison_user_sqs_name" {
  description = "Name for the comparison user SQS queue"
  type        = string
}

# Configuraciones SQS
variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  type        = number
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type        = number
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message for main queue"
  type        = number
}

variable "dlq_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message for dead letter queue"
  type        = number
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive"
  type        = number
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  type        = number
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key for Amazon SQS"
  type        = string
}

variable "main_queue_dlq_enabled" {
  description = "Boolean designating if the main queue is a dead letter queue"
  type        = bool
}

variable "dlq_queue_dlq_enabled" {
  description = "Boolean designating if the DLQ queue is a dead letter queue"
  type        = bool
}

# Variables para el primer statement (Lambda)
variable "sqs_lambda_statement_sid" {
  description = "SID for Lambda SQS access"
  type        = string
}

variable "sqs_lambda_actions" {
  description = "Actions for Lambda SQS access"
  type        = list(string)
}

variable "sqs_lambda_effect" {
  description = "Effect for Lambda SQS access"
  type        = string
}

variable "sqs_lambda_type" {
  description = "Principal type for Lambda SQS access"
  type        = string
}

variable "sqs_lambda_identifiers" {
  description = "Principal identifiers for Lambda SQS access"
  type        = list(string)
}

variable "sqs_lambda_condition_test" {
  description = "Condition test for Lambda SQS access"
  type        = string
}

variable "sqs_lambda_condition_variable" {
  description = "Condition variable for Lambda SQS access"
  type        = string
}

variable "sqs_lambda_condition_values" {
  description = "Condition values for Lambda SQS access"
  type        = list(string)
}

# Variables para el segundo statement (S3)
variable "sqs_s3_statement_sid" {
  description = "SID for S3 SQS access"
  type        = string
}

variable "sqs_s3_actions" {
  description = "Actions for S3 SQS access"
  type        = list(string)
}

variable "sqs_s3_effect" {
  description = "Effect for S3 SQS access"
  type        = string
}

variable "sqs_s3_type" {
  description = "Principal type for S3 SQS access"
  type        = string
}

variable "sqs_s3_identifiers" {
  description = "Principal identifiers for S3 SQS access"
  type        = list(string)
}

variable "sqs_s3_condition_test" {
  description = "Condition test for S3 SQS access"
  type        = string
}

variable "sqs_s3_condition_variable" {
  description = "Condition variable for S3 SQS access"
  type        = string
}

variable "dlq_statements" {
  description = "IAM policy statements for dead letter queue"
  type = list(object({
    sid         = string
    actions     = list(string)
    resources   = list(string)
    effect      = string
    type        = string
    identifiers = list(string)
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
}
# ######################################################################
# # DynamoDB - Amazon 
# ######################################################################

# General DynamoDB variables
variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity"
  type        = string
}

variable "read_capacity" {
  description = "The number of read units for this table"
  type        = number
}

variable "write_capacity" {
  description = "The number of write units for this table"
  type        = number
}

variable "deletion_protection_enabled" {
  description = "Enables deletion protection for the table"
  type        = bool
}

variable "point_in_time_recovery" {
  description = "Enables point-in-time recovery for the table"
  type        = bool
}

variable "server_side_encryption_enabled" {
  description = "Enables server-side encryption for the table"
  type        = bool
}

# Users table variables
variable "users_table_name" {
  description = "Name of the users table"
  type        = string
}

variable "users_hash_key" {
  description = "Hash key for users table"
  type        = string
}

variable "users_range_key" {
  description = "Range key for users table"
  type        = string
}

variable "users_attributes" {
  description = "List of attribute definitions for users table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "users_replicas" {
  description = "List of replica configurations for users table"
  type        = list(any)
  default     = []
}

variable "users_gsi" {
  description = "Global Secondary Index configuration for users table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

# Products table variables
variable "products_table_name" {
  description = "Name of the products table"
  type        = string
}

variable "products_hash_key" {
  description = "Hash key for products table"
  type        = string
}

# variable "products_range_key" {
#   description = "Range key for products table"
#   type        = string
# }

variable "products_attributes" {
  description = "List of attribute definitions for products table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "products_replicas" {
  description = "List of replica configurations for products table"
  type        = list(any)
  default     = []
}

variable "products_gsi" {
  description = "Global Secondary Index configuration for products table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

# Orders table variables
variable "orders_table_name" {
  description = "Name of the orders table"
  type        = string
}

variable "orders_hash_key" {
  description = "Hash key for orders table"
  type        = string
}

variable "orders_range_key" {
  description = "Range key for orders table"
  type        = string
}

variable "orders_attributes" {
  description = "List of attribute definitions for orders table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "orders_replicas" {
  description = "List of replica configurations for orders table"
  type        = list(any)
  default     = []
}

# Application table variables (nueva)
variable "application_table_name" {
  description = "Name of the application table"
  type        = string
}

variable "application_hash_key" {
  description = "Hash key for application table"
  type        = string
}

variable "application_range_key" {
  description = "Range key for application table"
  type        = string
}

variable "application_attributes" {
  description = "List of attribute definitions for application table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "application_replicas" {
  description = "List of replica configurations for application table"
  type        = list(any)
  default     = []
}

variable "application_gsi" {
  description = "Global Secondary Index configuration for application table"
  type = list(object({
    name            = string
    hash_key        = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

# Endpoint table variables (nueva)
variable "endpoint_table_name" {
  description = "Name of the endpoint table"
  type        = string
}

variable "endpoint_hash_key" {
  description = "Hash key for endpoint table"
  type        = string
}

variable "endpoint_range_key" {
  description = "Range key for endpoint table"
  type        = string
}

variable "endpoint_attributes" {
  description = "List of attribute definitions for endpoint table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "endpoint_replicas" {
  description = "List of replica configurations for endpoint table"
  type        = list(any)
  default     = []
}

variable "endpoint_gsi" {
  description = "Global Secondary Index configuration for endpoint table"
  type = list(object({
    name            = string
    hash_key        = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

# App_Endpoint table variables (nueva)
variable "app_endpoint_table_name" {
  description = "Name of the app_endpoint table"
  type        = string
}

variable "app_endpoint_hash_key" {
  description = "Hash key for app_endpoint table"
  type        = string
}

variable "app_endpoint_range_key" {
  description = "Range key for app_endpoint table"
  type        = string
}

variable "app_endpoint_attributes" {
  description = "List of attribute definitions for app_endpoint table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "app_endpoint_replicas" {
  description = "List of replica configurations for app_endpoint table"
  type        = list(any)
  default     = []
}

variable "app_endpoint_gsi" {
  description = "Global Secondary Index configuration for app_endpoint table"
  type = list(object({
    name            = string
    hash_key        = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

# Text table variables (nueva)
variable "text_table_name" {
  description = "Name of the text table"
  type        = string
}

variable "text_hash_key" {
  description = "Hash key for text table"
  type        = string
}

# variable "text_range_key" {
#   description = "Range key for text table"
#   type        = string
# }

variable "text_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "text_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}

variable "text_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}


# Materials table variables (nueva)
variable "materials_table_name" {
  description = "Name of the materials table"
  type        = string
}
variable "materials_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "materials_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "materials_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "materials_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "materials_gsi" {
  description = "Global Secondary Index configuration for materials table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = optional(number)
    write_capacity  = optional(number)
  }))
  default = []
}
# materials specific configuration variables
variable "materials_billing_mode" {
  description = "Billing mode for materials table"
  type        = string
}
variable "materials_deletion_protection_enabled" {
  description = "Deletion protection for materials table"
  type        = bool
}
variable "materials_point_in_time_recovery" {
  description = "Point in time recovery for materials table"
  type        = bool
}
variable "materials_server_side_encryption_enabled" {
  description = "Server side encryption for materials table"
  type        = bool
}
# price_history table variables (nueva)
variable "price_history_table_name" {
  description = "Name of the price_history table"
  type        = string
}
variable "price_history_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "price_history_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "price_history_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "price_history_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "price_history_gsi" {
  description = "Global Secondary Index configuration for price_history table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = optional(number)
    write_capacity  = optional(number)
  }))
  default = []
}
# price_history specific configuration variables
variable "price_history_billing_mode" {
  description = "Billing mode for price_history table"
  type        = string
}
variable "price_history_deletion_protection_enabled" {
  description = "Deletion protection for price_history table"
  type        = bool
}
variable "price_history_point_in_time_recovery" {
  description = "Point in time recovery for price_history table"
  type        = bool
}
variable "price_history_server_side_encryption_enabled" {
  description = "Server side encryption for price_history table"
  type        = bool
}
# note table variables (nueva)
variable "notes_table_name" {
  description = "Name of the note table"
  type        = string
}
variable "notes_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "note_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "notes_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "notes_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "notes_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}
# prices table variables (nueva)
variable "prices_table_name" {
  description = "Name of the prices table"
  type        = string
}
variable "prices_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "prices_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "prices_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "prices_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "prices_gsi" {
  description = "Global Secondary Index configuration for prices table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = optional(number)
    write_capacity  = optional(number)
  }))
  default = []
}
# prices specific configuration variables
variable "prices_billing_mode" {
  description = "Billing mode for prices table"
  type        = string
}
variable "prices_deletion_protection_enabled" {
  description = "Deletion protection for prices table"
  type        = bool
}
variable "prices_point_in_time_recovery" {
  description = "Point in time recovery for prices table"
  type        = bool
}
variable "prices_server_side_encryption_enabled" {
  description = "Server side encryption for prices table"
  type        = bool
}
# PriceTagSegment table variables (nueva)
variable "PriceTagSegment_table_name" {
  description = "Name of the prices table"
  type        = string
}
variable "PriceTagSegment_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "prices_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "PriceTagSegment_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "PriceTagSegment_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "PriceTagSegment_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}
# PriceTagRule table variables (nueva)
variable "PriceTagRule_table_name" {
  description = "Name of the prices table"
  type        = string
}
variable "PriceTagRule_hash_key" {
  description = "Hash key for text table"
  type        = string
}
# variable "prices_range_key" {
#   description = "Range key for text table"
#   type        = string
# }
variable "PriceTagRule_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}
variable "PriceTagRule_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}
variable "PriceTagRule_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

#### regionals table variables (nueva)
variable "regionals_table_name" {
  description = "Name of the prices table"
  type        = string
}

variable "regionals_hash_key" {
  description = "Hash key for text table"
  type        = string
}

# variable "prices_range_key" {
#   description = "Range key for text table"
#   type        = string
# }

variable "regionals_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "regionals_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}

variable "regionals_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}


#### matCenters table variables (nueva)
variable "matCenters_table_name" {
  description = "Name of the prices table"
  type        = string
}

variable "matCenters_hash_key" {
  description = "Hash key for text table"
  type        = string
}

# variable "prices_range_key" {
#   description = "Range key for text table"
#   type        = string
# }

variable "matCenters_attributes" {
  description = "List of attribute definitions for text table"
  type = list(object({
    name = string
    type = string
  }))
}

variable "matCenters_replicas" {
  description = "List of replica configurations for text table"
  type        = list(any)
  default     = []
}

variable "matCenters_gsi" {
  description = "Global Secondary Index configuration for text table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    read_capacity   = optional(number)
    write_capacity  = optional(number)
  }))
  default = []
}

# matCenters specific configuration variables
variable "matCenters_billing_mode" {
  description = "Billing mode for matCenters table"
  type        = string
}

# variable "matCenters_read_capacity" {
#   description = "Read capacity for matCenters table"
#   type        = number
# }

# variable "matCenters_write_capacity" {
#   description = "Write capacity for matCenters table"
#   type        = number
# }

variable "matCenters_deletion_protection_enabled" {
  description = "Deletion protection for matCenters table"
  type        = bool
}

variable "matCenters_point_in_time_recovery" {
  description = "Point in time recovery for matCenters table"
  type        = bool
}

variable "matCenters_server_side_encryption_enabled" {
  description = "Server side encryption for matCenters table"
  type        = bool
}

# ######################################################################
# # KMS - Amazon 
# ######################################################################
# General KMS variables
variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource"
  type        = number
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region or single-Region key"
  type        = bool
}

# DynamoDB KMS variables
variable "alias_dynamo" {
  description = "Alias name for DynamoDB KMS key"
  type        = string
}

variable "dynamo_description" {
  description = "Description for DynamoDB KMS key"
  type        = string
}

variable "dynamo_sid" {
  description = "SID for DynamoDB KMS key policy statement"
  type        = string
}

variable "dynamo_effect" {
  description = "Effect for DynamoDB KMS key policy statement"
  type        = string
}

variable "dynamo_kms_actions" {
  description = "List of KMS actions for DynamoDB key policy"
  type        = list(string)
}

variable "dynamo_principal_type" {
  description = "Principal type for DynamoDB KMS key policy"
  type        = string
}

variable "dynamo_principal_identifiers" {
  description = "List of principal identifiers for DynamoDB KMS key policy"
  type        = list(string)
}

variable "dynamo_conditions" {
  description = "List of conditions for DynamoDB KMS key policy"
  type        = list(any)
  default     = []
}

# S3 KMS variables
variable "alias_s3" {
  description = "Alias name for S3 KMS key"
  type        = string
}

variable "s3_description" {
  description = "Description for S3 KMS key"
  type        = string
}

variable "s3_sid" {
  description = "SID for S3 KMS key policy statement"
  type        = string
}

variable "s3_effect" {
  description = "Effect for S3 KMS key policy statement"
  type        = string
}

variable "s3_kms_actions" {
  description = "List of KMS actions for S3 key policy"
  type        = list(string)
}

variable "s3_principal_type" {
  description = "Principal type for S3 KMS key policy"
  type        = string
}

variable "s3_principal_identifiers" {
  description = "List of principal identifiers for S3 KMS key policy"
  type        = list(string)
}

variable "s3_conditions" {
  description = "List of conditions for S3 KMS key policy"
  type        = list(any)
  default     = []
}

# Variables adicionales para KMS de Secrets
variable "alias_secrets_api" {
  description = "Alias name for API Secrets KMS key"
  type        = string
}

variable "secrets_api_description" {
  description = "Description for API Secrets KMS key"
  type        = string
}

variable "secrets_api_sid" {
  description = "SID for API Secrets KMS key policy statement"
  type        = string
}

variable "secrets_api_effect" {
  description = "Effect for API Secrets KMS key policy statement"
  type        = string
}

variable "secrets_api_kms_actions" {
  description = "List of KMS actions for API Secrets key policy"
  type        = list(string)
}

variable "secrets_api_principal_type" {
  description = "Principal type for API Secrets KMS key policy"
  type        = string
}

variable "secrets_api_principal_identifiers" {
  description = "List of principal identifiers for API Secrets KMS key policy"
  type        = list(string)
}

variable "secrets_api_conditions" {
  description = "List of conditions for API Secrets KMS key policy"
  type        = list(any)
  default     = []
}

variable "alias_secrets_db" {
  description = "Alias name for DB Secrets KMS key"
  type        = string
}

variable "secrets_db_description" {
  description = "Description for DB Secrets KMS key"
  type        = string
}

variable "secrets_db_sid" {
  description = "SID for DB Secrets KMS key policy statement"
  type        = string
}

variable "secrets_db_effect" {
  description = "Effect for DB Secrets KMS key policy statement"
  type        = string
}

variable "secrets_db_kms_actions" {
  description = "List of KMS actions for DB Secrets key policy"
  type        = list(string)
}

variable "secrets_db_principal_type" {
  description = "Principal type for DB Secrets KMS key policy"
  type        = string
}

variable "secrets_db_principal_identifiers" {
  description = "List of principal identifiers for DB Secrets KMS key policy"
  type        = list(string)
}

variable "secrets_db_conditions" {
  description = "List of conditions for DB Secrets KMS key policy"
  type        = list(any)
  default     = []
}

# Variables para permitir KMS a ecr
variable "alias_ecr" {
  description = "Alias name for ecr for KMS key"
  type        = string
}
variable "ecr_description" {
  description = "Description for ecr for KMS key"
  type        = string
}
variable "ecr_sid" {
  description = "SID for ecr for KMS key policy statement"
  type        = string
}
variable "ecr_effect" {
  description = "Effect for ecr for KMS key policy statement"
  type        = string
}
variable "ecr_kms_actions" {
  description = "List of KMS actions for ecr for key policy"
  type        = list(string)
}
variable "ecr_principal_type" {
  description = "Principal type for ecr for KMS key policy"
  type        = string
}
variable "ecr_principal_identifiers" {
  description = "List of principal identifiers for ecr for KMS key policy"
  type        = list(string)
}
variable "ecr_conditions" {
  description = "List of conditions for ecr for KMS key policy"
  type        = list(any)
  default     = []
}

# Variables para permitir el acceso de Lambda a DynamoDB KMS
variable "lambda_dynamo_sid" {
  description = "SID for Lambda access to DynamoDB KMS"
  type        = string
}

variable "lambda_dynamo_effect" {
  description = "Effect for Lambda access to DynamoDB KMS"
  type        = string
}

variable "lambda_dynamo_kms_actions" {
  description = "KMS actions allowed for Lambda"
  type        = list(string)
}

variable "lambda_dynamo_principal_type" {
  description = "Principal type for Lambda access"
  type        = string
}

variable "lambda_dynamo_principal_identifiers" {
  description = "Principal identifiers for Lambda access"
  type        = list(string)
}

variable "lambda_dynamo_conditions" {
  description = "Conditions for Lambda access to DynamoDB KMS"
  type        = list(map(any))
}

# ######################################################################
# # API Gateway - Amazon 
# ######################################################################

# variable "users_integration_lambda_name" {
#   description = "Name of the Lambda function to integrate with the users endpoint"
#   type        = string
# }

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "Description of the API Gateway"
  type        = string
}

variable "endpoint_types" {
  description = "List of endpoint types"
  type        = list(string)
  default     = ["REGIONAL"]
}

# variables.tf
# Resource configuration - V1 endpoint
variable "v1_path_part" {
  description = "Path part for v1 endpoint"
  type        = string
  default     = "v1"
}

variable "v1_path" {
  description = "Full path for v1 endpoint"
  type        = string
  default     = "v1"
}

variable "v1_parent_id" {
  description = "Parent ID for v1 endpoint"
  type        = string
  default     = null
}

# Resource configuration - Users endpoint
variable "users_path_part" {
  description = "Path part for users endpoint"
  type        = string
  default     = "users"
}

variable "users_path" {
  description = "Full path for users endpoint"
  type        = string
  default     = "v1/users"
}

variable "users_parent_id" {
  description = "Parent ID for users endpoint"
  type        = string
  default     = "v1"
}

# Method configuration
variable "users_http_method" {
  description = "HTTP method for users endpoint"
  type        = string
  default     = "GET"
}

variable "users_authorization" {
  description = "Authorization type for users endpoint"
  type        = string
  default     = "NONE"
}

variable "users_request_parameters" {
  description = "Request parameters for users endpoint"
  type        = map(bool)
  default     = {}
}

# Integration configuration
variable "users_integration_http_method" {
  description = "Integration HTTP method for users endpoint"
  type        = string
  default     = "POST"
}

variable "users_integration_type" {
  description = "Integration type for users endpoint"
  type        = string
  default     = "AWS_PROXY"
}

# variable "users_integration_uri" {
#   description = "Integration URI for users endpoint"
#   type        = string
# }

variable "users_integration_request_templates" {
  description = "Integration request templates for users endpoint"
  type        = map(string)
  default     = {}
}

# Response configuration
variable "users_response_status_code" {
  description = "Response status code for users endpoint"
  type        = string
  default     = "200"
}

variable "users_response_models" {
  description = "Response models for users endpoint"
  type        = map(string)
  default = {
    "application/json" = "Empty"
  }
}

variable "users_response_parameters" {
  description = "Response parameters for users endpoint"
  type        = map(bool)
  default     = {}
}

variable "users_integration_response_templates" {
  description = "Integration response templates for users endpoint"
  type        = map(string)
  default     = {}
}

variable "api_gateway_method_settings" {
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
# ######################################################################
# # Cognito - Amazon 
# ######################################################################

variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "username_attributes" {
  description = "List of attributes that can be used as username"
  type        = list(string)
  default     = ["email"]
}

variable "auto_verified_attributes" {
  description = "List of attributes to be auto-verified"
  type        = list(string)
  default     = ["email"]
}

variable "password_minimum_length" {
  description = "Minimum length of password"
  type        = number
  default     = 8
}

variable "password_require_lowercase" {
  description = "Whether to require lowercase letters in password"
  type        = bool
  default     = true
}

variable "password_require_numbers" {
  description = "Whether to require numbers in password"
  type        = bool
  default     = true
}

variable "password_require_symbols" {
  description = "Whether to require symbols in password"
  type        = bool
  default     = true
}

variable "password_require_uppercase" {
  description = "Whether to require uppercase letters in password"
  type        = bool
  default     = true
}

variable "password_temporary_validity_days" {
  description = "Number of days a temporary password is valid"
  type        = number
  default     = 7
}

variable "mfa_configuration" {
  description = "MFA configuration"
  type        = string
  default     = "OFF"
}

variable "sms_external_id" {
  description = "External ID for SMS configuration"
  type        = string
  default     = ""
}

variable "sms_caller_arn" {
  description = "ARN of the SNS caller"
  type        = string
  default     = ""
}

variable "email_sending_account" {
  description = "Email sending account type"
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "email_from_address" {
  description = "From email address"
  type        = string
  default     = null
}

variable "lambda_triggers" {
  description = "Map of Lambda triggers"
  type        = map(string)
  default     = {}
}

variable "schema_attributes" {
  description = "List of schema attributes"
  type = list(object({
    name                = string
    attribute_data_type = string
    mutable             = bool
    required            = bool
    min_length          = number
    max_length          = number
    min_value           = number
    max_value           = number
  }))
  default = []
}

variable "cognito_domain" {
  description = "Domain prefix for Cognito User Pool"
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "ARN of the certificate for custom domain"
  type        = string
  default     = null
}

variable "user_pool_clients" {
  description = "List of User Pool Clients"
  type = list(object({
    name                                 = string
    generate_secret                      = bool
    explicit_auth_flows                  = list(string)
    allowed_oauth_flows                  = list(string)
    allowed_oauth_flows_user_pool_client = bool
    allowed_oauth_scopes                 = list(string)
    callback_urls                        = list(string)
    logout_urls                          = list(string)
    supported_identity_providers         = list(string)
    prevent_user_existence_errors        = string
  }))
  default = []
}


# # ######################################################################
# # #  Secrets Manager - Amazon 
# # ######################################################################

# Project variables
variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before deleting the secret"
  type        = number
}

variable "force_overwrite_replica_secret" {
  description = "Replicate secret with existing name configuration"
  type        = bool
}

# API Secret variables
variable "api_secret_name" {
  description = "Name of the API secret"
  type        = string
}

variable "api_secret_description" {
  description = "Description of the API secret"
  type        = string
}

variable "api_secret_username" {
  description = "Username for API secret"
  type        = string
  sensitive   = true
}

variable "api_secret_password" {
  description = "Password for API secret"
  type        = string
  sensitive   = true
}

variable "api_version_stages" {
  description = "List of version stages for API secret"
  type        = list(string)
}

variable "api_secret_policy" {
  description = "IAM policy for API secret"
  type        = string
  default     = null
}

variable "api_replicas" {
  description = "List of replica configurations for API secret"
  type = list(object({
    region     = string
    kms_key_id = string
  }))
  default = null
}

# DB Secret variables
variable "db_secret_username" {
  description = "Username for DB secret"
  type        = string
  sensitive   = true
}

variable "db_secret_password" {
  description = "Password for DB secret"
  type        = string
  sensitive   = true
}

variable "db_secret_host" {
  description = "Host for DB secret"
  type        = string
  sensitive   = true
}

variable "db_secret_port" {
  description = "Port for DB secret"
  type        = number
  sensitive   = true
}

variable "db_secret_service_name" {
  description = "Port for DB secret"
  type        = string
  sensitive   = true
}


variable "db_secret_name" {
  description = "Name of the DB secret"
  type        = string
}

variable "db_secret_description" {
  description = "Description of the DB secret"
  type        = string
}

variable "db_version_stages" {
  description = "List of version stages for DB secret"
  type        = list(string)
}

variable "db_secret_policy" {
  description = "IAM policy for DB secret"
  type        = string
  default     = null
}

variable "db_replicas" {
  description = "List of replica configurations for DB secret"
  type = list(object({
    region     = string
    kms_key_id = string
  }))
  default = null
}

# Variables para la política del secreto de la base de datos
variable "db_secret_policy_version" {
  description = "Version de la política del secreto de la base de datos"
  type        = string
}

variable "db_secret_policy_effect" {
  description = "Effect para la política del secreto de la base de datos"
  type        = string
}

variable "db_secret_policy_principal_type" {
  description = "Tipo de principal para la política del secreto"
  type        = string
}

variable "db_secret_policy_principal_identifiers" {
  description = "Identificadores de principal para la política del secreto"
  type        = list(string)
}

variable "db_secret_policy_actions" {
  description = "Acciones permitidas para la política del secreto"
  type        = list(string)
}

variable "db_secret_policy_resource" {
  description = "Recurso para la política del secreto"
  type        = string
}

# Cognito Secret Variables
variable "cognito_secret_name" {
  description = "Name of the Cognito secret"
  type        = string
}

variable "cognito_secret_description" {
  description = "Description of the Cognito secret"
  type        = string
}

variable "alias_secrets_cognito" {
  description = "KMS key alias for Cognito secrets encryption"
  type        = string
  default     = "secrets-cognito"
}

variable "cognito_version_stages" {
  description = "List of version stages for the Cognito secret"
  type        = list(string)
}

variable "cognito_secret_policy" {
  description = "Policy for the Cognito secret"
  type        = string
}

variable "cognito_replicas" {
  description = "Replicas configuration for the Cognito secret"
  type = list(object({
    region     = string
    kms_key_id = string
  }))
}

variable "app_client_name" {
  description = "Name of the Cognito app client"
  type        = string
}

# # ######################################################################
# # #  WAF - Amazon Web Application Firewall 
# # ######################################################################

# General WAF Configuration
variable "waf_web_acl_name" {
  description = "Name of the WAF Web ACL"
  type        = string
}

variable "waf_web_acl_description" {
  description = "Description of the WAF Web ACL"
  type        = string
}

variable "waf_web_acl_scope" {
  description = "Scope of the WAF Web ACL (REGIONAL or CLOUDFRONT)"
  type        = string
  default     = "REGIONAL"
}

variable "waf_default_action" {
  description = "Default action for the WAF Web ACL (allow or block)"
  type        = string
  default     = "allow"
}

variable "waf_cloudwatch_metrics_enabled" {
  description = "Enable CloudWatch metrics for WAF Web ACL"
  type        = bool
  default     = true
}

variable "waf_metric_name" {
  description = "Metric name for WAF Web ACL"
  type        = string
}

variable "waf_sampled_requests_enabled" {
  description = "Enable sampled requests for WAF Web ACL"
  type        = bool
  default     = true
}

# Rate Limiting Configuration
variable "waf_rate_limit" {
  description = "Maximum number of requests allowed in a 5-minute period from one IP address"
  type        = number
  default     = 1000
}

# Geo Blocking Configuration
variable "waf_blocked_countries" {
  description = "List of country codes to block"
  type        = list(string)
  default     = []
}

# IP Allowlisting Configuration
variable "waf_allowed_ips" {
  description = "List of IP addresses/CIDR blocks to allow"
  type        = list(string)
  default     = []
}

# Rule Exclusions
variable "waf_excluded_rules_common" {
  description = "List of rule IDs to exclude from the AWS Common Rule Set"
  type        = list(string)
  default     = []
}

# Resource Association
# variable "waf_resource_arns" {
#   description = "Lista de IDs de API Gateway y sus etapas para asociar con el WAF Web ACL"
#   type = list(object({
#     api_id = string
#     stage  = string
#   }))
# }

variable "waf_resource_arns" {
  description = "ARN del recurso para asociar con el WAF Web ACL"
  type        = string
  default     = null
}

# Logging Configuration
variable "waf_log_destination_configs" {
  description = "List of Amazon Kinesis Data Firehose ARNs for WAF logging"
  type        = list(string)
  default     = null
}

variable "waf_redacted_fields" {
  description = "List of fields to redact from logging"
  type        = list(string)
  default     = ["Authorization"]
}



# # # ######################################################################
# # # #  Glue Job - ETL job for data processing
# # # ######################################################################
# Variable principal para la configuración de Glue
variable "glue_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias     = string
    job_type  = string
    bucket_id = string
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description         = optional(string)
    script_location     = optional(string)
    temp_location       = optional(string)
    spark_logs_location = optional(string)
    # Configuración para glueetl y glueray (opcionales)
    glue_version      = optional(string)
    worker_type       = optional(string)
    number_of_workers = optional(number)
    job_language      = optional(string)
    runtime           = optional(string) # Solo para glueray
    # Configuración para pythonshell (opcionales)
    max_capacity   = optional(number)
    python_version = optional(string)
    # CloudWatch logs (opcional)
    log_retention_days = optional(number)
    # AGREGAR AQUÍ - Conexiones (opcional)
    connections = optional(list(string))
    # Argumentos adicionales (opcional)
    additional_default_arguments = optional(map(string))
    # Configuración de políticas IAM personalizadas (opcional)
    iam_statements = optional(list(object({
      sid       = string
      effect    = string
      actions   = list(string)
      resources = list(string)
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })), [])
  }))
  description = "Configuration for Glue jobs"
}

# # # ######################################################################
# # # #  Glue Connetor - 
# # # ######################################################################
#Variable para la configuración de Glue Connections
variable "glue_connections_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias           = string
    connection_type = string
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description = optional(string)
    # Usar nombres directamente (se resuelven desde módulos)
    secrets_manager_secret_name = optional(string)    # Nombre del secret (ej: "database-credentials")
    subnet_names                = optional(list(string))  # Lista de nombres de subnets (ej: ["private2-1a", "private2-1b"])
    security_group_names        = optional(list(string))  # Lista de nombres de security groups
    # Mantener para compatibilidad hacia atrás
    secrets_manager_secret_arn = optional(string)
    # Configuración JDBC (opcional)
    jdbc_url                       = optional(string)
    class_name                     = optional(string)
    url_parameter_delimiter        = optional(string)
    require_ssl                    = optional(bool)
    skip_certificate_validation    = optional(bool)
    custom_jdbc_certificate        = optional(string)
    custom_jdbc_certificate_string = optional(string)
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
}

variable "available_connections" {
  type = map(object({
    name = string
    arn  = string
  }))
  description = "Map of available Glue connections from the connections module"
  default     = {}
}


# # ######################################################################
# # #  ECR Module
# # ######################################################################
variable "ecr_config" {
  type = list(object({
    alias = string
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
}


# # ######################################################################
# # #  ELB  - Elastic Load Balancing
# # ######################################################################
variable "lb_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias = string
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description                      = optional(string)
    internal                         = optional(bool)
    load_balancer_type               = optional(string)
    subnets                          = optional(list(string))
    idle_timeout                     = optional(number)
    drop_invalid_header_fields       = optional(bool)
    enable_deletion_protection       = optional(bool)
    enable_cross_zone_load_balancing = optional(bool)
    # WAF Association (opcional)
    waf_arn = optional(string)
    # Target Groups
    target_groups = list(object({
      target_application  = string
      port                = string
      protocol            = string
      vpc_id              = optional(string)
      target_type         = string
      healthy_threshold   = optional(string)
      interval            = optional(string)
      timeout             = optional(string)
      path                = optional(string)
      unhealthy_threshold = optional(string)
      matcher             = optional(string)
      protocol_version    = optional(string)
      stickiness = optional(object({
        enabled         = bool
        type            = string
        cookie_duration = optional(number)
        cookie_name     = optional(string)
      }))
    }))
    # Listeners
    listeners = list(object({
      protocol                = string
      port                    = string
      certificate_arn         = optional(string)
      default_target_group_id = string
      ssl_policy              = optional(string)
      # Listener Rules
      rules = optional(list(object({
        priority           = number
        target_application = string
        action = object({
          type = string
          redirect_config = optional(object({
            host        = optional(string)
            path        = optional(string)
            port        = optional(string)
            protocol    = optional(string)
            query       = optional(string)
            status_code = string
          }))
          fixed_response = optional(object({
            content_type = string
            message_body = optional(string)
            status_code  = string
          }))
        })
        conditions = list(object({
          host_headers = optional(list(object({
            headers = list(string)
          })), [])
          path_patterns = optional(list(object({
            patterns = list(string)
          })), [])
          http_headers = optional(list(object({
            name   = string
            values = list(string)
          })), [])
          query_strings = optional(list(object({
            key   = optional(string)
            value = string
          })), [])
          source_ips = optional(list(object({
            values = list(string)
          })), [])
        }))
      })), [])
    }))
  }))
  description = "Configuration for Application Load Balancers"
}


# # ######################################################################
# # #  Variables ECS Cluster - Elastic Container Service 
# # ######################################################################
variable "ecs_config" {
  type = list(object({
    alias                  = string
    description            = optional(string, "ECS Cluster")
    container_insights     = optional(string)
    enable_execute_command = optional(bool, false)
    service_connect_defaults = optional(object({
      namespace = string
    }))
  }))
  description = "Configuration for ECS clusters"
}

# Habilitar Service Discovery
variable "service_discovery_alias" {
  type        = string
  description = "Alias para services discovery"
  default     = null
}

# # ######################################################################
# # #  VARIABLES ECS Services - Elastic Container Service 
# # ######################################################################
variable "ecs_services" {
  description = "Configuración de servicios ECS - Ver módulo para estructura completa"
  type        = any
}

# # ######################################################################
# # #  Parameter Store - AWS Systems Manager Parameter Store
# # ######################################################################
variable "parameter_store_config" {
  type = list(object({
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
}
# # ######################################################################
# # #  Step Functions - AWS Step Functions State Machines
# # ######################################################################
variable "step_function_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias = string
    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description = optional(string)
    type        = optional(string) # "STANDARD" o "EXPRESS"
    # Configuración de definición (una de las dos debe estar presente)
    definition = optional(string)
    s3_definition = optional(object({
      bucket     = string
      key        = string
      version_id = optional(string)
    }))
    # Configuración de rol IAM
    role_arn = optional(string) # Si no se proporciona, se creará automáticamente
    # Configuración de logging (opcional)
    logging_configuration = optional(object({
      level                  = optional(string) # ALL, ERROR, FATAL, OFF
      include_execution_data = optional(bool, false)
      destinations = list(object({
        cloud_watch_logs_log_group = object({
          log_group_arn = string
        })
      }))
    }))
    # Configuración de X-Ray (opcional)
    tracing_configuration = optional(object({
      enabled = optional(bool, false)
    }))
    # CloudWatch logs (opcional)
    log_retention_days = optional(number)
    # Configuración de políticas IAM personalizadas (opcional)
    iam_statements = optional(list(object({
      sid       = string
      effect    = string
      actions   = list(string)
      resources = list(string)
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })), [])
  }))
  description = "Configuration for Step Functions"
  default     = []
}
