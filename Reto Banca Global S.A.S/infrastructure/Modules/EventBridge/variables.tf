variable "project" {
  type        = string
  description = "Project name"
}

variable "domain" {
  type        = string
  description = "Domain name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

variable "eventbridge_config" {
  description = "Configuration for EventBridge rules and targets"
  type = list(object({
    name                = string
    description         = string
    schedule_expression = string
    # Atributos antiguos ahora son opcionales
    lambda_function_arn     = optional(string)
    lambda_function_name    = optional(string)
    permission_statement_id = optional(string)
    lambda_action           = optional(string)
    lambda_principal        = optional(string)
    # Targets para Lambda
    targets = optional(list(object({
      lambda_function_arn     = string
      lambda_function_name    = string
      permission_statement_id = string
      lambda_action           = string
      lambda_principal        = string
      target_id               = string
    })), [])

    # # Targets para Step Functions
    # stepfunction_targets = optional(list(object({
    #   stepfunction_arn = string
    #   role_arn         = optional(string)
    #   target_id        = string
    # })), [])

    stepfunction_targets = optional(list(object({
      stepfunction_arn = string
      role_arn         = optional(string)
      target_id        = string
      input_transformer = optional(object({
        input_template = string
        input_paths    = optional(map(string), {})
      }))
      input = optional(string)
    })), [])


    # Targets para ECS (ejemplo futuro)
    ecs_targets = optional(list(object({
      cluster_arn         = string
      task_definition_arn = string
      role_arn            = optional(string)
      target_id           = string
      # Configuración adicional para ECS
      launch_type      = optional(string, "FARGATE")
      platform_version = optional(string, "LATEST")
      task_count       = optional(number, 1)
    })), [])

    # Targets para SNS (ejemplo futuro)
    sns_targets = optional(list(object({
      topic_arn = string
      target_id = string
      message   = optional(string)
    })), [])

    # Targets para SQS (ejemplo futuro)
    sqs_targets = optional(list(object({
      queue_arn        = string
      target_id        = string
      message_group_id = optional(string)
    })), [])
  }))
}
