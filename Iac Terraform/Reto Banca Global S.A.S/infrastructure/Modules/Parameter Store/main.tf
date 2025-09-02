# main.tf del módulo Parameter Store

# Data source para KMS alias por defecto de SSM
data "aws_kms_alias" "ssm_default" {
  name = "alias/aws/ssm"
}

# SSM Parameters
resource "aws_ssm_parameter" "parameter_store" {
  for_each = local.parameter_store_config_map
  
  name            = local.resolved_parameter_names[each.key]
  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type
  
  # KMS Key ID para SecureString
  key_id = each.value.type == "SecureString" ? (
    each.value.key_id != null ? each.value.key_id : data.aws_kms_alias.ssm_default.target_key_id
  ) : null
  
  # Tags combinados
  tags = merge(
    {
      Name        = local.resolved_parameter_names[each.key]
      Alias       = each.value.alias
      Type        = each.value.type
      Tier        = each.value.tier
      Environment = var.environment
      Domain      = var.domain
      ManagedBy   = "terraform"
    },
    var.resource_tags
  )
  
  lifecycle {
    # Prevenir destrucción accidental de parámetros críticos
    prevent_destroy = false
    
    # Ignorar cambios en value si overwrite es false para evitar drift
    ignore_changes = []
  }
}