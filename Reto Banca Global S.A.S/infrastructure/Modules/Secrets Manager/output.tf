
# outputs.tf
output "secrets" {
  description = "Map of Secrets Manager secrets details"
  value = {
    for name, secret in aws_secretsmanager_secret.secret : name => {
      id            = secret.id
      arn           = secret.arn
      name          = secret.name
      version_id    = aws_secretsmanager_secret_version.secret_version[name].version_id
      version_stages = aws_secretsmanager_secret_version.secret_version[name].version_stages
    }
  }
}