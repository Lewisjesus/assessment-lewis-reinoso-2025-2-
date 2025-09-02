# data.tf del módulo ECR

# Obtener información de la cuenta actual
data "aws_caller_identity" "current" {}

# Obtener información de la región actual
data "aws_region" "current" {}

# # Data source para obtener información sobre KMS keys (si se usan)
# data "aws_kms_key" "ecr_kms_keys" {
#   for_each = {
#     for alias, config in local.ecr_config_map : alias => config
#     if length(config.encryption_configuration) > 0 && 
#        config.encryption_configuration[0].encryption_type == "KMS" &&
#        config.encryption_configuration[0].kms_key != null
#   }
  
#   key_id = each.value.encryption_configuration[0].kms_key
# }

# # Data source para validar que las KMS keys existen y son válidas
# locals {
#   # Validación de KMS keys
#   kms_key_validation = {
#     for alias, config in local.ecr_config_map : alias => {
#       requires_kms = (
#         length(config.encryption_configuration) > 0 && 
#         config.encryption_configuration[0].encryption_type == "KMS"
#       )
#       kms_key_specified = (
#         length(config.encryption_configuration) > 0 && 
#         config.encryption_configuration[0].kms_key != null
#       )
#       kms_key_arn = (
#         length(config.encryption_configuration) > 0 && 
#         config.encryption_configuration[0].kms_key != null
#       ) ? config.encryption_configuration[0].kms_key : null
#     }
#   }
# }