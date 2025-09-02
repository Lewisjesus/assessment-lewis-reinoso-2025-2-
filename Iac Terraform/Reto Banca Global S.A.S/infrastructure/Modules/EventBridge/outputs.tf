# outputs.tf - Actualizado
output "eventbridge_rules" {
  description = "Map of EventBridge rules details"
  value = {
    for key, rule in aws_cloudwatch_event_rule.lambda_rules : key => {
      id              = rule.id
      arn             = rule.arn
      name            = rule.name
      description     = rule.description
      schedule        = rule.schedule_expression
      event_pattern   = rule.event_pattern
      is_enabled      = rule.is_enabled
      role_arn        = rule.role_arn
      tags            = rule.tags
      targets         = [
        for target_key, target in aws_cloudwatch_event_target.lambda_targets : {
          arn = target.arn
          id  = target.target_id
        } if split("-", target_key)[0] == key
      ]
    }
  }
}

output "lambda_permissions" {
  description = "Map of Lambda permissions for EventBridge"
  value = {
    for key, permission in aws_lambda_permission.allow_eventbridge : key => {
      id               = permission.id
      statement_id     = permission.statement_id
      action           = permission.action
      function_name    = permission.function_name
      principal        = permission.principal
      source_arn       = permission.source_arn
    }
  }
}