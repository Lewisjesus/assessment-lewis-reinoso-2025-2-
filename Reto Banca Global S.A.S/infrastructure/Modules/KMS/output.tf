output "kms_keys" {
  description = "Map of KMS keys details"
  value = {
    for key, kms in aws_kms_key.kms_key : key => {
      id          = kms.id
      arn         = kms.arn
      key_id      = kms.key_id
      alias_name  = aws_kms_alias.kms_alias[key].name
      alias_arn   = aws_kms_alias.kms_alias[key].arn
    }
  }
}