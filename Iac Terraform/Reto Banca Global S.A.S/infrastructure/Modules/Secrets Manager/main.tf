resource "aws_secretsmanager_secret" "secret" {
  for_each                = { for item in var.secrets_config : item.name => item }
  name                    = join("-", tolist([var.project, var.domain, var.environment, "secret", each.value.name]))
  description            = each.value.description
  kms_key_id             = each.value.kms_key_id
  recovery_window_in_days = each.value.recovery_window_in_days
  force_overwrite_replica_secret = each.value.force_overwrite_replica_secret

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "secret", each.value.name])) },
    var.resource_tags
  )

  dynamic "replica" {
    for_each = each.value.replicas != null ? each.value.replicas : []
    content {
      region     = replica.value.region
      kms_key_id = replica.value.kms_key_id
    }
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  for_each      = { for item in var.secrets_config : item.name => item }
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = each.value.secret_string
  version_stages = each.value.version_stages
}

resource "aws_secretsmanager_secret_policy" "secret_policy" {
  for_each = { for item in var.secrets_config : item.name => item if item.policy != null }
  secret_arn = aws_secretsmanager_secret.secret[each.key].arn
  policy     = each.value.policy
}