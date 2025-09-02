resource "aws_cloudwatch_event_rule" "lambda_rules" {
  for_each            = { for item in var.eventbridge_config : item.name => item }
  name                = join("-", [var.project, var.domain, each.value.name, var.environment])
  description         = each.value.description
  schedule_expression = each.value.schedule_expression

  tags = merge(
    { Name = join("-", [var.project, var.domain, each.value.name, var.environment]) },
    var.resource_tags
  )
}
# Lambda Targets
resource "aws_cloudwatch_event_target" "lambda_targets" {
  for_each  = { for target in local.lambda_targets : "${target.rule_name}-${target.target_id}" => target }
  rule      = aws_cloudwatch_event_rule.lambda_rules[each.value.rule_name].name
  target_id = each.value.target_id
  arn       = each.value.lambda_function_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  for_each      = { for target in local.lambda_targets : "${target.rule_name}-${target.target_id}" => target }
  statement_id  = "${each.value.permission_statement_id}${each.value.target_id}"
  action        = each.value.lambda_action
  function_name = each.value.lambda_function_name
  principal     = each.value.lambda_principal
  source_arn    = aws_cloudwatch_event_rule.lambda_rules[each.value.rule_name].arn
}

# IAM Role general para EventBridge ejecutar diferentes servicios
resource "aws_iam_role" "eventbridge_execution_role" {
  count = length(local.all_targets_requiring_role) > 0 ? 1 : 0

  name = join("-", [var.project, var.domain, var.environment, "eventbridge", "execution", "role"])

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "eventbridge", "execution", "role"]) },
    var.resource_tags
  )
}

# IAM Policy general para EventBridge
resource "aws_iam_policy" "eventbridge_execution_policy" {
  count = length(local.all_targets_requiring_role) > 0 ? 1 : 0

  name        = join("-", [var.project, var.domain, var.environment, "eventbridge", "execution", "policy"])
  description = "Policy for EventBridge to execute various AWS services"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      # Step Functions permissions
      length(local.stepfunction_targets) > 0 ? [{
        Effect = "Allow"
        Action = [
          "states:StartExecution"
        ]
        Resource = [for target in local.stepfunction_targets : target.stepfunction_arn]
      }] : [],
      # Agregar más servicios aquí en el futuro
      # ECS permissions (ejemplo)
      length(local.ecs_targets) > 0 ? [{
        Effect = "Allow"
        Action = [
          "ecs:RunTask"
        ]
        Resource = [for target in local.ecs_targets : target.task_definition_arn]
      }] : [],
      # SNS permissions (ejemplo)
      length(local.sns_targets) > 0 ? [{
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = [for target in local.sns_targets : target.topic_arn]
      }] : []
    )
  })

  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "eventbridge", "execution", "policy"]) },
    var.resource_tags
  )
}

# Attachment de política a rol EventBridge
resource "aws_iam_role_policy_attachment" "eventbridge_execution_policy_attachment" {
  count = length(local.all_targets_requiring_role) > 0 ? 1 : 0

  role       = aws_iam_role.eventbridge_execution_role[0].name
  policy_arn = aws_iam_policy.eventbridge_execution_policy[0].arn
}

# Step Functions Targets
# resource "aws_cloudwatch_event_target" "stepfunction_targets" {
#   for_each  = { for target in local.stepfunction_targets : "${target.rule_name}-${target.target_id}" => target }
#   rule      = aws_cloudwatch_event_rule.lambda_rules[each.value.rule_name].name
#   target_id = each.value.target_id
#   arn       = each.value.stepfunction_arn
#   role_arn  = each.value.role_arn != null ? each.value.role_arn : aws_iam_role.eventbridge_execution_role[0].arn
# }
resource "aws_cloudwatch_event_target" "stepfunction_targets" {
  for_each  = { for target in local.stepfunction_targets : "${target.rule_name}-${target.target_id}" => target }
  rule      = aws_cloudwatch_event_rule.lambda_rules[each.value.rule_name].name
  target_id = each.value.target_id
  arn       = each.value.stepfunction_arn
  role_arn  = each.value.role_arn != null ? each.value.role_arn : aws_iam_role.eventbridge_execution_role[0].arn

  input = each.value.input

  dynamic "input_transformer" {
    for_each = each.value.input_transformer != null && each.value.input == null ? [each.value.input_transformer] : []
    content {
      input_template = input_transformer.value.input_template
      input_paths    = input_transformer.value.input_paths
    }
  }
}
