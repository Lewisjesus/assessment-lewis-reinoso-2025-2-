locals {
  legacy_targets = [
    for rule in var.eventbridge_config : 
    {
      rule_name              = rule.name
      lambda_function_arn    = rule.lambda_function_arn
      lambda_function_name   = rule.lambda_function_name
      permission_statement_id = rule.permission_statement_id
      lambda_action          = rule.lambda_action
      lambda_principal       = rule.lambda_principal
      target_id              = rule.name
    } if rule.lambda_function_arn != null && rule.lambda_function_name != null
  ]
  
  nested_targets = flatten([
    for rule in var.eventbridge_config : [
      for target in rule.targets : {
        rule_name              = rule.name
        lambda_function_arn    = target.lambda_function_arn
        lambda_function_name   = target.lambda_function_name
        permission_statement_id = target.permission_statement_id
        lambda_action          = target.lambda_action
        lambda_principal       = target.lambda_principal
        target_id              = target.target_id
      }
    ]
  ])
  
  lambda_targets = concat(local.legacy_targets, local.nested_targets)
  
  # stepfunction_targets = flatten([
  #   for rule in var.eventbridge_config : [
  #     for target in coalesce(rule.stepfunction_targets, []) : {
  #       rule_name        = rule.name
  #       stepfunction_arn = target.stepfunction_arn
  #       role_arn         = target.role_arn
  #       target_id        = target.target_id
  #     }
  #   ]
  # ])
  stepfunction_targets = flatten([
  for rule in var.eventbridge_config : [
    for target in coalesce(rule.stepfunction_targets, []) : {
      rule_name         = rule.name
      stepfunction_arn  = target.stepfunction_arn
      role_arn          = target.role_arn
      target_id         = target.target_id
      input_transformer = target.input_transformer
      input             = target.input
    }
  ]
])

  # Targets para ECS (ejemplo futuro)
  ecs_targets = flatten([
    for rule in var.eventbridge_config : [
      for target in coalesce(rule.ecs_targets, []) : {
        rule_name             = rule.name
        cluster_arn           = target.cluster_arn
        task_definition_arn   = target.task_definition_arn
        role_arn             = target.role_arn
        target_id            = target.target_id
      }
    ]
  ])
  
  # Targets para SNS (ejemplo futuro)
  sns_targets = flatten([
    for rule in var.eventbridge_config : [
      for target in coalesce(rule.sns_targets, []) : {
        rule_name  = rule.name
        topic_arn  = target.topic_arn
        target_id  = target.target_id
      }
    ]
  ])
  
  # Todos los targets que requieren rol IAM
  all_targets_requiring_role = concat(
    local.stepfunction_targets,
    local.ecs_targets
    # SNS no requiere rol, solo permisos en el topic
  )
}