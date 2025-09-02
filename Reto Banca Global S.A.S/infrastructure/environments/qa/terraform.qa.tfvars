# ######################################################################
# # Tags globales - Amazon 
# ######################################################################
aws_region  = "us-east-1"
cost_center = "1234"
project     = "apificacion"
environment = "qa"
domain      = "d1"
owner       = "Luis Quibano"

resource_tags = {
  aws_region  = "us-east-1"
  cost_center = "1234"
  project     = "apificacion"
  environment = "qa"
  domain      = "d1"
  owner       = "Luis Quibano"
}

# terraform.tfvars
# VPC Configuration
cidrblock            = "100.95.24.0/20"
vpc_name             = "vpc"
enable_dns_support   = true
enable_dns_hostnames = true
instance_tenancy     = "default"

# Resource Names
igw_name    = "igw-01"
ngw_name    = "ngw-01"
eip_name    = "eip-ngw-01"
subnet_name = "subnet"

# Descriptions
description          = "WEB Access"
description_sg       = "Trafico HTTP"
description_sg2      = "Habilita trafico terminal"
description_ingress  = "Private Security Group"
description_ingress2 = "Access from Public subnet"
description_ingress3 = "Acces from private DB Subnet"

endpoint_service_name                    = "com.amazonaws.us-east-1.s3"
endpoint_type                            = "Gateway"
endpoint_policy                          = null
endpoint_auto_accept                     = true
endpoint_route_table_association_enabled = true

endpoint_service_name_secretmanager = "com.amazonaws.us-east-1.secretsmanager"
endpoint_type_secretmanager         = "Interface"
endpoint_policy_secretmanager       = null
endpoint_auto_accept_secretmanager  = true

# vpc endpoint interface para Api Gateway
endpoint_service_name_apigateway = "com.amazonaws.us-east-1.execute-api"
endpoint_type_apigateway         = "Interface"
endpoint_policy_apigateway       = null
endpoint_auto_accept_apigateway  = true
# vpc endpoint interface para Parameter Store
endpoint_service_name_parameter_store = "com.amazonaws.us-east-1.ssm"
endpoint_type_parameter_store         = "Interface"
endpoint_policy_parameter_store       = null
endpoint_auto_accept_parameter_store  = true
# ECR API - Para operaciones de registry (login, list, etc.)
endpoint_service_name_ecr_api = "com.amazonaws.us-east-1.ecr.api"
endpoint_type_ecr_api         = "Interface"
endpoint_policy_ecr_api       = null
endpoint_auto_accept_ecr_api  = true
# ECR DKR - Para push/pull de imágenes Docker
endpoint_service_name_ecr_dkr = "com.amazonaws.us-east-1.ecr.dkr"
endpoint_type_ecr_dkr         = "Interface"
endpoint_policy_ecr_dkr       = null
endpoint_auto_accept_ecr_dkr  = true
# vpc endpoint interface para - Glue
endpoint_service_name_glue = "com.amazonaws.us-east-1.glue"
endpoint_type_glue         = "Interface"
endpoint_policy_glue       = null
endpoint_auto_accept_glue  = true
# vpc endpoint interface para - CloudWatch Logs
endpoint_service_name_cloudWatch_logs = "com.amazonaws.us-east-1.logs"
endpoint_type_cloudWatch_logs         = "Interface"
endpoint_policy_cloudWatch_logs       = null
endpoint_auto_accept_cloudWatch_logs  = true
# vpc endpoint interface para - Ecs
endpoint_service_name_ecs = "com.amazonaws.us-east-1.ecs"
endpoint_type_ecs         = "Interface"
endpoint_policy_ecs       = null
endpoint_auto_accept_ecs  = true

# vpc endpoint interface para - Elb
endpoint_service_name_elb = "com.amazonaws.us-east-1.elasticloadbalancing"
endpoint_type_elb         = "Interface"
endpoint_policy_elb       = null
endpoint_auto_accept_elb  = true

# vpc endpoint Gateway para Dynamo DB
endpoint_service_name_dynamo = "com.amazonaws.us-east-1.dynamodb"
endpoint_type_dynamo         = "Gateway"
endpoint_policy_dynamo       = null
endpoint_auto_accept_dynamo  = true

# Subnet 1a Configuration
subnet_1a_name    = "private-1a"
subnet_1a_cidr    = "100.95.25.0/28"
subnet_1a_private = true
subnet_1a_tags = {
  Type = "Private"
}

# Subnet 1b Configuration
subnet_1b_name    = "private-1b"
subnet_1b_cidr    = "100.95.25.16/28"
subnet_1b_private = true
subnet_1b_tags = {
  Type = "Private"
}

# Subnet 1a Configuration - Impresión de precios 
subnet_1a_name_second_project    = "private2-1a"
subnet_1a_cidr_second_project    = "100.95.25.64/26"
subnet_1a_private_second_project = true
subnet_1a_tags_second_project = {
  Type = "Private"
}
# Subnet 1b Configuration - Impresión de precios 
subnet_1b_name_second_project    = "private2-1b"
subnet_1b_cidr_second_project    = "100.95.25.32/27"
subnet_1b_private_second_project = true
subnet_1b_tags_second_project = {
  Type = "Private"
}

# Route Configuration
route_cidr_block     = "172.27.6.0/26"
route_cidr_block_new = "10.31.193.179/32"
route_cidr_block_db  = "10.31.224.34/32"
id_tgw_db            = "tgw-0bd989394e774bae9"
nat_gateway_id       = "nat"

# ######################################################################
# # Lambda - Amazon 
# ######################################################################
# terraform.tfvars
# Common Lambda configurations
lambda_runtime = "python3.11"
lambda_handler = "lambda_handler.lambda_handler"
memory_size    = 256
timeout        = 300

# Extraction Store Lambda configurations (renombradas)
extraction_store_function_name = "extraction-store"
extraction_store_description   = "Process data extraction for stores"
extraction_store_s3_key        = "extraction_stores.zip"
extraction_store_tags = {
  Function = "Extraction-store"
}

# Extraction User Lambda configurations (nuevas)
extraction_user_function_name = "extraction-user"
extraction_user_description   = "Process data extraction for users"
extraction_user_s3_key        = "extraction_users.zip"
extraction_user_tags = {
  Function = "Extraction-user"
}

# DynamoDB permissions
dynamo_statement_id = "AllowDynamoAccess"
dynamo_actions      = ["dynamodb:*"]
dynamo_principal    = "dynamodb.amazonaws.com"

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
comparison_store_description   = "Data comparison process for stores"
comparison_store_s3_key        = "comparison_stores.zip"
comparison_store_tags = {
  Function = "Comparison-store"
}

# Comparison User Lambda configurations (nuevas)
comparison_user_function_name = "comparison-user"
comparison_user_description   = "Data comparison process for users"
comparison_user_s3_key        = "comparison_users.zip"
comparison_user_tags = {
  Function = "Comparison-user"
}

# SQS permissions
sqs_statement_id                   = "AllowSQSAccess"
sqs_actions                        = ["sqs:*"]
sqs_principal                      = "sqs.amazonaws.com"
batch_size                         = 10
maximum_batching_window_in_seconds = 0
sqs_trigger_enabled                = true

# Normalization Store Lambda configurations (renombradas)
normalization_store_function_name = "normalization-store"
normalization_store_description   = "Data normalization process for stores"
normalization_store_s3_key        = "normalization_stores.zip"
normalization_store_tags = {
  Function = "Normalization-store"
}

# Normalization User Lambda configurations (nuevas)
normalization_user_function_name = "normalization-user"
normalization_user_description   = "Data normalization process for users"
normalization_user_s3_key        = "normalization_users.zip"
normalization_user_tags = {
  Function = "Normalization-user"
}

# Variables para las nuevas funciones Lambda de API
api_user_function_name   = "api-users-function"
api_store_function_name  = "api-stores-function"
lambda_handler_api_store = "api_d1_stores_lambda.lambda_handler.lambda_handler"
api_user_s3_key          = "api_users_function.zip"
api_store_s3_key         = "api_stores_function.zip"

# API Authorizer Lambda configuration
api_authorizer_function_name = "api-authorizer-function"
api_authorizer_description   = "API Gateway request authorizer"
api_authorizer_s3_key        = "api_authorizer_function.zip"
api_authorizer_tags = {
  Function = "API-Authorizer"
}

# Actualiza el módulo de API Gateway para utilizar las nuevas Lambdas
users_lambda_invoke_arn  = ""
stores_lambda_invoke_arn = ""

# KMS permissions
kms_statement_id = "AllowKMSAccess"
kms_actions      = ["kms:*"]
kms_principal    = "kms.amazonaws.com"

# Lambda layers
cx_oracle_arn     = "arn:aws:lambda:us-east-1:390403853861:layer:oracledb_layer:9"
instaclient_layer = "arn:aws:lambda:us-east-1:390403853861:layer:instaclient_layer:1"
boto3_arn         = "arn:aws:lambda:us-east-1:390403853861:layer:boto3:1"
cryptography      = "arn:aws:lambda:us-east-1:390403853861:layer:cryptography:1"
requests          = "arn:aws:lambda:us-east-1:390403853861:layer:requests:1"
pyjwt             = "arn:aws:lambda:us-east-1:390403853861:layer:PyJWT_layer:2"
jwt               = "arn:aws:lambda:us-east-1:390403853861:layer:jwt_layer:1"

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
api_gateway_actions      = ["lambda:InvokeFunction"]
api_gateway_principal    = "apigateway.amazonaws.com"

