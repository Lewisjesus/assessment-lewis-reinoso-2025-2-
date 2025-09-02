# main.tf del módulo ECR

# ECR Repository
resource "aws_ecr_repository" "ecr_repository" {
  for_each = local.ecr_config_map
  
  name                 = join("-", [var.project, var.domain, var.environment, "ecr", each.value.alias])
  force_delete         = each.value.force_delete
  image_tag_mutability = each.value.image_tag_mutability

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }

  dynamic "image_scanning_configuration" {
    for_each = each.value.image_scanning_configuration
    content {
      scan_on_push = image_scanning_configuration.value.scan_on_push
    }
  }

  tags = merge(
    {
      Name        = join("-", [var.project, var.domain, var.environment, "ecr", each.value.alias])
      access_type = each.value.access_type
      alias       = each.value.alias
    },
    var.resource_tags
  )
}

# ECR Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  for_each = local.repositories_with_lifecycle
  
  repository = aws_ecr_repository.ecr_repository[each.key].name
  
  policy = jsonencode({
    rules = [
      for rule in each.value.lifecycle_rules : {
        rulePriority = rule.rulePriority
        description  = rule.description
        selection = merge(
          {
            tagStatus   = rule.selection.tagStatus
            countType   = rule.selection.countType
            countNumber = rule.selection.countNumber
          },
          # Solo agregar countUnit si está definido y countType es sinceImagePushed
          rule.selection.countUnit != null && rule.selection.countType == "sinceImagePushed" ? {
            countUnit = rule.selection.countUnit
          } : {},
          # Solo agregar tagPrefixList si está definido y tagStatus es tagged
          rule.selection.tagPrefixList != null && rule.selection.tagStatus == "tagged" ? {
            tagPrefixList = rule.selection.tagPrefixList
          } : {},
          # Si tagStatus es "tagged" pero no hay tagPrefixList, usar una lista por defecto
          rule.selection.tagStatus == "tagged" && rule.selection.tagPrefixList == null ? {
            tagPrefixList = [""]  # Lista vacía permite cualquier tag
          } : {}
        )
        action = {
          type = rule.action.type
        }
      }
    ]
  })
}
