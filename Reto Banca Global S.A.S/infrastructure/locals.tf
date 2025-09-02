locals {
  extraction_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project}-${var.domain}-${var.environment}-lambda-role-extraction-store",
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project}-${var.domain}-${var.environment}-lambda-role-extraction-user"
  ]
}

locals {
  db_secret_policy_json = jsonencode({
    Version = var.db_secret_policy_version
    Statement = [
      {
        Effect = var.db_secret_policy_effect
        Principal = {
          "${var.db_secret_policy_principal_type}" = var.db_secret_policy_principal_identifiers
        }
        Action = var.db_secret_policy_actions
        Resource = var.db_secret_policy_resource
      }
    ]
  })
}

locals {
  cognito_client = element(values(module.cognito.user_pools["main"].clients), 0)
}