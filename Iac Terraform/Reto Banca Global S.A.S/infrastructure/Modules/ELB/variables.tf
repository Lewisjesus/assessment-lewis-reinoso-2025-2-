# ######################################################################
# #  ELB  - Elastic Load Balancing (VARIABLES ACTUALIZADAS)
# ######################################################################


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

variable "lb_config" {
  type = list(object({
    # CAMPOS SIEMPRE OBLIGATORIOS
    alias = string

    # CAMPOS OPCIONALES CON DEFAULTS EN LOCALS
    description        = optional(string)
    internal           = optional(bool)
    load_balancer_type = optional(string)
    subnets            = optional(list(string))
    # security_groups                  = list(string)
    idle_timeout                     = optional(number)
    drop_invalid_header_fields       = optional(bool)
    enable_deletion_protection       = optional(bool)
    enable_cross_zone_load_balancing = optional(bool)


    # WAF Association (opcional)
    waf_arn = optional(string)

    # Target Groups
    target_groups = list(object({
      target_application  = string
      port                = string
      protocol            = string
      vpc_id              = optional(string)
      target_type         = string
      healthy_threshold   = optional(string)
      interval            = optional(string)
      timeout             = optional(string)
      path                = optional(string)
      unhealthy_threshold = optional(string)
      matcher             = optional(string)
      protocol_version    = optional(string)
      stickiness = optional(object({
        enabled         = bool
        type            = string
        cookie_duration = optional(number)
        cookie_name     = optional(string)
      }))
    }))

    # Listeners
    listeners = list(object({
      protocol                = string
      port                    = string
      certificate_arn         = optional(string)
      default_target_group_id = string
      ssl_policy              = optional(string)

      # Listener Rules
      rules = optional(list(object({
        priority = number
        action = object({
          type = string
          redirect_config = optional(object({
            host        = optional(string)
            path        = optional(string)
            port        = optional(string)
            protocol    = optional(string)
            query       = optional(string)
            status_code = string
          }))
          fixed_response = optional(object({
            content_type = string
            message_body = optional(string)
            status_code  = string
          }))
        })
        conditions = list(object({
          host_headers = optional(list(object({
            headers = list(string)
          })), [])
          path_patterns = optional(list(object({
            patterns = list(string)
          })), [])
          http_headers = optional(list(object({
            name   = string
            values = list(string)
          })), [])
          query_strings = optional(list(object({
            key   = optional(string)
            value = string
          })), [])
          source_ips = optional(list(object({
            values = list(string)
          })), [])
        }))
      })), [])
    }))
  }))

  description = "Configuration for Application Load Balancers"


  validation {
    condition = alltrue([
      for config in var.lb_config :
      config.load_balancer_type == null || contains(["application", "network", "gateway"], config.load_balancer_type)
    ])
    error_message = "load_balancer_type must be one of: application, network, gateway"
  }

  validation {
    condition = alltrue([
      for config in var.lb_config :
      config.idle_timeout == null || (config.idle_timeout >= 1 && config.idle_timeout <= 4000)
    ])
    error_message = "idle_timeout must be between 1 and 4000 seconds"
  }

  validation {
    condition = alltrue([
      for config in var.lb_config :
      alltrue([
        for listener in config.listeners :
        contains(["HTTP", "HTTPS", "TCP", "TLS", "UDP", "TCP_UDP", "GENEVE"], listener.protocol)
      ])
    ])
    error_message = "listener protocol must be one of: HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP, GENEVE"
  }

  validation {
    condition = alltrue([
      for config in var.lb_config :
      alltrue([
        for tg in config.target_groups :
        contains(["HTTP", "HTTPS", "TCP", "TLS", "UDP", "TCP_UDP", "GENEVE"], tg.protocol)
      ])
    ])
    error_message = "target_group protocol must be one of: HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP, GENEVE"
  }

  validation {
    condition = alltrue([
      for config in var.lb_config :
      alltrue([
        for tg in config.target_groups :
        contains(["instance", "ip", "lambda", "lb"], tg.target_type)
      ])
    ])
    error_message = "target_type must be one of: instance, ip, lambda, lb"
  }
}

# NUEVAS VARIABLES PARA MANEJO DINÁMICO
variable "security_groups_map" {
  description = "Mapa de security groups desde módulo externo"
  type        = map(string)
}

# *** NUEVAS VARIABLES PARA SUBNETS Y VPC DINÁMICAS ***
variable "dynamic_subnets" {
  description = "Lista de subnet IDs obtenidas dinámicamente del módulo VPC"
  type        = list(string)
}

variable "dynamic_vpc_id" {
  description = "VPC ID obtenido dinámicamente del módulo VPC"
  type        = string
}

