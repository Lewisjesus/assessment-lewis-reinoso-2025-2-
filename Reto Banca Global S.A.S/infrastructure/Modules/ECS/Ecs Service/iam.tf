# iam.tf del módulo ECS Services - Roles de IAM

# Política de confianza para el rol de ejecución de ECS
data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Política de confianza para el rol de la tarea de ECS
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Rol de ejecución de ECS (execution role)
resource "aws_iam_role" "ecs_execution_role" {
  for_each = var.ecs_services
  
  name               = "${var.project}-${var.domain}-${var.environment}-ecs-execution-role-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json
  
  tags = merge(
    {
      Name = "${var.project}-${var.domain}-${var.environment}-ecs-execution-role-${each.key}"
    },
    each.value.additional_tags,
    var.resource_tags
  )
}

# Adjuntar política base de ejecución de ECS
resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  for_each = var.ecs_services
  
  role       = aws_iam_role.ecs_execution_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Política personalizada para logs de CloudWatch (si es necesario)
resource "aws_iam_policy" "ecs_execution_logs_policy" {
  for_each = var.ecs_services
  
  name        = "${var.project}-${var.domain}-${var.environment}-ecs-execution-logs-${each.key}"
  description = "Política para permitir la creación de logs de CloudWatch para ECS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/${var.project}-${var.domain}-${var.environment}-*",
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "*",
          "*"
        ]
      },
    ]
  })
  
  tags = merge(
    {
      Name = "${var.project}-${var.domain}-${var.environment}-ecs-execution-logs-${each.key}"
    },
    each.value.additional_tags,
    var.resource_tags
  )
}

# Adjuntar política de logs al rol de ejecución
resource "aws_iam_role_policy_attachment" "ecs_execution_logs_policy_attachment" {
  for_each = var.ecs_services
  
  role       = aws_iam_role.ecs_execution_role[each.key].name
  policy_arn = aws_iam_policy.ecs_execution_logs_policy[each.key].arn
}

# Política para acceso a Secrets Manager y Parameter Store (si se usan secretos)
resource "aws_iam_policy" "ecs_execution_secrets_policy" {
  for_each = {
    for k, v in var.ecs_services : k => v
    if length(flatten([
      for container_key, container in v.containers : container.secrets
    ])) > 0
  }
  
  name        = "${var.project}-${var.domain}-${var.environment}-ecs-execution-secrets-${each.key}"
  description = "Política para permitir acceso a secretos desde ECS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "*",
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          "arn:aws:kms:*"
        ]
        Condition = {}
      }
    ]
  })
  
  tags = merge(
    {
      Name = "${var.project}-${var.domain}-${var.environment}-ecs-execution-secrets-${each.key}"
    },
    each.value.additional_tags,
    var.resource_tags
  )
}

# Adjuntar política de secretos al rol de ejecución
resource "aws_iam_role_policy_attachment" "ecs_execution_secrets_policy_attachment" {
  for_each = {
    for k, v in var.ecs_services : k => v
    if length(flatten([
      for container_key, container in v.containers : container.secrets
    ])) > 0
  }
  
  role       = aws_iam_role.ecs_execution_role[each.key].name
  policy_arn = aws_iam_policy.ecs_execution_secrets_policy[each.key].arn
}

# Rol de la tarea de ECS (task role)
resource "aws_iam_role" "ecs_task_role" {
  for_each = var.ecs_services
  
  name               = "${var.project}-${var.domain}-${var.environment}-ecs-task-role-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  
  tags = merge(
    {
      Name = "${var.project}-${var.domain}-${var.environment}-ecs-task-role-${each.key}"
    },
    each.value.additional_tags,
    var.resource_tags
  )
}

# Política personalizada para el rol de la tarea (permisos específicos de la aplicación)
resource "aws_iam_policy" "ecs_task_policy" {
  for_each = var.ecs_services
  
  name        = "${var.project}-${var.domain}-${var.environment}-ecs-task-policy-${each.key}"
  description = "Política personalizada para la tarea ECS ${each.key}"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      # Permisos básicos para la tarea
      [
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = [
            "*"
          ]
        },
        {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "*",
          "*"
        ]
      },
      ],
      # Permisos adicionales si se especifican en la configuración
      each.value.task_iam_permissions != null ? each.value.task_iam_permissions : []
    )
  })
  
  tags = merge(
    {
      Name = "${var.project}-${var.domain}-${var.environment}-ecs-task-policy-${each.key}"
    },
    each.value.additional_tags,
    var.resource_tags
  )
}

# Adjuntar política personalizada al rol de la tarea
resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  for_each = var.ecs_services
  
  role       = aws_iam_role.ecs_task_role[each.key].name
  policy_arn = aws_iam_policy.ecs_task_policy[each.key].arn
}

# Adjuntar políticas adicionales AWS managed si se especifican
resource "aws_iam_role_policy_attachment" "ecs_task_additional_policies" {
  for_each = {
    for item in flatten([
      for service_key, service in var.ecs_services : [
        for policy_arn in service.task_managed_policy_arns != null ? service.task_managed_policy_arns : [] : {
          service_key = service_key
          policy_arn  = policy_arn
          unique_key  = "${service_key}-${replace(policy_arn, "/", "-")}"
        }
      ]
    ]) : item.unique_key => item
  }
  
  role       = aws_iam_role.ecs_task_role[each.value.service_key].name
  policy_arn = each.value.policy_arn
}