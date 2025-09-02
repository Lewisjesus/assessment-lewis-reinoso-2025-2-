#####################################
####### Dynamodb variables ##########
#####################################
variable "domain" {
  description = "nombre del dominio"
  type        = string
}

variable "environment" {
  type = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
  nullable    = false
}

variable "cost_center" {
  description = "Centro de costos (9904, 6621, 1222...)"
  type        = string
  nullable    = false
}

variable "owner" {
  description = "Nombre de la persona que está encargada del Proyecto"
  type        = string
  nullable    = false
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}

variable "dynamo_config" {
  type = list(object({
    name                       = string
    billing_mode              = string
    read_capacity             = optional(number)
    write_capacity            = optional(number)
    hash_key                  = string
    range_key                 = optional(string)
    deletion_protection_enabled = bool
    point_in_time_recovery    = bool
    attributes = list(object({
      name = string
      type = string
    }))
    global_secondary_indexes = list(object({
      name            = string
      hash_key        = string
      range_key       = optional(string)
      projection_type = string
      read_capacity   = number
      write_capacity  = number
    }))
    server_side_encryption = list(object({
      enabled     = bool
      kms_key_arn = string
    }))
    replicas = list(object({
      kms_key_arn            = string
      point_in_time_recovery = bool
      propagate_tags         = bool
      region_name           = string
    }))
  }))
}