# Variables para funciones API
api_user_description  = "Lambda function to handle API Gateway requests for user data"
api_store_description = "Lambda function to handle API Gateway requests for store data"

api_user_tags = {
  Name = "api-users-function"
}

api_store_tags = {
  Name = "api-stores-function"
}

# Token Lambda Configuration
token_function_name = "login"
token_description   = "Lambda function to generate authorization tokens"
token_s3_key        = "login.zip"
token_tags = {
  Name = "login"
}

# Refresh Token Lambda Configuration
refresh_token_function_name = "refresh-token"
refresh_token_description   = "Lambda function to refresh authorization tokens"
refresh_token_s3_key        = "refresh_token.zip"
refresh_token_tags = {
  Name = "refresh-token"
}
# ######################################################################
# # Recurso Security Group - Amazon 
# ######################################################################
# terraform.tfvars
#["100.95.25.0/28", "100.95.25.0/28", "172.27.6.0/26"]
# VPC Endpoints CIDR blocks
dynamodb_vpc_endpoints       = ["172.27.6.0/26"]
s3_vpc_endpoints             = ["100.95.25.0/28", "100.95.25.16/28"]
sqs_vpc_endpoints            = ["100.95.25.0/28", "100.95.25.16/28"]
kms_vpc_endpoints            = ["100.95.25.0/28", "100.95.25.16/28"]
secretsmanager_vpc_endpoints = ["100.95.25.0/28", "100.95.25.16/28"]
oci_endpoints                = ["10.31.193.179/32"]
cidr_blocks_glue_jobs        = ["0.0.0.0/0"]
cidr_blocks_ecs              = ["0.0.0.0/0"]
cidr_blocks_vpc_endpoints    = ["0.0.0.0/0"]
ecs_ingress_cidr_blocks      = ["100.95.25.32/27", "100.95.25.64/27"]

# Extraction Lambda Security Group
extraction_lambda_sg_name        = "extraction-lambda"
extraction_lambda_sg_description = "Security group for Extraction Lambda function"

extraction_lambda_ingress_description = "Allow HTTPS from self for Secrets Manager"
extraction_lambda_ingress_from_port   = 443
extraction_lambda_ingress_to_port     = 443
extraction_lambda_ingress_protocol    = "tcp"
extraction_lambda_ingress_self        = true

#extraction_lambda_ingress_rules = []
extraction_lambda_egress_description = "Access to Oracle"
extraction_lambda_egress_from_port   = 1521
extraction_lambda_egress_to_port     = 1521
extraction_lambda_egress_protocol    = "tcp"

extraction_lambda_egress_description_s3 = "Access to S3"
extraction_lambda_egress_from_port_s3   = 443
extraction_lambda_egress_to_port_s3     = 443
extraction_lambda_egress_protocol_s3    = "tcp"

extraction_lambda_egress_description_https = "interval through port 443"
extraction_lambda_egress_from_port_https   = 443
extraction_lambda_egress_to_port_https     = 443
extraction_lambda_egress_protocol_https    = "tcp"

extraction_lambda_egress_acceess_oci           = "Access to OCI"
extraction_lambda_egress_from_port_acceess_oci = 1521
extraction_lambda_egress_to_port_acceess_oci   = 1521
extraction_lambda_egress_protocol_acceess_oci  = "tcp"

# Comparison Lambda Security Group
comparison_lambda_sg_name            = "comparison-lambda"
comparison_lambda_sg_description     = "Security group for Comparison Lambda function"
comparison_lambda_ingress_rules      = []
comparison_lambda_egress_description = "Access to SQS"
comparison_lambda_egress_from_port   = 443
comparison_lambda_egress_to_port     = 443
comparison_lambda_egress_protocol    = "tcp"

# Normalization Lambda Security Group
normalization_lambda_sg_name            = "normalization-lambda"
normalization_lambda_sg_description     = "Security group for Normalization Lambda function"
normalization_lambda_ingress_rules      = []
normalization_lambda_egress_description = "Access to KMS and S3"
normalization_lambda_egress_from_port   = 443
normalization_lambda_egress_to_port     = 443
normalization_lambda_egress_protocol    = "tcp"

# Extraction Glue Jobs Security Group
extraction_gluejobs_sg_name        = "extraction-gluejobs"
extraction_gluejobs_sg_description = "Security group for Extraction Glue Jobs"
# extraction_gluejobs_ingress_rules      = []
extraction_gluejobs_egress_description  = "Access to Extraction Glue Jobs"
extraction_gluejobs_egress_from_port    = 0
extraction_gluejobs_egress_to_port      = 65535
extraction_gluejobs_egress_protocol     = "tcp"
# Egress desde extraction-gluejobs hacia priceHistory-ecs
extraction_gluejobs_egress_description_pricehistory = "Access to priceHistory service"
extraction_gluejobs_egress_from_port_pricehistory   = 8085
extraction_gluejobs_egress_to_port_pricehistory     = 8085
extraction_gluejobs_egress_protocol_pricehistory    = "tcp"
extraction_gluejobs_ingress_description = "Access to Extraction Glue Jobs"
extraction_gluejobs_ingress_from_port   = 0
extraction_gluejobs_ingress_to_port     = 65535
extraction_gluejobs_ingress_protocol    = "tcp"
extraction_gluejobs_ingress_self        = false

#  Impresión de precios - Security Group - Vcp Endpoints Ecr - SSM
vpc_endpoints_sg_name        = "vpc-endpoints-interfaces"
vpc_endpoints_sg_description = "Security group for vpc-endpoints-interfaces ecr and ssm "
# vpc_endpoints_ingress_rules      = []
vpc_endpoints_egress_description  = "Access to vpc-endpoints-interfaces ecr and ssm"
vpc_endpoints_egress_from_port    = 0
vpc_endpoints_egress_to_port      = 0
vpc_endpoints_egress_protocol     = "-1"
vpc_endpoints_ingress_description = "Access to vpc-endpoints-interfaces ecr and ssm"
vpc_endpoints_ingress_from_port   = 443
vpc_endpoints_ingress_to_port     = 443
vpc_endpoints_ingress_protocol    = "tcp"
vpc_endpoints_ingress_self        = false


#  Impresión de precios - Security Group - ECS Materials
materials_ecs_sg_name        = "materials-ecs"
materials_ecs_sg_description = "Security group for Materials ecs"
# price_printing_NLB_ingress_rules      = []
materials_ecs_egress_description  = "Access to NLB Price Printing"
materials_ecs_egress_from_port    = 0
materials_ecs_egress_to_port      = 65535
materials_ecs_egress_protocol     = "tcp"
materials_ecs_ingress_description = "Access to Price Printing"
materials_ecs_ingress_from_port   = 8081
materials_ecs_ingress_to_port     = 8081
materials_ecs_ingress_protocol    = "tcp"
materials_ecs_ingress_self        = false
# Materials - Nueva regla desde prices
materials_ecs_ingress_description_prices = "Access from prices-ecs"
materials_ecs_ingress_from_port_prices   = 8081
materials_ecs_ingress_to_port_prices     = 8081
materials_ecs_ingress_protocol_prices    = "tcp"
materials_ecs_ingress_self_prices        = false
# Materials - Nueva regla desde Notes 
materials_ecs_ingress_description_notes = "Access from notes-ecs"
materials_ecs_ingress_from_port_notes   = 8081
materials_ecs_ingress_to_port_notes     = 8081
materials_ecs_ingress_protocol_notes    = "tcp"
materials_ecs_ingress_self_notes        = false
# Materials - Nueva regla desde priceshistory
materials_ecs_ingress_description_priceshistory = "Access from priceshistory-ecs"
materials_ecs_ingress_from_port_priceshistory   = 8081
materials_ecs_ingress_to_port_priceshistory     = 8081
materials_ecs_ingress_protocol_priceshistory    = "tcp"
materials_ecs_ingress_self_priceshistory        = false
###### Impresión de precios - Security Group - ECS Notes
notes-ecs_sg_name        = "notes-ecs"
notes-ecs_sg_description = "Security group for Materials ecs"
# price_printing_NLB_ingress_rules      = []
notes-ecs_egress_description = "Access to materials service"
notes-ecs_egress_from_port   = 8081
notes-ecs_egress_to_port     = 8081
notes-ecs_egress_protocol    = "tcp"
# Notes egress adicional al NLB
notes_ecs_egress_description_nlb = "Access to NLB"
notes_ecs_egress_from_port_nlb   = 0
notes_ecs_egress_to_port_nlb     = 65535
notes_ecs_egress_protocol_nlb    = "tcp"
notes-ecs_ingress_description    = "Access to Price Printing Ecs Notes"
notes-ecs_ingress_from_port      = 8080
notes-ecs_ingress_to_port        = 8080
notes-ecs_ingress_protocol       = "tcp"
notes-ecs_ingress_self           = false
# Notes - Nueva regla desde prices
notes_ecs_ingress_description_prices = "Access from prices-ecs"
notes_ecs_ingress_from_port_prices   = 8080
notes_ecs_ingress_to_port_prices     = 8080
notes_ecs_ingress_protocol_prices    = "tcp"
notes_ecs_ingress_self_prices        = false
# Notes - Nueva regla desde priceshistory
notes_ecs_ingress_description_priceshistory = "Access from priceshistory-ecs"
notes_ecs_ingress_from_port_priceshistory   = 8080
notes_ecs_ingress_to_port_priceshistory     = 8080
notes_ecs_ingress_protocol_priceshistory    = "tcp"
notes_ecs_ingress_self_priceshistory        = false
########  Impresión de precios - Security Group - ECS Prices
prices-ecs_sg_name        = "prices-ecs"
prices-ecs_sg_description = "Security group for Materials ecs"
# price_printing_NLB_ingress_rules      = []
prices-ecs_egress_description = "Access to NLB"
prices-ecs_egress_from_port   = 0
prices-ecs_egress_to_port     = 65535
prices-ecs_egress_protocol    = "tcp"
# Prices egress adicionales a otros servicios
prices_ecs_egress_description_materials = "Access to materials service"
prices_ecs_egress_from_port_materials   = 8081
prices_ecs_egress_to_port_materials     = 8081
prices_ecs_egress_protocol_materials    = "tcp"
prices_ecs_egress_description_notes     = "Access to notes service"
prices_ecs_egress_from_port_notes       = 8080
prices_ecs_egress_to_port_notes         = 8080
prices_ecs_egress_protocol_notes        = "tcp"
prices_ecs_egress_description_segments  = "Access to priceTagSegments service"
prices_ecs_egress_from_port_segments    = 8083
prices_ecs_egress_to_port_segments      = 8083
prices_ecs_egress_protocol_segments     = "tcp"
prices_ecs_egress_description_rules     = "Access to priceTagRules service"
prices_ecs_egress_from_port_rules       = 8082
prices_ecs_egress_to_port_rules         = 8082
prices_ecs_egress_protocol_rules        = "tcp"
prices-ecs_ingress_description          = "Access to Price Printing Ecs Notes"
prices-ecs_ingress_from_port            = 8084
prices-ecs_ingress_to_port              = 8084
prices-ecs_ingress_protocol             = "tcp"
prices-ecs_ingress_self                 = false

