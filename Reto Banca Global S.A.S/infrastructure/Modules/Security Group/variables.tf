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

variable "sg_config" {
  type = list(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      self            = optional(bool, false)
      prefix_list_ids = optional(list(string), [])
      sg_name         = optional(string, null)
    }))
    egress_rules = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      sg_name         = optional(string, null)
      prefix_list_ids = optional(list(string), [])
    }))
  }))
  description = "Configuration for security groups"
}
