# variables.tf del módulo

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

variable "kms_config" {
  type = list(object({
    alias                    = string
    description             = string
    deletion_window_in_days = number
    enable_key_rotation     = bool
    multi_region           = bool
    statements = list(object({
      sid                   = string
      effect                = string
      actions               = list(string)
      principal_type        = string
      principal_identifiers = list(string)
      conditions = list(object({
        test     = string
        variable = string
        values   = list(string)
      }))
    }))
  }))
  description = "Configuration for KMS keys"
}