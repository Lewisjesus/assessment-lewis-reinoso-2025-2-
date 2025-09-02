# ######################################################################
# # Tags globales - Amazon 
# ######################################################################
aws_region = "us-east-1"
cost_center = "1234"
project = "reto"
environment = "dev"
domain = "banco"
owner = "lewis.reinoso@pragma.com.co"

resource_tags = {
  aws_region  = "us-east-1"
  cost_center = "1234"
  project     = "reto"
  environment = "dev"
  domain      = "banco"
  owner       = "lewis.reinoso@pragma.com.co"
}
#terraformer = "true"

# terraform.tfvars
# VPC Configuration
cidrblock              = "100.95.24.0/23"
vpc_name               = "vpc"
enable_dns_support     = true
enable_dns_hostnames   = true
instance_tenancy       = "default"

# Resource Names
igw_name      = "igw-01"
ngw_name      = "ngw-01"
eip_name      = "eip-ngw-01"
subnet_name   = "subnet"

# Descriptions
description           = "WEB Access"
description_sg        = "Trafico HTTP"
description_sg2       = "Habilita trafico terminal"
description_ingress   = "Private Security Group"
description_ingress2  = "Access from Public subnet"
description_ingress3  = "Acces from private DB Subnet"

endpoint_service_name = "com.amazonaws.us-east-1.s3"
endpoint_type         = "Gateway"
endpoint_policy       = null
endpoint_auto_accept  = true
endpoint_route_table_association_enabled = true

endpoint_service_name_secretmanager = "com.amazonaws.us-east-1.secretsmanager"
endpoint_type_secretmanager         = "Interface"
endpoint_policy_secretmanager       = null
endpoint_auto_accept_secretmanager  = true

# Subnet 1a Configuration
subnet_1a_name    = "private-1a"
subnet_1a_cidr    = "100.95.24.0/26"
subnet_1a_private = true
subnet_1a_tags = {
  Type = "Private"
}

# Subnet 1b Configuration
subnet_1b_name    = "private-1b"
subnet_1b_cidr    = "100.95.24.64/26"
subnet_1b_private = true
subnet_1b_tags = {
  Type = "Private"
}

# Subnet 1a Configuration - Impresión de precios 
subnet_1a_name_second_project    = "private2-1a"
subnet_1a_cidr_second_project    = "100.95.24.128/26"
subnet_1a_private_second_project = true
subnet_1a_tags_second_project = {
  Type = "Private"
}
# Subnet 1b Configuration - Impresión de precios 
subnet_1b_name_second_project    = "private2-1b"
subnet_1b_cidr_second_project    = "100.95.24.192/26"
subnet_1b_private_second_project = true
subnet_1b_tags_second_project = {
  Type = "Private"
}

# Route Configuration
route_cidr_block = "172.27.6.0/26"
route_cidr_block_new = "10.31.193.179/32"
route_cidr_block_db = "10.31.224.34/32"
id_tgw_db = "tgw-0bd989394e774bae9"
nat_gateway_id   = "nat"

# ######################################################################
# # Lambda - Amazon 
# ######################################################################
# terraform.tfvars
# Common Lambda configurations
lambda_runtime = "python3.11"
lambda_handler = "lambda_handler.lambda_handler"
memory_size = 256
timeout     = 300

# Extraction Store Lambda configurations (renombradas)
extraction_store_function_name = "extraction-store"
extraction_store_description = "Process data extraction for stores"
extraction_store_s3_key = "extraction_stores.zip"
extraction_store_tags = {
  Function = "Extraction-store"
}

# Extraction User Lambda configurations (nuevas)
extraction_user_function_name = "extraction-user"
extraction_user_description = "Process data extraction for users"
extraction_user_s3_key = "extraction_users.zip"
extraction_user_tags = {
  Function = "Extraction-user"
}

# DynamoDB permissions
dynamo_statement_id = "AllowDynamoAccess"
dynamo_actions     = ["dynamodb:*"]
dynamo_principal   = "dynamodb.amazonaws.com"

# S3 permissions
s3_statement_id = "AllowS3Access"
s3_actions      = ["s3:*"]
s3_principal    = "s3.amazonaws.com"

