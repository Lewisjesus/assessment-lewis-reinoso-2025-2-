# # ######################################################################
# # #  WAF - Amazon Web Application Firewall
# # ######################################################################

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
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

# Web ACL Configuration
variable "web_acl_config" {
  description = "Configuration for WAF Web ACLs"
  type = list(object({
    name        = string
    description = string
    scope       = string
    default_action = string
    cloudwatch_metrics_enabled = bool
    metric_name = string
    sampled_requests_enabled = bool
    rules = list(object({
      name = string
      priority = number
      action = string  # para reglas no-managed: "allow", "block", "count"; para managed: "count" o cualquier otro valor para "none"
      statement_type = string
      
      # IP Set reference fields
      ip_set_arn = optional(string)
      fallback_behavior = optional(string)
      header_name = optional(string)
      position = optional(string)
      
      # Geo match fields
      country_codes = optional(list(string))
      
      # Rate-based fields
      rate_limit = optional(number)
      aggregate_key_type = optional(string)
      
      # Managed rule group fields
      managed_rule_name = optional(string)
      vendor_name = optional(string)
      excluded_rules = optional(list(string))  # Lista de nombres de reglas a excluir (se configurarán como "count")
      
      # SQL injection / XSS Match fields
      field_to_match = optional(string)
      text_transformation_priority = optional(number)
      text_transformation_type = optional(string)
      
      # Visibility Config
      cloudwatch_metrics_enabled = bool
      metric_name = string
      sampled_requests_enabled = bool
    }))
    
    ip_sets = optional(list(object({
      name = string
      priority = number
      action = string
      ip_set_key = string
      cloudwatch_metrics_enabled = bool
      metric_name = string
      sampled_requests_enabled = bool
    })))
  }))
}

# IP Set Configuration
variable "ip_set_config" {
  description = "Configuration for WAF IP Sets"
  type = list(object({
    name = string
    description = string
    scope = string
    ip_address_version = string
    addresses = list(string)
  }))
}

# Web ACL Association Configuration
variable "web_acl_association_config" {
  description = "Configuration for WAF Web ACL Associations (optional)"
  type = list(object({
    web_acl_key = string
    resource_arn = string
  }))
  default = []
}

# Logging Configuration
variable "logging_config" {
  description = "Configuration for WAF Logging (optional)"
  type = list(object({
    web_acl_key = string
    log_destination_configs = list(string)
    redacted_fields_single_header = optional(list(string))
  }))
  default = []
}