###########  Impresión de precios - Security Group - NLB
price_printing_nlb_sg_name        = "prices-nlb"
price_printing_nlb_sg_description = "Security group for NLB"
# price_printing_nlb_ingress_rules      = []
price_printing_nlb_egress_description  = "Access of nlb Price Printing NLB "
price_printing_nlb_egress_from_port    = 0
price_printing_nlb_egress_to_port      = 65535
price_printing_nlb_egress_protocol     = "-1"
price_printing_nlb_ingress_description = "Access to Price Printing NLB"
price_printing_nlb_ingress_from_port   = 0
price_printing_nlb_ingress_to_port     = 65535
price_printing_nlb_ingress_protocol    = "tcp"
price_printing_nlb_ingress_self        = false

################ Impresión de precios - Security Group - ECS priceTagSegments
priceTagSegments-ecs_sg_name        = "priceTagSegments-ecs"
priceTagSegments-ecs_sg_description = "Security group for priceTagSegments ecs"
# price_printing_NLB_ingress_rules      = []
priceTagSegments-ecs_egress_description = "Access to priceTagRules service"
priceTagSegments-ecs_egress_from_port   = 8082
priceTagSegments-ecs_egress_to_port     = 8082
priceTagSegments-ecs_egress_protocol    = "tcp"
# PriceTagSegments egress adicional al NLB
priceTagSegments_ecs_egress_description_nlb = "Access to NLB"
priceTagSegments_ecs_egress_from_port_nlb   = 0
priceTagSegments_ecs_egress_to_port_nlb     = 65535
priceTagSegments_ecs_egress_protocol_nlb    = "tcp"
priceTagSegments-ecs_ingress_description    = "Access to Price Printing Ecs Notes"
priceTagSegments-ecs_ingress_from_port      = 8083
priceTagSegments-ecs_ingress_to_port        = 8083
priceTagSegments-ecs_ingress_protocol       = "tcp"
priceTagSegments-ecs_ingress_self           = false
# PriceTagSegments - Nueva regla desde prices
priceTagSegments_ecs_ingress_description_prices = "Access from prices-ecs"
priceTagSegments_ecs_ingress_from_port_prices   = 8083
priceTagSegments_ecs_ingress_to_port_prices     = 8083
priceTagSegments_ecs_ingress_protocol_prices    = "tcp"
priceTagSegments_ecs_ingress_self_prices        = false
# PriceTagSegments - Nueva regla desde prices
priceTagSegments_ecs_ingress_description_priceshistory = "Access from priceshistory-ecs"
priceTagSegments_ecs_ingress_from_port_priceshistory   = 8083
priceTagSegments_ecs_ingress_to_port_priceshistory     = 8083
priceTagSegments_ecs_ingress_protocol_priceshistory    = "tcp"
priceTagSegments_ecs_ingress_self_priceshistory        = false

##### Impresión de precios - Security Group - ECS priceTagRules
priceTagRules-ecs_sg_name        = "priceTagRules-ecs"
priceTagRules-ecs_sg_description = "Security group for priceTagRules ecs"
# price_printing_NLB_ingress_rules      = []
priceTagRules-ecs_egress_description  = "Access to NLB only"
priceTagRules-ecs_egress_from_port    = 0
priceTagRules-ecs_egress_to_port      = 65535
priceTagRules-ecs_egress_protocol     = "tcp"
priceTagRules-ecs_ingress_description = "Access to Price Printing Ecs Notes"
priceTagRules-ecs_ingress_from_port   = 8082
priceTagRules-ecs_ingress_to_port     = 8082
priceTagRules-ecs_ingress_protocol    = "tcp"
priceTagRules-ecs_ingress_self        = false
# PriceTagRules - Nueva regla desde prices
priceTagRules_ecs_ingress_description_prices = "Access from prices-ecs"
priceTagRules_ecs_ingress_from_port_prices   = 8082
priceTagRules_ecs_ingress_to_port_prices     = 8082
priceTagRules_ecs_ingress_protocol_prices    = "tcp"
priceTagRules_ecs_ingress_self_prices        = false
# PriceTagRules Nueva regla desde PriceTagSegments
priceTagRules_ecs_ingress_description_segments = "Access from priceTagSegments-ecs"
priceTagRules_ecs_ingress_from_port_segments   = 8082
priceTagRules_ecs_ingress_to_port_segments     = 8082
priceTagRules_ecs_ingress_protocol_segments    = "tcp"
priceTagRules_ecs_ingress_self_segments        = false
# PriceTagRules Nueva regla desde  priceshistory
priceTagRules_ecs_ingress_description_priceshistory = "Access from priceshistory-ecs"
priceTagRules_ecs_ingress_from_port_priceshistory   = 8082
priceTagRules_ecs_ingress_to_port_priceshistory     = 8082
priceTagRules_ecs_ingress_protocol_priceshistory    = "tcp"
priceTagRules_ecs_ingress_self_priceshistory        = false

##### Impresión de precios - Security Group - ECS priceHistory
priceHistory-ecs_sg_name        = "priceHistory-ecs"
priceHistory-ecs_sg_description = "Security group for priceHistory ecs"
# price_printing_NLB_ingress_rules      = []
priceHistory-ecs_egress_description  = "Access to NLB only"
priceHistory-ecs_egress_from_port    = 0
priceHistory-ecs_egress_to_port      = 65535
priceHistory-ecs_egress_protocol     = "tcp"
priceHistory-ecs_ingress_description = "Access to Price Printing NLB"
priceHistory-ecs_ingress_from_port   = 8085
priceHistory-ecs_ingress_to_port     = 8085
priceHistory-ecs_ingress_protocol    = "tcp"
priceHistory-ecs_ingress_self        = false

# priceHistory - Nueva regla desde prices
priceHistory_ecs_ingress_description_prices = "Access from prices-ecs"
priceHistory_ecs_ingress_from_port_prices   = 8085
priceHistory_ecs_ingress_to_port_prices     = 8085
priceHistory_ecs_ingress_protocol_prices    = "tcp"
priceHistory_ecs_ingress_self_prices        = false
# priceHistory - Nueva regla desde PriceTagSegments
priceHistory_ecs_ingress_description_segments = "Access from priceTagSegments-ecs"
priceHistory_ecs_ingress_from_port_segments   = 8085
priceHistory_ecs_ingress_to_port_segments     = 8085
priceHistory_ecs_ingress_protocol_segments    = "tcp"
priceHistory_ecs_ingress_self_segments        = false
# priceHistory - Nueva regla desde extraction-gluejobs
priceHistory_ecs_ingress_description_glue = "Access from extraction-gluejobs"
priceHistory_ecs_ingress_from_port_glue   = 8085
priceHistory_ecs_ingress_to_port_glue     = 8085
priceHistory_ecs_ingress_protocol_glue    = "tcp"
priceHistory_ecs_ingress_self_glue        = false

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

external_statement_sid        = "AllowLambdaPutObject"
external_statement_actions    = ["s3:PutObject"]
external_statement_effect     = "Allow"
external_statement_type       = "AWS"
external_statement_conditions = []

s3_notification_events        = ["s3:ObjectCreated:*"]
s3_notification_filter_prefix = "stores/"