# kms permissions
kms_statement_id_lambda = "AllowKMSAccess"
kms_actions_lambda      = ["kms:GenerateDataKey", "kms:Decrypt"]
kms_principal_lambda    = "lambda.amazonaws.com"

# Comparison Store Lambda configurations (renombradas)
comparison_store_function_name = "comparison-store"
comparison_store_description = "Data comparison process for stores"
comparison_store_s3_key = "comparison_stores.zip"
comparison_store_tags = {
  Function = "Comparison-store"
}

# Comparison User Lambda configurations (nuevas)
comparison_user_function_name = "comparison-user"
comparison_user_description = "Data comparison process for users"
comparison_user_s3_key = "comparison_users.zip"
comparison_user_tags = {
  Function = "Comparison-user"
}

# SQS permissions
sqs_statement_id = "AllowSQSAccess"
sqs_actions      = ["sqs:*"]
sqs_principal    = "sqs.amazonaws.com"
batch_size = 10
maximum_batching_window_in_seconds =0
sqs_trigger_enabled = true

# Normalization Store Lambda configurations (renombradas)
normalization_store_function_name = "normalization-store"
normalization_store_description = "Data normalization process for stores"
normalization_store_s3_key = "normalization_stores.zip"
normalization_store_tags = {
  Function = "Normalization-store"
}

# Normalization User Lambda configurations (nuevas)
normalization_user_function_name = "normalization-user"
normalization_user_description = "Data normalization process for users"
normalization_user_s3_key = "normalization_users.zip"
normalization_user_tags = {
  Function = "Normalization-user"
}

# Variables para las nuevas funciones Lambda de API
api_user_function_name = "api-users-function"
api_store_function_name = "api-stores-function"
lambda_handler_api_store = "api_banco_stores_lambda.lambda_handler.lambda_handler"
api_user_s3_key = "api_users_function.zip"
api_store_s3_key  = "api_stores_function.zip"

# API Authorizer Lambda configuration
api_authorizer_function_name = "api-authorizer-function"
api_authorizer_description = "API Gateway request authorizer"
api_authorizer_s3_key = "api_authorizer_function.zip"
api_authorizer_tags = {
  Function = "API-Authorizer"
}

# Actualiza el módulo de API Gateway para utilizar las nuevas Lambdas
users_lambda_invoke_arn = ""
stores_lambda_invoke_arn = ""

# KMS permissions
kms_statement_id = "AllowKMSAccess"
kms_actions      = ["kms:*"]
kms_principal    = "kms.amazonaws.com"

# Lambda layers
cx_oracle_arn = "arn:aws:lambda:us-east-1:277707138325:layer:oracledb_layer:9"
instaclient_layer = "arn:aws:lambda:us-east-1:277707138325:layer:instaclient_layer:4"
boto3_arn = "arn:aws:lambda:us-east-1:277707138325:layer:boto3:1"
cryptography = "arn:aws:lambda:us-east-1:277707138325:layer:cryptography:1"
requests = "arn:aws:lambda:us-east-1:277707138325:layer:requests:1"
pyjwt = "arn:aws:lambda:us-east-1:277707138325:layer:pyJWT_layer_2:3"
jwt = "arn:aws:lambda:us-east-1:277707138325:layer:jwt_layer:3"

# Variables para Cognito
cognito_statement_id = "AllowCognitoAccess"
cognito_actions = [
  "cognito-idp:AdminGetUser",
  "cognito-idp:ListUsers"
]
cognito_principal = "cognito-idp.amazonaws.com"

secretsmanager_statement_id = "AllowSecretsManagerAccess"
secretsmanager_actions      = ["secretsmanager:GetSecretValue"]
secretsmanager_principal    = "secretsmanager.amazonaws.com"

# Variables para API Gateway
api_gateway_statement_id = "AllowAPIGatewayInvoke"
api_gateway_actions = ["lambda:InvokeFunction"]
api_gateway_principal = "apigateway.amazonaws.com"

# Variables para funciones API
api_user_description = "Lambda function to handle API Gateway requests for user data"
api_store_description = "Lambda function to handle API Gateway requests for store data"

api_user_tags = {
  Name        = "api-users-function"
}

