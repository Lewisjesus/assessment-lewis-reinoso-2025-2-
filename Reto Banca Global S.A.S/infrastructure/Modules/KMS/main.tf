# main.tf del módulo
resource "aws_kms_key" "kms_key" {
  for_each               = { for item in var.kms_config : item.alias => item }
  description            = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  enable_key_rotation    = each.value.enable_key_rotation
  multi_region          = each.value.multi_region
  policy                = data.aws_iam_policy_document.combined[each.key].json

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "kms", each.value.alias])) },
    var.resource_tags
  )
}

resource "aws_kms_alias" "kms_alias" {
  for_each      = { for item in var.kms_config : item.alias => item }
  name          = "alias/${join("-", tolist([var.project, var.domain, var.environment, "kms", each.value.alias]))}"
  target_key_id = aws_kms_key.kms_key[each.key].key_id
}


data "aws_iam_policy_document" "root_policy" {
  for_each = { for item in var.kms_config : item.alias => item }

  statement {
    sid       = "AllowRootAccountFullAccess"
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
statement {
  sid       = "Allow Key Administration"
  effect    = "Allow"
  principals {
    type        = "AWS"
    identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  }
  actions = ["kms:PutKeyPolicy"]
  resources = ["*"]
}
}

data "aws_iam_policy_document" "dynamic_policy" {
  for_each = { for item in var.kms_config : item.alias => item }

  dynamic "statement" {
    for_each = each.value.statements
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = ["*"]
      principals {
        type        = statement.value.principal_type
        identifiers = statement.value.principal_identifiers
      }
      dynamic "condition" {
        for_each = statement.value.conditions
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

data "aws_iam_policy_document" "combined" {
  for_each = { for item in var.kms_config : item.alias => item }
  
  override_policy_documents = [
    data.aws_iam_policy_document.root_policy[each.key].json,
    data.aws_iam_policy_document.dynamic_policy[each.key].json
  ]
}