# materials bucket configuration
glue_bucket_name        = "materials"
glue_bucket_description = "Store materials integracion con los Glue Jobs"
glue_versioning_enabled = true
glue_sse_enabled        = true
glue_lifecycle_rules = [
  {
    id      = "move_to_glacier"
    enabled = true
    transition = {
      days          = 90
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration = {
      days = 30
    }
  }
]
glue_cors_rules            = []
glue_statement_sid         = "AllowGlueAccess"
glue_statement_actions     = ["s3:GetObject"]
glue_statement_effect      = "Allow"
glue_statement_type        = "Service"
glue_statement_identifiers = ["glue.amazonaws.com"]
glue_statement_conditions  = []
# Bucket general para integraciones con Glue
glue_general_bucket_name           = "glue"
glue_general_bucket_description    = "Store general para integraciones con Glue"
glue_general_versioning_enabled    = true
glue_general_sse_enabled           = true
glue_general_lifecycle_rules       = []
glue_general_cors_rules            = []
glue_general_statement_sid         = "Allowglue_generalAccess"
glue_general_statement_actions     = ["s3:GetObject", "s3:PutObject"]
glue_general_statement_effect      = "Allow"
glue_general_statement_type        = "Service"
glue_general_statement_identifiers = ["glue.amazonaws.com"]
glue_general_statement_conditions  = []
# Bucket general para logs de pipeline trivi
logs_trivi_bucket_name        = "logs-trivi"
logs_trivi_bucket_description = "Store general para logs de pipeline trivi"
logs_trivi_versioning_enabled = true
logs_trivi_sse_enabled        = true
logs_trivi_lifecycle_rules = [
  {
    id      = "delete_old_versions"
    enabled = true
    noncurrent_version_expiration = {
      days = 30
    }
  }
]
logs_trivi_cors_rules            = []
logs_trivi_statement_sid         = "Allow_trivi_Access"
logs_trivi_statement_actions     = ["s3:GetObject", "s3:PutObject"]
logs_trivi_statement_effect      = "Allow"
logs_trivi_statement_type        = "Service"
logs_trivi_statement_identifiers = ["s3.amazonaws.com"]
logs_trivi_statement_conditions  = []
# Bucket general para logs de pipeline Step Functions
stepfunction_bucket_name        = "step-functions"
stepfunction_bucket_description = "Store general para definition de step functions"
stepfunction_versioning_enabled = true
stepfunction_sse_enabled        = true
stepfunction_lifecycle_rules = [
  {
    id      = "delete_old_versions"
    enabled = true
    noncurrent_version_expiration = {
      days = 30
    }
  }
]
stepfunction_cors_rules            = []
stepfunction_statement_sid         = "Allow_stepfunction_Access"
stepfunction_statement_actions     = ["s3:GetObject", "s3:PutObject"]
stepfunction_statement_effect      = "Allow"
stepfunction_statement_type        = "Service"
stepfunction_statement_identifiers = ["s3.amazonaws.com"]
stepfunction_statement_conditions  = []

# ######################################################################
# # Recurso EventBridge - Amazon 
# ######################################################################

# terraform.tfvars
event_rule_name             = "daily-process"
event_rule_description      = "EventBridge rule to trigger Lambda function"
schedule_cron               = "cron(0 12,19 ? * MON-SUN *)"
event_target_id             = "AllowEventBridgeInvoke"
event_rule_lambda_action    = "lambda:InvokeFunction"
event_rule_lambda_principal = "events.amazonaws.com"

# Step Functions EventBridge Rule
stepfunction_rule_name        = "stepfunction-prices"
stepfunction_rule_description = "EventBridge rule to trigger Step Function"
stepfunction_schedule_cron    = "cron(0 14 ? * MON-FRI *)"
 #stepfunction_role_arn es opcional - si tu módulo de Step Functions maneja los roles, no lo definas

# ######################################################################
# # SQS - Amazon 
# ######################################################################

# terraform.tfvars

# Nombres de colas SQS
normalization_store_sqs_name = "normalization-store-sqs"
comparison_store_sqs_name    = "comparison-store-sqs"
normalization_user_sqs_name  = "normalization-user-sqs"
comparison_user_sqs_name     = "comparison-user-sqs"

# Configuraciones de SQS
delay_seconds                 = 0
max_message_size              = 262144
message_retention_seconds     = 345600
dlq_message_retention_seconds = 1209600
receive_wait_time_seconds     = 20
visibility_timeout_seconds    = 300
fifo_queue                    = false
kms_master_key_id             = ""

# Dead Letter Queue configuration
main_queue_dlq_enabled = false
dlq_queue_dlq_enabled  = false

# Statement para Lambda
sqs_lambda_statement_sid      = "AllowLambdaAccess"
sqs_lambda_actions            = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
sqs_lambda_effect             = "Allow"
sqs_lambda_type               = "Service"
sqs_lambda_identifiers        = ["lambda.amazonaws.com"]
sqs_lambda_condition_test     = "ArnLike"
sqs_lambda_condition_variable = "aws:SourceArn"
sqs_lambda_condition_values   = ["arn:aws:lambda:*:*:function:order-processor"]

# Statement para S3
sqs_s3_statement_sid      = "AllowS3ToSendMessages"
sqs_s3_actions            = ["sqs:SendMessage"]
sqs_s3_effect             = "Allow"
sqs_s3_type               = "Service"
sqs_s3_identifiers        = ["s3.amazonaws.com"]
sqs_s3_condition_test     = "ArnLike"
sqs_s3_condition_variable = "aws:SourceArn"

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
billing_mode                   = "PROVISIONED"
read_capacity                  = 5
write_capacity                 = 5
deletion_protection_enabled    = false
point_in_time_recovery         = true
server_side_encryption_enabled = true

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
    range_key       = "" # Valor vacío para indicar que no hay range_key
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "tipo_registro_fecha_actualizacion_index"
    hash_key        = "tipo_registro"
    range_key       = "fecha_actualizacion" # Aquí sí especificamos el range_key
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

# Materials table configuration (nueva)
materials_table_name = "materials"
materials_hash_key   = "codigo_material"
#materials_range_key  = "language"
materials_attributes = [
  {
    name = "codigo_material"
    type = "S"
  },
  {
    name = "nombre_material"
    type = "S"
  },
  {
    name = "ean"
    type = "S"
  }
]
materials_replicas = []
materials_gsi = [
  {
    name            = "nombre-index"
    hash_key        = "nombre_material"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "ean-index"
    hash_key        = "ean"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  }
]
# materials specific configuration
materials_billing_mode                   = "PAY_PER_REQUEST"
materials_deletion_protection_enabled    = false
materials_point_in_time_recovery         = true
materials_server_side_encryption_enabled = true
# price_history table configuration (nueva)
price_history_table_name = "pricesHistory"
price_history_hash_key   = "id"
#price_history_range_key  = "language"
price_history_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "codigo_material"
    type = "S"
  },
  {
    name = "centro"
    type = "S"
  },
  {
    name = "codigo_tienda"
    type = "S"
  }

]
price_history_replicas = []
price_history_gsi = [
  {
    name            = "GSI_codigo_material"
    hash_key        = "codigo_material"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_centro"
    hash_key        = "centro"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_codigo_tienda"
    hash_key        = "codigo_tienda"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
]

# price_history specific configuration
price_history_billing_mode                   = "PAY_PER_REQUEST"
price_history_deletion_protection_enabled    = false
price_history_point_in_time_recovery         = true
price_history_server_side_encryption_enabled = true

# note table configuration (nueva)
notes_table_name = "notes"
notes_hash_key   = "id"
#note_range_key  = "language"
notes_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "titulo"
    type = "S"
  }
]
notes_replicas = []
notes_gsi = [
  {
    name            = "titulo-index"
    hash_key        = "titulo"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]
# prices table configuration (nueva)
prices_table_name = "prices"
prices_hash_key   = "id"
#prices_range_key  = "language"
prices_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "codigo_material"
    type = "S"
  },
  {
    name = "centro"
    type = "S"
  },
  {
    name = "codigo_tienda"
    type = "S"
  }
]
prices_replicas = []
prices_gsi = [
  {
    name            = "GSI_codigo_material"
    hash_key        = "codigo_material"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_centro"
    hash_key        = "centro"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_codigo_tienda"
    hash_key        = "codigo_tienda"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
]
# prices specific configuration
prices_billing_mode                   = "PAY_PER_REQUEST"
prices_deletion_protection_enabled    = false
prices_point_in_time_recovery         = true
prices_server_side_encryption_enabled = true
# Price Tag Segment table configuration (nueva)
PriceTagSegment_table_name = "PriceTagSegment"
PriceTagSegment_hash_key   = "id"
#prices_range_key  = "language"
PriceTagSegment_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "nombre_segmento"
    type = "S"
  }
]
PriceTagSegment_replicas = []
PriceTagSegment_gsi = [
  {
    name            = "nombre_segmento-index"
    hash_key        = "nombre_segmento"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]
# Price Tag Rule table configuration (nueva)
PriceTagRule_table_name = "PriceTagRule"
PriceTagRule_hash_key   = "id"
#prices_range_key  = "language"
PriceTagRule_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "centro"
    type = "S"
  },
  {
    name = "codigo_tienda"
    type = "S"
  },
  {
    name = "codigo_material"
    type = "S"
  },
  {
    name = "segmento"
    type = "S"
  }
]
PriceTagRule_replicas = []
PriceTagRule_gsi = [
  {
    name            = "GSI_centro"
    hash_key        = "centro"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_codigo_tienda"
    hash_key        = "codigo_tienda"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_codigo_material"
    hash_key        = "codigo_material"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_segmento"
    hash_key        = "segmento"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
]

# regionals table configuration (nueva)
regionals_table_name = "regionals"
regionals_hash_key   = "centro"
#prices_range_key  = "language"
regionals_attributes = [
  {
    name = "centro"
    type = "S"
  },
  {
    name = "nombre_centro"
    type = "S"
  },
  {
    name = "division"
    type = "S"
  },
  {
    name = "fecha_actualizacion_job"
    type = "S"
  }
]
regionals_replicas = []
regionals_gsi = [
  {
    name            = "GSI_centro"
    hash_key        = "centro"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_nombre_centro"
    hash_key        = "nombre_centro"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_division"
    hash_key        = "division"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  },
  {
    name            = "GSI_fecha_actualizacion_job"
    hash_key        = "fecha_actualizacion_job"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }

]



# matCenters table configuration (nueva)
matCenters_table_name = "matCenters"

matCenters_hash_key = "id"
#prices_range_key  = "language"
matCenters_attributes = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "codigo_material"
    type = "S"
  },
  {
    name = "centro"
    type = "S"
  },
  {
    name = "estado"
    type = "S"
  },
  {
    name = "fecha_actualizacion_job"
    type = "S"
  }
]
matCenters_replicas = []
matCenters_gsi = [
  {
    name            = "GSI_codigo_material"
    hash_key        = "codigo_material"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_centro"
    hash_key        = "centro"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_estado"
    hash_key        = "estado"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  },
  {
    name            = "GSI_fecha_actualizacion_job"
    hash_key        = "fecha_actualizacion_job"
    projection_type = "ALL"
    # read_capacity   = 5
    # write_capacity  = 5
  }

]
# matCenters specific configuration
matCenters_billing_mode                   = "PAY_PER_REQUEST"
matCenters_deletion_protection_enabled    = false
matCenters_point_in_time_recovery         = true
matCenters_server_side_encryption_enabled = true