api_store_tags = {
  Name        = "api-stores-function"
}

# Token Lambda Configuration
token_function_name = "login"
token_description   = "Lambda function to generate authorization tokens"
token_s3_key        = "login.zip"
token_tags          = {
  Name        = "login"
}

# Refresh Token Lambda Configuration
refresh_token_function_name = "refresh-token"
refresh_token_description   = "Lambda function to refresh authorization tokens"
refresh_token_s3_key        = "refresh_token.zip"
refresh_token_tags          = {
  Name        = "refresh-token"
}
# ######################################################################
# # Recurso Security Group - Amazon 
# ######################################################################
# terraform.tfvars
#["100.95.24.0/28", "100.95.24.16/28", "172.27.6.0/26"]
# VPC Endpoints CIDR blocks
dynamodb_vpc_endpoints       = ["172.27.6.0/26"]
s3_vpc_endpoints             = ["100.95.24.0/28", "100.95.24.16/28"]
sqs_vpc_endpoints            = ["100.95.24.0/28", "100.95.24.16/28"]
kms_vpc_endpoints            = ["100.95.24.0/28", "100.95.24.16/28"]
secretsmanager_vpc_endpoints = ["100.95.24.0/28", "100.95.24.16/28"]
oci_endpoints                = ["10.31.193.179/32"]

# Extraction Lambda Security Group
extraction_lambda_sg_name = "extraction-lambda"
extraction_lambda_sg_description = "Security group for Extraction Lambda function"

extraction_lambda_ingress_description = "Allow HTTPS from self for Secrets Manager"
extraction_lambda_ingress_from_port = 443
extraction_lambda_ingress_to_port = 443
extraction_lambda_ingress_protocol = "tcp"
extraction_lambda_ingress_self = true

#extraction_lambda_ingress_rules = []
extraction_lambda_egress_description = "Access to Oracle"
extraction_lambda_egress_from_port = 1521
extraction_lambda_egress_to_port = 1521
extraction_lambda_egress_protocol = "tcp"

extraction_lambda_egress_description_s3 = "Access to S3"
extraction_lambda_egress_from_port_s3 = 443
extraction_lambda_egress_to_port_s3 = 443
extraction_lambda_egress_protocol_s3 = "tcp"

extraction_lambda_egress_description_https = "interval through port 443"
extraction_lambda_egress_from_port_https = 443
extraction_lambda_egress_to_port_https = 443
extraction_lambda_egress_protocol_https = "tcp"

extraction_lambda_egress_acceess_oci = "Access to OCI"
extraction_lambda_egress_from_port_acceess_oci = 1521
extraction_lambda_egress_to_port_acceess_oci = 1521
extraction_lambda_egress_protocol_acceess_oci = "tcp"

# Comparison Lambda Security Group
comparison_lambda_sg_name = "comparison-lambda"
comparison_lambda_sg_description = "Security group for Comparison Lambda function"
comparison_lambda_ingress_rules = []
comparison_lambda_egress_description = "Access to SQS"
comparison_lambda_egress_from_port = 443
comparison_lambda_egress_to_port = 443
comparison_lambda_egress_protocol = "tcp"

# Normalization Lambda Security Group
normalization_lambda_sg_name = "normalization-lambda"
normalization_lambda_sg_description = "Security group for Normalization Lambda function"
normalization_lambda_ingress_rules = []
normalization_lambda_egress_description = "Access to KMS and S3"
normalization_lambda_egress_from_port = 443
normalization_lambda_egress_to_port = 443
normalization_lambda_egress_protocol = "tcp"

# ######################################################################
# # S3 - Amazon 
# ######################################################################

# terraform.tfvars
# Lambda bucket configuration
lambda_bucket_name        = "lambda-code"
lambda_bucket_description = "Store Lambda functions code"
lambda_versioning_enabled = true
lambda_sse_enabled        = true

lambda_lifecycle_rules = [
  {
    id      = "delete_old_versions"
    enabled = true
    noncurrent_version_expiration = {
      days = 30
    }
  }
]

lambda_cors_rules = []

