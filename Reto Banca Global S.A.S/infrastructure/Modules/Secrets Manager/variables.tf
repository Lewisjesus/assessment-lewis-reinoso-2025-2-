
# variables.tf
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

variable "secrets_config" {
  type = list(object({
    name                            = string
    description                     = string
    kms_key_id                      = string
    recovery_window_in_days         = number
    force_overwrite_replica_secret  = bool
    secret_string                   = string
    version_stages                  = list(string)
    policy                          = string
    replicas = optional(list(object({
      region     = string
      kms_key_id = string
    })))
  }))
  description = "Configuration for Secrets Manager secrets"
}