# ######################################################################
# # KMS - Amazon 
# ######################################################################

# terraform.tfvars

# General KMS configuration
deletion_window_in_days = 7
enable_key_rotation     = true
multi_region            = false

# DynamoDB KMS configuration
alias_dynamo       = "dynamo"
dynamo_description = "KMS key for DynamoDB encryption"
dynamo_sid         = "AllowDynamoDB"
dynamo_effect      = "Allow"
dynamo_kms_actions = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
dynamo_principal_type        = "Service"
dynamo_principal_identifiers = ["dynamodb.amazonaws.com"]
dynamo_conditions            = []

# S3 KMS configuration
alias_s3       = "s3"
s3_description = "KMS key for S3 encryption"
s3_sid         = "AllowS3"
s3_effect      = "Allow"
s3_kms_actions = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
s3_principal_type        = "Service"
s3_principal_identifiers = ["s3.amazonaws.com"]
s3_conditions            = []

alias_secrets_api       = "secrets-api"
secrets_api_description = "KMS key for API Secrets encryption"
secrets_api_sid         = "AllowSecretsManagerAPI"
secrets_api_effect      = "Allow"
secrets_api_kms_actions = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
secrets_api_principal_type        = "Service"
secrets_api_principal_identifiers = ["secretsmanager.amazonaws.com"]
secrets_api_conditions            = []

alias_secrets_db       = "secrets-db"
secrets_db_description = "KMS key for DB Secrets encryption"
secrets_db_sid         = "AllowSecretsManagerDB"
secrets_db_effect      = "Allow"
secrets_db_kms_actions = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
secrets_db_principal_type        = "Service"
secrets_db_principal_identifiers = ["secretsmanager.amazonaws.com"]
secrets_db_conditions            = []

# Lambda acceso a DynamoDB KMS
lambda_dynamo_sid    = "AllowLambdaAccess"
lambda_dynamo_effect = "Allow"
lambda_dynamo_kms_actions = [
  "kms:Decrypt",
  "kms:DescribeKey",
  "kms:GenerateDataKey*"
]
lambda_dynamo_principal_type        = "Service"
lambda_dynamo_principal_identifiers = ["lambda.amazonaws.com"]
lambda_dynamo_conditions            = []

# ECR KMS configuration
alias_ecr       = "ecr"
ecr_description = "KMS key for ecr encryption"
ecr_sid         = "AllowEcr"
ecr_effect      = "Allow"
ecr_kms_actions = [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
]
ecr_principal_type        = "Service"
ecr_principal_identifiers = ["ecr.amazonaws.com"]
ecr_conditions            = []

# ######################################################################
# # API Gateway - Amazon 
# ######################################################################

# API Gateway Configuration
api_name        = "users-api"
api_description = "API for managing users"
endpoint_types  = ["REGIONAL"]

# V1 endpoint configuration
v1_path_part = "v1"
v1_path      = "v1"
v1_parent_id = null

# Users endpoint configuration
users_path_part = "users"
users_path      = "v1/users"
users_parent_id = "v1"

# Method configuration
users_http_method        = "GET"
users_authorization      = "CUSTOM"
users_request_parameters = {}

# Integration configuration
users_integration_http_method       = "POST"
users_integration_type              = "AWS_PROXY"
users_integration_request_templates = {}

# Response configuration
users_response_status_code = "200"
users_response_models = {
  "application/json" = "Empty"
}
users_response_parameters            = {}
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
user_pool_name           = "main"
username_attributes      = ["email"]
auto_verified_attributes = ["email"]

# Password Policy
password_minimum_length          = 8
password_require_lowercase       = true
password_require_numbers         = true
password_require_symbols         = true
password_require_uppercase       = true
password_temporary_validity_days = 7

# MFA Configuration
mfa_configuration = "OFF"

# SMS Configuration
sms_external_id = "cognito-sms-external-id"
sms_caller_arn  = "" # Dejar vacío si no se usa MFA por SMS

# Email Configuration
email_sending_account = "COGNITO_DEFAULT"
email_from_address    = null # Usar null para dirección por defecto de Cognito

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
cognito_domain  = "my-auth-domain"
certificate_arn = null # Usar null si no se tiene un certificado personalizado

# Client Apps Configuration
user_pool_clients = [
  {
    name            = "web-client"
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
    supported_identity_providers  = ["COGNITO"]
    prevent_user_existence_errors = "ENABLED"
  },
  {
    name            = "mobile-client"
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
    supported_identity_providers  = ["COGNITO"]
    prevent_user_existence_errors = "ENABLED"
  }
]

# ######################################################################
# #  Secrets Manager - Amazon 
# ######################################################################

# General configuration
recovery_window_in_days        = 7
force_overwrite_replica_secret = false

# API Secret configuration
api_secret_username    = "api_user"
api_secret_password    = "api_password"
api_secret_name        = "api-credentials"
api_secret_description = "API authentication credentials"
api_version_stages     = ["AWSCURRENT"]
api_replicas           = []

# DB Secret configuration
db_secret_username     = "ESB_SAP"
db_secret_password     = "EsB_SBD23ai_D1"
db_secret_host         = "10.31.193.179"
db_secret_port         = 1521
db_secret_service_name = "DBBCT_DBBCT_pdbdev.paas.oracle.com"
db_secret_name         = "database-credentials"
db_secret_description  = "Database connection credentials"
db_version_stages      = ["AWSCURRENT"]
db_replicas            = []

# Política del secreto de la base de datos
db_secret_policy_version               = "2012-10-17"
db_secret_policy_effect                = "Allow"
db_secret_policy_principal_type        = "Service"
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
waf_rate_limit = 500  # 500 requests per 5 minutes per IP

# Body Size Limit Configuration (16 KB = 16384 bytes)
waf_body_size_limit = 16384