lambda_statement_sid         = "AllowLambdaAccess"
lambda_statement_actions     = ["s3:GetObject"]
lambda_statement_effect      = "Allow"
lambda_statement_type        = "Service"
lambda_statement_identifiers = ["lambda.amazonaws.com"]
lambda_statement_conditions  = []

# External data bucket configuration
external_bucket_name        = "external-data"
external_bucket_description = "Store external database information"
external_versioning_enabled = true
external_sse_enabled        = true

external_lifecycle_rules = [
  {
    id      = "move_to_glacier"
    enabled = true
    transition = {
      days          = 90
      storage_class = "GLACIER"
    }
  }
]
enable_notifications = true

external_cors_rules = [
  {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
]

external_statement_sid         = "AllowLambdaPutObject"
external_statement_actions     = ["s3:PutObject"]
external_statement_effect      = "Allow"
external_statement_type        = "AWS"
external_statement_conditions  = []

s3_notification_events       = ["s3:ObjectCreated:*"]
s3_notification_filter_prefix = "stores/"

# ######################################################################
# # Recurso EventBridge - Amazon 
# ######################################################################

# terraform.tfvars
event_rule_name = "daily-process"
event_rule_description = "EventBridge rule to trigger Lambda function"
schedule_cron = "cron(0 12,19 ? * MON-SUN *)"
event_target_id = "AllowEventBridgeInvoke"
event_rule_lambda_action = "lambda:InvokeFunction"
event_rule_lambda_principal = "events.amazonaws.com"

# ######################################################################
# # SQS - Amazon 
# ######################################################################

# terraform.tfvars

# Nombres de colas SQS
normalization_store_sqs_name = "normalization-store-sqs"
comparison_store_sqs_name = "comparison-store-sqs"
normalization_user_sqs_name = "normalization-user-sqs"
comparison_user_sqs_name = "comparison-user-sqs"

# Configuraciones de SQS
delay_seconds                = 0
max_message_size             = 262144
message_retention_seconds     = 345600
dlq_message_retention_seconds = 1209600
receive_wait_time_seconds     = 20
visibility_timeout_seconds    = 300
fifo_queue                   = false
kms_master_key_id           = ""

# Dead Letter Queue configuration
main_queue_dlq_enabled = false
dlq_queue_dlq_enabled  = false

# Statement para Lambda
sqs_lambda_statement_sid        = "AllowLambdaAccess"
sqs_lambda_actions              = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
sqs_lambda_effect               = "Allow"
sqs_lambda_type                 = "Service"
sqs_lambda_identifiers          = ["lambda.amazonaws.com"]
sqs_lambda_condition_test       = "ArnLike"
sqs_lambda_condition_variable   = "aws:SourceArn"
sqs_lambda_condition_values     = ["arn:aws:lambda:*:*:function:order-processor"]

# Statement para S3
sqs_s3_statement_sid          = "AllowS3ToSendMessages"
sqs_s3_actions                = ["sqs:SendMessage"]
sqs_s3_effect                 = "Allow"
sqs_s3_type                   = "Service"
sqs_s3_identifiers            = ["s3.amazonaws.com"]
sqs_s3_condition_test         = "ArnLike"
sqs_s3_condition_variable     = "aws:SourceArn"

dlq_statements = [
  {
    sid         = "AllowCloudWatchAlarm"
    actions     = ["sqs:GetQueueAttributes", "sqs:ReceiveMessage"]
    resources   = ["*"]
    effect      = "Allow"
    type        = "Service"
    identifiers = ["cloudwatch.amazonaws.com"]
    condition   = []
  }
]

# ######################################################################
# # DynamoDB - Amazon 
# ######################################################################

# General DynamoDB configuration
billing_mode                    = "PROVISIONED"
read_capacity                   = 5
write_capacity                  = 5
deletion_protection_enabled     = false
point_in_time_recovery         = true
server_side_encryption_enabled  = true

# Users table configuration
users_table_name = "users"
users_hash_key   = "id_usuario"
users_range_key  = "email"
users_attributes = [
  {
    name = "id_usuario"
    type = "S"
  },
    {
    name = "tipo_registro"
    type = "S"
  },
  {
    name = "fecha_actualizacion"
    type = "S"
  }
]
users_replicas = []
users_gsi = [
  {
    name            = "id_usuario_index"
    hash_key        = "id_usuario"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "tipo_registro_fecha_actualizacion_index"
    hash_key        = "tipo_registro"
    range_key       = "fecha_actualizacion"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# Products table configuration
products_table_name = "store"
products_hash_key   = "id_cliente"
#products_range_key  = "fecha_actualizacion"
products_attributes = [
  {
    name = "id_cliente"
    type = "S"
  },
  {
    name = "tipo_registro"
    type = "S"
  },
  {
    name = "fecha_actualizacion"
    type = "S"
  }
]
products_replicas = []
products_gsi = [
  {
    name            = "id_cliente_index"
    hash_key        = "id_cliente"
    range_key       = ""  # Valor vacío para indicar que no hay range_key
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "tipo_registro_fecha_actualizacion_index"
    hash_key        = "tipo_registro"
    range_key       = "fecha_actualizacion"  # Aquí sí especificamos el range_key
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# Orders table configuration
orders_table_name = "new-store"
orders_hash_key   = "id"
orders_range_key  = "user_id"
orders_attributes = [
  {
    name = "id"
    type = "S"
  }
]
orders_replicas = []

# Application table configuration (nueva)
application_table_name = "application"
application_hash_key   = "app_id"
application_range_key  = "app_name"
application_attributes = [
  {
    name = "app_id"
    type = "S"
  }
]
application_replicas = []
application_gsi = [
  {
    name            = "app_id_index"
    hash_key        = "app_id"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# Endpoint table configuration (nueva)
endpoint_table_name = "endpoint"
endpoint_hash_key   = "endpoint_id"
endpoint_range_key  = "method"
endpoint_attributes = [
  {
    name = "endpoint_id"
    type = "S"
  }
]
endpoint_replicas = []
endpoint_gsi = [
  {
    name            = "endpoint_id_index"
    hash_key        = "endpoint_id"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# App_Endpoint table configuration (nueva)
app_endpoint_table_name = "permission"
app_endpoint_hash_key   = "app_id"
app_endpoint_range_key  = "endpoint_id"
app_endpoint_attributes = [
  {
    name = "app_id"
    type = "S"
  }
  # {
  #   name = "endpoint_id"
  #   type = "N"
  # }
]
app_endpoint_replicas = []
app_endpoint_gsi = [
  {
    name            = "app_id_index"
    hash_key        = "app_id"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# Text table configuration (nueva)
text_table_name = "token"
text_hash_key   = "text_id"
#text_range_key  = "language"
text_attributes = [
  {
    name = "text_id"
    type = "S"
  }
]
text_replicas = []
text_gsi = [
  {
    name            = "text_id_index"
    hash_key        = "text_id"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# ######################################################################
# # KMS - Amazon 
# ######################################################################

# terraform.tfvars

# General KMS configuration
deletion_window_in_days = 7
enable_key_rotation     = true
multi_region           = false

# DynamoDB KMS configuration
alias_dynamo                = "dynamo"
dynamo_description         = "KMS key for DynamoDB encryption"
dynamo_sid                 = "AllowDynamoDB"
dynamo_effect              = "Allow"
dynamo_kms_actions         = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
dynamo_principal_type      = "Service"
dynamo_principal_identifiers = ["dynamodb.amazonaws.com"]
dynamo_conditions          = []

# S3 KMS configuration
alias_s3                   = "s3"
s3_description            = "KMS key for S3 encryption"
s3_sid                    = "AllowS3"
s3_effect                 = "Allow"
s3_kms_actions            = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
s3_principal_type         = "Service"
s3_principal_identifiers  = ["s3.amazonaws.com"]
s3_conditions             = []

alias_secrets_api                = "secrets-api"
secrets_api_description         = "KMS key for API Secrets encryption"
secrets_api_sid                 = "AllowSecretsManagerAPI"
secrets_api_effect              = "Allow"
secrets_api_kms_actions         = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
secrets_api_principal_type      = "Service"
secrets_api_principal_identifiers = ["secretsmanager.amazonaws.com"]
secrets_api_conditions          = []

alias_secrets_db                = "secrets-db"
secrets_db_description         = "KMS key for DB Secrets encryption"
secrets_db_sid                 = "AllowSecretsManagerDB"
secrets_db_effect              = "Allow"
secrets_db_kms_actions         = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
secrets_db_principal_type      = "Service"
secrets_db_principal_identifiers = ["secretsmanager.amazonaws.com"]
secrets_db_conditions          = []

# Lambda acceso a DynamoDB KMS
lambda_dynamo_sid = "AllowLambdaAccess"
lambda_dynamo_effect = "Allow"
lambda_dynamo_kms_actions = [
  "kms:Decrypt",
  "kms:DescribeKey",
  "kms:GenerateDataKey*"
]
lambda_dynamo_principal_type = "Service"
lambda_dynamo_principal_identifiers = ["lambda.amazonaws.com"]
lambda_dynamo_conditions = []

# ######################################################################
# # API Gateway - Amazon 
# ######################################################################

# API Gateway Configuration
api_name        = "users-api"
api_description = "API for managing users"
endpoint_types  = ["REGIONAL"]

# V1 endpoint configuration
v1_path_part  = "v1"
v1_path       = "v1"
v1_parent_id  = null

# Users endpoint configuration
users_path_part = "users"
users_path      = "v1/users"
users_parent_id = "v1"

# Method configuration
users_http_method      = "GET"
users_authorization    = "CUSTOM"
users_request_parameters = {}

# Integration configuration
users_integration_http_method = "POST"
users_integration_type       = "AWS_PROXY"
users_integration_request_templates = {}

# Response configuration
users_response_status_code = "200"
users_response_models = {
  "application/json" = "Empty"
}
users_response_parameters = {}
users_integration_response_templates = {}

# Configuración de API Gateway Method Settings
api_gateway_method_settings = {
  method_path            = "*/*"
  throttling_rate_limit  = 10
  throttling_burst_limit = 20
  metrics_enabled        = true
  logging_level          = "INFO"
  caching_enabled        = false
  cache_ttl_in_seconds   = 300
}
# ######################################################################
# # Cognito - Amazon 
# ######################################################################

# User Pool Basic Configuration
user_pool_name = "main"
username_attributes = ["email"]
auto_verified_attributes = ["email"]

# Password Policy
password_minimum_length = 8
password_require_lowercase = true
password_require_numbers = true
password_require_symbols = true
password_require_uppercase = true
password_temporary_validity_days = 7

# MFA Configuration
mfa_configuration = "OFF"

# SMS Configuration
sms_external_id = "cognito-sms-external-id"
sms_caller_arn = ""  # Dejar vacío si no se usa MFA por SMS

# Email Configuration
email_sending_account = "COGNITO_DEFAULT"
email_from_address = null  # Usar null para dirección por defecto de Cognito

# Lambda Triggers
lambda_triggers = {
  # pre_sign_up         = module.lambda.lambda_functions["pre-signup"].arn
  # post_confirmation   = module.lambda.lambda_functions["post-confirmation"].arn
  # pre_authentication  = module.lambda.lambda_functions["pre-auth"].arn
  # post_authentication = module.lambda.lambda_functions["post-auth"].arn
}

# Schema Attributes
schema_attributes = [
  {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    min_length          = 3
    max_length          = 256
    min_value           = 0
    max_value           = 0
  },
  {
    name                = "given_name"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    min_length          = 1
    max_length          = 256
    min_value           = 0
    max_value           = 0
  },
  {
    name                = "family_name"
    attribute_data_type = "String"
    mutable             = true
    required            = true
    min_length          = 1
    max_length          = 256
    min_value           = 0
    max_value           = 0
  }
]

# Domain Configuration
cognito_domain = "my-auth-domain"
certificate_arn = null  # Usar null si no se tiene un certificado personalizado

# Client Apps Configuration
user_pool_clients = [
  {
    name = "web-client"
    generate_secret = false
    explicit_auth_flows = [
      "ALLOW_USER_SRP_AUTH",
      "ALLOW_REFRESH_TOKEN_AUTH",
      "ALLOW_USER_PASSWORD_AUTH"
    ]
    allowed_oauth_flows = [
      "implicit",
      "code"
    ]
    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_scopes = [
      "email",
      "openid",
      "profile"
    ]
    callback_urls = [
      "http://localhost:3000/callback",
      "https://my-domain.com/callback"
    ]
    logout_urls = [
      "http://localhost:3000/logout",
      "https://my-domain.com/logout"
    ]
    supported_identity_providers = ["COGNITO"]
    prevent_user_existence_errors = "ENABLED"
  },
  {
    name = "mobile-client"
    generate_secret = true
    explicit_auth_flows = [
      "ALLOW_USER_SRP_AUTH",
      "ALLOW_REFRESH_TOKEN_AUTH",
      "ALLOW_CUSTOM_AUTH"
    ]
    allowed_oauth_flows = [
      "code"
    ]
    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_scopes = [
      "email",
      "openid",
      "profile"
    ]
    callback_urls = [
      "myapp://callback"
    ]
    logout_urls = [
      "myapp://logout"
    ]
    supported_identity_providers = ["COGNITO"]
    prevent_user_existence_errors = "ENABLED"
  }
]

# ######################################################################
# #  Secrets Manager - Amazon 
# ######################################################################

# General configuration
recovery_window_in_days         = 7
force_overwrite_replica_secret = false

# API Secret configuration
api_secret_username = "api_user"
api_secret_password = "api_password"
api_secret_name         = "api-credentials"
api_secret_description = "API authentication credentials"
api_version_stages     = ["AWSCURRENT"]
api_replicas          = []

# DB Secret configuration
db_secret_username = "ESB_SAP"
db_secret_password = "EsB_SBD23ai_banco"
db_secret_host     = "10.31.193.179"
db_secret_port     = 1521
db_secret_service_name = "DBBCT_DBBCT_pdbdev.paas.oracle.com"
db_secret_name         = "database-credentials"
db_secret_description = "Database connection credentials"
db_version_stages     = ["AWSCURRENT"]
db_replicas          = []

# Política del secreto de la base de datos
db_secret_policy_version = "2012-10-17"
db_secret_policy_effect = "Allow"
db_secret_policy_principal_type = "Service"
db_secret_policy_principal_identifiers = ["lambda.amazonaws.com"]
db_secret_policy_actions = [
  "secretsmanager:GetSecretValue",
  "secretsmanager:DescribeSecret"
]
db_secret_policy_resource = "*"

# Cognito Secret Variables
cognito_secret_name        = "cognito-credentials"
cognito_secret_description = "Secret containing Cognito authentication credentials"
alias_secrets_cognito      = "alias/secrets-cognito"
cognito_version_stages     = ["AWSCURRENT"]
cognito_secret_policy      = null
cognito_replicas           = []
app_client_name            = "app-client"


# ######################################################################
# #  WAF - Amazon Web Application Firewall 
# ######################################################################

# General WAF Configuration
waf_web_acl_name               = "main-protection"
waf_web_acl_description        = "Web ACL para proteger las APIs y aplicaciones web"
waf_web_acl_scope              = "REGIONAL"
waf_default_action             = "block"
waf_cloudwatch_metrics_enabled = true
waf_metric_name                = "WAFWebACL"
waf_sampled_requests_enabled   = true

# Rate Limiting Configuration
waf_rate_limit = 500

# Geo Blocking Configuration
waf_blocked_countries = [
  "CO",  # Colombia
  "US",  # EEUU
]

# IP Allowlisting Configuration
waf_allowed_ips = []

# Rule Exclusions for Common Rule Set
# Estas reglas se configurarán con acción "count" en lugar de aplicar la acción por defecto
waf_excluded_rules_common = [
  "SizeRestrictions_BODY",
  "NoUserAgent_HEADER"
]

# Resource Association (opcional)
# Dejando como null para no asociar con ningún recurso automáticamente
# waf_resource_arns = [
#   {
#     api_id = "k0y4kjkvx9"
#     stage  = "dev"
#   }
# ]

waf_resource_arns = "arn:aws:apigateway:us-east-1::/restapis/k0y4kjkvx9/stages/dev"

# Logging Configuration (opcional)
# Dejando como null para no configurar logging automáticamente
waf_log_destination_configs = null

waf_redacted_fields = [
  "Authorization",
  "Cookie"
]