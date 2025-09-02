# variables.tf del módulo
variable "domain" {
  type        = string
  description = "Domain name for the DynamoDB tables"
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
variable "vpc_id" {
  description = "name to the vpc"
  type        = string  
}

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

variable "s3_config" {
  type = list(object({
    name        = string
    description = string
    versioning = object({
      enabled = bool
    })
    server_side_encryption = object({
      enabled     = bool
      kms_key_arn = string
    })
    lifecycle_rules = list(object({
      id      = string
      enabled = bool
      transition = optional(object({
        days          = number
        storage_class = string
      }))
      noncurrent_version_expiration = optional(object({
        days = number
      }))
    }))
    cors_rules = list(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
    }))
    enable_notifications = optional(bool, false)
      notifications = optional(list(object({
      name          = string
      queue_arn     = string
      events        = list(string)
      filter_prefix = optional(string)
    })), [])
    statements = list(object({
      sid         = string
      actions     = list(string)
      effect      = string
      type        = string
      identifiers = list(string)
      condition = list(object({
        test     = string
        variable = string
        values   = list(string)
      }))
    }))
      notification_conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
  }))
  description = "Configuration for S3 buckets"
}