# Geo Blocking Configuration
waf_blocked_countries = [
  "CO", # Colombia
  "US", # EEUU
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
waf_resource_arns = "arn:aws:apigateway:us-east-1::/restapis/1rwv52ahpl/stages/qa"

# Logging Configuration (opcional)
# Dejando como null para no configurar logging automáticamente
waf_log_destination_configs = null

waf_redacted_fields = [
  "Authorization",
  "Cookie"
]


# # ######################################################################
# # #  Glue Job - ETL job for data processing
# # ######################################################################
# Configuración de jobs de Glue
glue_config = [

  # Glue Job extraction regionals
  {

    alias     = "extraction-regionals"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of extraction regionals"
    script_location     = "s3://apificacion-d1-qa-glue/regionals/extraction/apificacion-d1-script-glue-extraction-regionals.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # CONFIGURACIÓN DE CONEXIONES ASOCIADAS AL JOB
    connections = ["extraction-oracle-db"] # Lista de alias de conexiones a asociar

    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"      = "us-east-1"
      "--SECRET_KEY"       = "apificacion-d1-qa-secret-database-credentials"
      "--BUCKET_NAME"      = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "SecretManagerAccess"
        effect     = "Allow"
        actions    = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        resources  = ["arn:aws:secretsmanager:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job extraction materials
  {

    alias     = "extraction-materials"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of extraction materials"
    script_location     = "s3://apificacion-d1-qa-glue/materials/extraction/apificacion-d1-script-glue-extraction-materials.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # CONFIGURACIÓN DE CONEXIONES ASOCIADAS AL JOB
    connections = ["extraction-oracle-db"] # Lista de alias de conexiones a asociar

    log_retention_days = 7

    additional_default_arguments = {

     
      "--REGION_NAME"         = "us-east-1"
      "--SECRET_KEY"          = "apificacion-d1-qa-secret-database-credentials"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"
    
    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "SecretManagerAccess"
        effect     = "Allow"
        actions    = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        resources  = ["arn:aws:secretsmanager:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job extraction matcenters
  {

    alias     = "extraction-matcenters"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of extraction matcenters"
    script_location     = "s3://apificacion-d1-qa-glue/matcenters/extraction/apificacion-d1-script-glue-extraction-matcenters.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # CONFIGURACIÓN DE CONEXIONES ASOCIADAS AL JOB
    connections = ["extraction-oracle-db"] # Lista de alias de conexiones a asociar

    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"         = "us-east-1"
      "--SECRET_KEY"          = "apificacion-d1-qa-secret-database-credentials"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "SecretManagerAccess"
        effect     = "Allow"
        actions    = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        resources  = ["arn:aws:secretsmanager:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job extraction prices
  {

    alias     = "extraction-prices"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of extraction prices"
    script_location     = "s3://apificacion-d1-qa-glue/prices/extraction/apificacion-d1-script-glue-extraction-prices.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # CONFIGURACIÓN DE CONEXIONES ASOCIADAS AL JOB
    connections = ["extraction-oracle-db"] # Lista de alias de conexiones a asociar

    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"      = "us-east-1"
      "--SECRET_KEY"       = "apificacion-d1-qa-secret-database-credentials"
      "--BUCKET_NAME"      = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "SecretManagerAccess"
        effect     = "Allow"
        actions    = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        resources  = ["arn:aws:secretsmanager:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },


  # Glue Job normalized regionals
  {

    alias     = "normalized-regionals"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of normalized regionals"
    script_location     = "s3://apificacion-d1-qa-glue/regionals/normalized/apificacion-d1-script-glue-normalized-regionals.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"



    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"
      

    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "DynamodbAccess"
        effect     = "Allow"
        actions    = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan"]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job normalized materials
  {

    alias     = "normalized-materials"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of normalized materials"
    script_location     = "s3://apificacion-d1-qa-glue/materials/normalized/apificacion-d1-script-glue-normalized-materials.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"



    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"
     
    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "DynamodbAccess"
        effect     = "Allow"
        actions    = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan"]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job normalized matcenters
  {

    alias     = "normalized-matcenters"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of normalized matcenters"
    script_location     = "s3://apificacion-d1-qa-glue/matcenters/normalized/apificacion-d1-script-glue-normalized-matcenters.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"



    log_retention_days = 7

    additional_default_arguments = {

      
      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"
      
    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "DynamodbAccess"
        effect     = "Allow"
        actions    = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan"]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job normalized prices
  {

    alias     = "normalized-prices"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of normalized prices"
    script_location     = "s3://apificacion-d1-qa-glue/prices/normalized/apificacion-d1-script-glue-normalized-prices.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"



    log_retention_days = 7

    additional_default_arguments = {

      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"


    }

    iam_statements = [
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      },
      {
        sid        = "DynamodbAccess"
        effect     = "Allow"
        actions    = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan"]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job comparison regionals
  {

    alias     = "comparison-regionals"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of comparison regionals"
    script_location     = "s3://apificacion-d1-qa-glue/regionals/comparison/apificacion-d1-script-glue-comparison-regionals.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # max_capacity y python_version no se especifican porque no es pythonshell

    log_retention_days = 7

    additional_default_arguments = {

      "--APP_ENV"     = "qa"
      "--REGION_NAME" = "us-east-1"
      "--BUCKET_NAME" = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid    = "DynamodbAccess"
        effect = "Allow"
        actions = ["dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable"
        ]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      },
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job comparison materials
  {

    alias     = "comparison-materials"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of comparison materials"
    script_location     = "s3://apificacion-d1-qa-glue/materials/comparison/apificacion-d1-script-glue-comparison-materials.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # max_capacity y python_version no se especifican porque no es pythonshell

    log_retention_days = 7

    additional_default_arguments = {

      "--APP_ENV"             = "qa"
      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid    = "DynamodbAccess"
        effect = "Allow"
        actions = ["dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable"
        ]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      },
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job comparison matcenters
  {

    alias     = "comparison-matcenters"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of comparison matcenters"
    script_location     = "s3://apificacion-d1-qa-glue/matcenters/comparison/apificacion-d1-script-glue-comparison-matcenters.py"
    temp_location       = "temp/"
    spark_logs_location = "s3://apificacion-d1-qa-logs-trivi/trivy-reports/glue_test/"

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    # runtime no se especifica porque no es glueray

    # max_capacity y python_version no se especifican porque no es pythonshell

    log_retention_days = 7

    additional_default_arguments = {

      "--APP_ENV"             = "qa"
      "--REGION_NAME"         = "us-east-1"
      "--BUCKET_NAME"         = "apificacion-d1-qa-materials"

    }

    iam_statements = [
      {
        sid    = "DynamodbAccess"
        effect = "Allow"
        actions = ["dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable"
        ]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      },
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      }
    ]
  },

  # Glue Job comparison prices
  {

    alias     = "comparison-prices"
    job_type  = "glueetl"
    bucket_id = "materials"

    # ===== CAMPOS OPCIONALES (solo especifica los que quieras cambiar) =====
    description         = "ETL job for data processing of comparison prices"
    script_location     = "s3://apificacion-d1-qa-glue/prices/comparison/apificacion-d1-script-glue-comparison-prices.py"
    temp_location       = "temp/"
    spark_logs_location = ""

    # Configuración específica para glueetl
    glue_version      = "4.0"
    worker_type       = "G.1X"
    number_of_workers = 12
    job_language      = "python"
    
    # CONFIGURACIÓN DE CONEXIONES ASOCIADAS AL JOB
    connections = ["vpc-connectivity"] # En lugar de extraction-oracle-db

    # max_capacity y python_version no se especifican porque no es pythonshell

    log_retention_days = 7

    additional_default_arguments = {

      "--APP_ENV"     = "qa"
      "--REGION_NAME" = "us-east-1"
      "--BUCKET_NAME" = "apificacion-d1-qa-materials"
      "--ENDPONT_HISTORICAL_ETL" = "http://apificacion-d1-qa-lb-prices-nlb-27538805b2c5a83c.elb.us-east-1.amazonaws.com:8085/v1/price/updateHistoricalETL"

    }

    iam_statements = [
      {
        sid    = "DynamodbAccess"
        effect = "Allow"
        actions = ["dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable"
        ]
        resources  = ["arn:aws:dynamodb:us-east-1:*"]
        principals = []
        conditions = []
      },
      {
        sid        = "S3TestAccess"
        effect     = "Allow"
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        resources  = ["arn:aws:s3:::*"]
        principals = []
        conditions = []
      }
    ]
  },
]


######################################################################
# Glue Connections - Connections for glue
######################################################################

# Configuración de conexiones de Glue
glue_connections_config = [
  # Conexión personalizada/custom apificacion-d1-qa-glue-connection-extraction-oracle-db
  {
    alias           = "extraction-oracle-db"
    connection_type = "CUSTOM"
    description     = "Custom Oracle connector for data extraction"
    # Configuración de red (desde el main.tf)
    # secrets_manager_secret_arn se pasa dinámicamente desde main.tf
    # Propiedades específicas del Custom Connector
    connection_properties = {
      "CONNECTOR_URL"        = "s3://apificacion-d1-qa-glue/Connections/ojdbc11.jar"
      "CONNECTOR_TYPE"       = "JDBC"
      "CONNECTOR_CLASS_NAME" = "oracle.jdbc.driver.OracleDriver"
      # Configuración JDBC dentro del custom connector
      "JDBC_CONNECTION_URL" = "jdbc:oracle:thin:@//10.31.193.179:1521/DBBCT_DBBCT_pdbdev.paas.oracle.com"
      "JDBC_ENFORCE_SSL"    = "false"
      # Parámetros adicionales del custom connector
      "URL_PARAMETER_DELIMITER" = ";"
      "CONNECTION_TIMEOUT"      = "30"
      "QUERY_TIMEOUT"           = "300"
      # Configuración específica de Oracle
      "ORACLE_SERVICE_NAME" = "DBBCT_DBBCT_pdbdev.paas.oracle.com"
      "ORACLE_SID"          = ""
      "FETCH_SIZE"          = "1000"
      # Propiedades adicionales que podrías necesitar para el custom connector
      "DRIVER_VERSION"       = "21.1.0.0"
      "CONNECTION_POOL_SIZE" = "10"
      "VALIDATION_QUERY"     = "SELECT 1 FROM DUAL"
    }
  },
  {
    alias           = "vpc-connectivity"
    connection_type = "NETWORK"
    description     = "VPC connection for HTTP calls"
    
    # Sin secrets manager para conexión de red básica
    connection_properties = {
      "NETWORK_TYPE" = "VPC"
    }
  }
]


# ######################################################################
# #  ECR Module
# ######################################################################

ecr_config = [

  # Repositorio ECR de Materials-api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "materials-api"
    description          = "Repositorio para Materials-api"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [

      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  },
  # Repositorio ECR de notes_api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "notes-api"
    description          = "Repositorio para Notes_api"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [
      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  },
  # Repositorio ECR de priceTagsRules_api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "pricetagsrules-api"
    description          = "Repositorio para priceTagsRules_api"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [
      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  },
  # Repositorio ECR de priceTagsSegments_api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "pricetagssegments-api"
    description          = "Repositorio para priceTagsSegments_api"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [
      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  },
  # Repositorio ECR de prices_api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "prices-api"
    description          = "Repositorio para prices_api"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [
      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  },
  # Repositorio ECR de pricesHistory_api
  {
    # CAMPOS OBLIGATORIOS
    alias                = "priceshistory-api"
    description          = "Repositorio para Prices History"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"

    # Encriptación con KMS para mayor seguridad
    encryption_configuration = [
      {
        encryption_type = "KMS"
        kms_key         = null # Se usará var.default_kms_key_arn automáticamente
      }
    ]

    # REGLAS SIMPLIFICADAS (sin tagPrefixList)
    lifecycle_rules = [
      {
        rulePriority = 1
        description  = "Mantener solo 30 imágenes más recientes (tagged y untagged)"
        selection = {
          tagStatus   = "any" # aplica a todas las imágenes
          countType   = "imageCountMoreThan"
          countNumber = 30
          # tagPrefixList NO NECESARIO con tagStatus = "any"
        }
        action = {
          type = "expire"
        }
      }
    ]
  }



]




# ######################################################################
# #  ELB  - Elastic Load Balancing
# ######################################################################

lb_config = [
  {

    alias                            = "prices-nlb"
    description                      = "NLB para conectar con NLB de Impresión de Precios"
    internal                         = true
    load_balancer_type               = "network"
    idle_timeout                     = 60
    drop_invalid_header_fields       = false
    enable_deletion_protection       = false
    enable_cross_zone_load_balancing = true
    # subnets y security_groups se manejan desde main.tf

    # WAF (opcional)
    waf_arn = "" # Agregar ARN de WAF

    # TARGET GROUPS - Microservicios
    target_groups = [
      # =======================================================================
      # TRACKING SERVICE
      # =======================================================================
      # TARGET GROUP - Microservicio materials
      {
        target_application  = "materials"
        port                = "8081"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"
      },
      # TARGET GROUP - Microservicio notes
      {
        target_application  = "notes"
        port                = "8080"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"

      },
      # TARGET GROUP - Microservicio prices
      {
        target_application  = "prices"
        port                = "8084"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"

      },
      # TARGET GROUP - Microservicio segments
      {
        target_application  = "segments"
        port                = "8083"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"

      },
      # TARGET GROUP - Microservicio rules
      {
        target_application  = "rules"
        port                = "8082"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"

      },
      # TARGET GROUP - Microservicio pricehistory
      {
        target_application  = "pricehist"
        port                = "8085"
        protocol            = "TCP"
        target_type         = "ip"
        healthy_threshold   = "3"
        interval            = "30"
        path                = "/actuator/health"
        unhealthy_threshold = "3"

      },


    ]

    # LISTENERS - Puerto por microservicio
    listeners = [

      # LISTENERS - Puerto por microservicio materials

      {
        port                    = "8081"
        protocol                = "TCP"
        default_target_group_id = "materials"
      },
      # LISTENERS - Puerto por microservicio notes
      {
        port                    = "8080"
        protocol                = "TCP"
        default_target_group_id = "notes"
      },
      # LISTENERS - Puerto por microservicio prices
      {
        port                    = "8084"
        protocol                = "TCP"
        default_target_group_id = "prices"
      },
      # LISTENERS - Puerto por microservicio segments
      {
        port                    = "8083"
        protocol                = "TCP"
        default_target_group_id = "segments"
      },
      # LISTENERS - Puerto por microservicio rules
      {
        port                    = "8082"
        protocol                = "TCP"
        default_target_group_id = "rules"
      },
      # LISTENERS - Puerto por microservicio pricehistory
      {
        port                    = "8085"
        protocol                = "TCP"
        default_target_group_id = "pricehist"
      },
    ]
  },



]


# ######################################################################
# #  ECS Cluster - Elastic Container Service 
# ######################################################################

ecs_config = [
  {
    alias                  = "prices"
    description            = "Cluster para microservicios de Impresión de Etiquetas "
    container_insights     = "enabled" #  Hablitiar CloudWatch monitoring "enabled", "disabled"
    enable_execute_command = true      # Útil para debugging
  }
]

service_discovery_alias = "prices"


# ######################################################################
# #  ECS Services - Elastic Container Service 
# ######################################################################


# Configuración de servicios ECS
ecs_services = {
  # Configuración de servicio del Materials
  "materials-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false

    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "materials-ecs"
    image_key          = "materials-api"
    parameter_key      = "materials_api"
    # target_group_key   = "materials" # Coincide con ELB target_application

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "materials-api" = {
        # Configuración básica del contenedor
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false
        linux_parameters = {
          init_process_enabled = true
        }


        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8081
            host_port      = 8081
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    target_group_key = "materials" # Key que buscará en target_groups_map (coincide con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "materials-api"
      container_port = 8081
    }

    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "materials-api"

        client_alias = [
          {
            port     = 8081
            dns_name = "materials"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/materials"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-materials"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-materials"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
  # Configuración de servicio Notes
  "notes-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false
    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "notes-ecs"
    image_key          = "notes-api"
    parameter_key      = "notes_api"

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "notes-api" = {
        # Configuración básica del contenedor
        # image se maneja desde main.tf
        # image                    = "390403853861.dkr.ecr.us-east-1.amazonaws.com/apificacion-d1-qa-ecr-materials-api:latest"
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false

        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8080
            host_port      = 8080
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    target_group_key = "notes" # Key que buscará en target_groups_map (coincide con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "notes-api"
      container_port = 8080
    }


    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "notes-api"

        client_alias = [
          {
            port     = 8080
            dns_name = "notes"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/notes"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-notes"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-notes"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
  # Configuración de servicio prices
  "prices-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false
    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "prices-ecs"
    image_key          = "prices-api"
    parameter_key      = "prices_api"

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "prices-api" = {
        # Configuración básica del contenedor
        # image se maneja desde main.tf
        # image                    = "390403853861.dkr.ecr.us-east-1.amazonaws.com/apificacion-d1-qa-ecr-materials-api:latest"
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false
        linux_parameters = {
          init_process_enabled = true
        }

        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8084
            host_port      = 8084
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    target_group_key = "prices" # Key que buscará en target_groups_map (coincide con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "prices-api"
      container_port = 8084
    }

    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "prices-api"

        client_alias = [
          {
            port     = 8084
            dns_name = "prices"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/prices"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-prices"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-prices"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
  # Configuración de servicio priceTagSegments
  "pricetagsegments-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false
    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "priceTagSegments-ecs"  # Nombre del security group 
    image_key          = "priceTagSegments-api"  # Nombre del Contenedor al que va ser asigando la imagen ecr
    parameter_key      = "priceTagsSegments_api" # se agrega como indicador o Key para busqueda de la primera frase del parameter

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "pricetagsegments-api" = {
        # Configuración básica del contenedor
        # image se maneja desde main.tf
        # image                    = "390403853861.dkr.ecr.us-east-1.amazonaws.com/apificacion-d1-qa-ecr-materials-api:latest"
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false

        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8083
            host_port      = 8083
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    target_group_key = "segments" # Key que buscará en target_groups_map (coincide con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "pricetagsegments-api"
      container_port = 8083
    }

    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "pricetagsegments-api"

        client_alias = [
          {
            port     = 8083
            dns_name = "segments"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/segments"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-pricetagsegments"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-pricetagsegments"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
  # Configuración de servicio priceTagRules
  "pricetagrules-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false
    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "priceTagRules-ecs"
    image_key          = "priceTagRules-api"
    parameter_key      = "priceTagsRules_api"

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "pricetagrules-api" = {
        # Configuración básica del contenedor
        # image se maneja desde main.tf
        # image                    = "390403853861.dkr.ecr.us-east-1.amazonaws.com/apificacion-d1-qa-ecr-materials-api:latest"
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false

        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8082
            host_port      = 8082
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    # Configuración de balanceador de carga - AHORA AUTOMÁTICO
    target_group_key = "rules" # Key que buscará en target_groups_map (coincide con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "pricetagrules-api"
      container_port = 8082
    }

    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "pricetagrules-api"

        client_alias = [
          {
            port     = 8082
            dns_name = "rules"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/rules"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-pricetagrules"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-pricetagrules"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
  # Configuración de servicio pricehistory
  "pricehistory-api" = {
    # Configuración básica del servicio
    cluster_name               = "apificacion-d1-qa-ecs-prices" # Nombre del cluster creado por el módulo de clusters
    desired_count              = 1
    deployment_maximum_percent = 200
    deployment_minimum_percent = 100
    enable_execute_command     = true # Para debugging en qa
    force_new_deployment       = false
    health_check_grace_period  = 60
    launch_type                = "FARGATE"
    platform_version           = "LATEST"
    scheduling_strategy        = "REPLICA"

    # Configuración de red
    assign_public_ip = false
    # subnets y security_groups se manejan desde main.tf

    # Claves para mapeo dinámico
    security_group_key = "priceHistory-ecs"
    image_key          = "priceHistory-api"
    parameter_key      = "pricesHistory_api"
    # target_group_key   = "pricehist" # Para mapeo automático de Target Group

    # Configuración de definición de tarea
    task_cpu                 = 1024
    task_memory              = 2048
    requires_compatibilities = ["FARGATE"]
    task_iam_permissions = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "*"
        ]
      }

    ]

    # Políticas AWS managed adicionales si necesitas
    task_managed_policy_arns = [
      # "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      # "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    # Configuración de contenedores
    containers = {
      "pricehistory-api" = {
        # Configuración básica del contenedor
        # image se maneja desde main.tf
        # image                    = "390403853861.dkr.ecr.us-east-1.amazonaws.com/apificacion-d1-qa-ecr-materials-api:latest"
        cpu                      = 896
        memory                   = 1792
        essential                = true
        readonly_root_filesystem = false

        # Configuración de comandos y entorno
        command = []
        environment = [
          {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "qa"
          }

        ]

        # Configuración de secretos - Se agregan automáticamente desde Parameter Store
        # secrets = [] # Manejado automáticamente por parameters_map

        # Configuración de puertos
        port_mappings = [
          {
            name           = "http" # Para Service Connect
            container_port = 8085
            host_port      = 8085
            protocol       = "tcp"
          }
        ]

        # Configuración de healthcheck
        # healthcheck = {
        #   command     = ["CMD-SHELL", "curl -f http://localhost:8080/health || exit 1"]
        #   interval    = 30
        #   timeout     = 5
        #   retries     = 3
        #   start_period = 60
        # }

        # Configuración de logs
        enable_cloudwatch_logs = true
      }
    }

    # Configuración de balanceador de carga - AHORA AUTOMÁTICO
    target_group_key = "pricehist" # Key que buscará en target_groups_map (debe coincidir con ELB)
    load_balancer = {
      # target_group_arn se asigna automáticamente
      container_name = "pricehistory-api"
      container_port = 8085
    }

    # *** SERVICE CONNECT CONFIGURACIÓN - HABILITADO ***
    service_connect_config = {
      enabled   = true
      namespace = "apificacion-d1-qa-sc-prices.local"

      service = {
        port_name      = "http"
        discovery_name = "pricehistory-api"

        client_alias = [
          {
            port     = 8085
            dns_name = "pricehistory"
          }
        ]
      }

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/aws/ecs/service-connect/pricehistory"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "service-connect"
          "awslogs-create-group"  = "true"
        }
      }
    }

    # Configuración de Auto Scaling
    enable_autoscaling = true
    autoscaling_config = {
      min_capacity = 1
      max_capacity = 3
      scaling_policies = [
        {
          name        = "cpu-pricehistory"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
          }
        },
        {
          name        = "memory-pricehistory"
          policy_type = "TargetTrackingScaling"
          target_tracking_configuration = {
            target_value           = 80.0
            scale_in_cooldown      = 300
            scale_out_cooldown     = 300
            predefined_metric_type = "ECSServiceAverageMemoryUtilization"
          }
        }
      ]
    }

    # Configuración de logs
    log_retention_days     = 30
    log_encryption_key_arn = null # Usar encriptación por defecto de AWS

    # Etiquetas adicionales
    additional_tags = {
      # "service-tier"        = "critical"
    }
  },
}

# ######################################################################
# #  Parameter Store - AWS Systems Manager Parameter Store
# ######################################################################

parameter_store_config = [

  # Parameter store para services de Materials
  {
    alias = "materials_api_table"
    name  = "d1_materials_api/materials.table.name" # Se convertirá a /qa/d1_materials_api/materials.table.name
    value = "apificacion-d1-dynamo-qa-materials-8"

    description = "URL del API de materials"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "materials_api_port"
    name  = "d1_materials_api/custom.server.port" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "8081"

    description = "Puerto del API de materials"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },

  # Parameter store para services de Notes
  {
    alias = "notes_api_table"
    name  = "d1_notes_api/notes.table.name" # Se convertirá a /qa/d1_notes_api/notes.table.name
    value = "apificacion-d1-dynamo-qa-notes-10"

    description = "URL del API de notes"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "notes_api_port"
    name  = "d1_notes_api/custom.server.port" # Se convertirá a /qa/d1_notes_api/custom.server.port
    value = "8080"

    description = "Puerto del API de notes"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "notes_api_url_materials"
    name  = "d1_notes_api/materials.api.url" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "http://materials:8081"

    description = "URL del API de notes usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },

  # Parameter store para services de Prices
  {
    alias = "prices_api_table"
    name  = "d1_prices_api/prices.table.name" # Se convertirá a /qa/d1_materials_api/materials.table.name
    value = "apificacion-d1-dynamo-qa-prices-11"

    description = "URL del API de prices"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "prices_api_port"
    name  = "d1_prices_api/custom.server.port" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "8084"

    description = "Puerto del API de prices"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "prices_api_url_materials"
    name  = "d1_prices_api/materials.api.url" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "http://materials:8081"

    description = "URL del API de prices usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "prices_api_url_notes"
    name  = "d1_prices_api/notes.api.url" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "http://notes:8080"

    description = "URL del API de prices usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "prices_api_url_priceTagRules"
    name  = "d1_prices_api/priceTagRules.api.url" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "http://rules:8082"

    description = "URL del API de prices usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "prices_api_url_priceTagSegments"
    name  = "d1_prices_api/priceTagSegments.api.url" # Se convertirá a /qa/d1_materials_api/custom.server.port
    value = "http://segments:8083"

    description = "URL del API de prices usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  # Parameter store para services de priceTagSegments
  {
    alias = "priceTagsSegments_api_table"
    name  = "d1_priceTagsSegments_api/priceTagsSegments.table.name" # Se convertirá a /qa/d1_priceTagsSegments_api/priceTagSegments.table.name
    value = "apificacion-d1-dynamo-qa-PriceTagSegment-12"

    description = "URL del API de priceTagsSegments"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },

  {
    alias = "priceTagsSegments_api_port"
    name  = "d1_priceTagsSegments_api/custom.server.port" # Se convertirá a /qa/d1_priceTagsSegments_api/custom.server.port
    value = "8083"

    description = "Puerto del API de priceTagsSegments"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "priceTagsSegments_api_url"
    name  = "d1_priceTagsSegments_api/priceTagsRules.api.url" # Se convertirá a /qa/d1_priceTagsSegments_api/priceTagsRules.api.url
    value = "http://rules:8082"

    description = "URL del API de priceTagsSegments usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  # Parameter store para services de priceTagRules
  {
    alias = "priceTagsRules_api_table"
    name  = "d1_priceTagsRules_api/priceTagsRules.table.name" # Se convertirá a /qa/d1_priceTagsRules_api/priceTagRules.table.name
    value = "apificacion-d1-dynamo-qa-PriceTagRule-13"

    description = "URL del API de priceTagsRules"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "priceTagsRules_api_port"
    name  = "d1_priceTagsRules_api/custom.server.port" # Se convertirá a /qa/d1_priceTagsRules_api/custom.server.port
    value = "8082"

    description = "Puerto del API de priceTagsRules"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },

  # Parameter store para services de priceshistory
  {
    alias = "pricesHistory_api_table"
    name  = "d1_pricesHistory_api/pricesHistory.table.name" # Se convertirá a /qa/d1_pricesHistory_api/pricesHistory.table.name
    value = "apificacion-d1-dynamo-qa-pricesHistory-9"

    description = "URL del API de pricesHistory"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "pricesHistory_api_port"
    name  = "d1_pricesHistory_api/custom.server.port" # Se convertirá a /qa/d1_pricesHistory_api/custom.server.port
    value = "8085"

    description = "Puerto del API de pricesHistory"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "pricesHistory_api_url_materials"
    name  = "d1_pricesHistory_api/materials.api.url" # Se convertirá a /qa/d1_pricesHistory_api/materials.api.url
    value = "http://materials:8081"

    description = "URL del API de pricesHistory usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "pricesHistory_api_url_notes"
    name  = "d1_pricesHistory_api/notes.api.url" # Se convertirá a /qa/d1_pricesHistory_api/notes.api.url
    value = "http://notes:8080"

    description = "URL del API de pricesHistory usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "pricesHistory_api_url_priceTagRules"
    name  = "d1_pricesHistory_api/priceTagRules.api.url" # Se convertirá a /qa/d1_pricesHistory_api/priceTagRules.api.url
    value = "http://rules:8082"

    description = "URL del API de pricesHistory usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },
  {
    alias = "pricesHistory_api_url_priceTagSegments"
    name  = "d1_pricesHistory_api/priceTagSegments.api.url" # Se convertirá a /qa/d1_pricesHistory_api/priceTagSegments.api.url
    value = "http://segments:8083"

    description = "URL del API de pricesHistory usando Service Connect"
    type        = "String"
    tier        = "Standard"
    overwrite   = true
  },


]


# ######################################################################
# #  Step Functions - AWS Step Functions State Machines
# ######################################################################

step_function_config = [
  {
    alias       = "prices"
    description = "Orquesta el pipeline completo de procesamiento de datos impresion de precios"
    type        = "STANDARD"

    # Definición desde S3
    s3_definition = {
      bucket = "apificacion-d1-qa-step-functions"
      key    = "workflows/data-processing.json"
    }

    # Configuración de logging (el módulo creará el log group automáticamente)
    logging_configuration = {
      level                  = "ALL"
      include_execution_data = true
      destinations           = []
    }

    # Habilitar X-Ray tracing
    tracing_configuration = {
      enabled = false
    }

    log_retention_days = 30

    # IAM STATEMENTS PERSONALIZADOS 
    iam_statements = [
      {
        sid    = "GlueJobsAccess"
        effect = "Allow"
        actions = [
          "glue:StartJobRun",
          "glue:GetJobRun",
          "glue:GetJobRuns",
          "glue:BatchStopJobRun",
          "glue:GetJob",
          "glue:BatchGetJobs"
        ]
        resources = [
          "arn:aws:glue:us-east-1:*",
          "arn:aws:glue:us-east-1:*",
          "arn:aws:glue:us-east-1:*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "LambdaInvokePermissions"
        effect = "Allow"
        actions = [
          "lambda:InvokeFunction",
          "lambda:InvokeAsync"
        ]
        resources = [
          "arn:aws:lambda:us-east-1:*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "DynamoDBAccess"
        effect = "Allow"
        actions = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        resources = [
          "arn:aws:dynamodb:us-east-1:*",
          "arn:aws:dynamodb:us-east-1:*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "S3DataAccess"
        effect = "Allow"
        actions = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        resources = [
          "arn:aws:s3:::*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "EventBridgeAccess"
        effect = "Allow"
        actions = [
          "events:PutEvents"
        ]
        resources = [
          "arn:aws:events:us-east-1:*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "SecretsManagerAccess"
        effect = "Allow"
        actions = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        resources = [
          "arn:aws:secretsmanager:us-east-1:*"
        ]
        principals = []
        conditions = []
      },
      {
        sid    = "KmsAccess"
        effect = "Allow"
        actions = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        resources = [
          "*"
        ]
        principals = []
        conditions = []
      }
    ]

  }
]
