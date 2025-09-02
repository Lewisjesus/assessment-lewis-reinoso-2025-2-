# data.tf del módulo Glue

data "aws_caller_identity" "current" {}

# Política base para todos los jobs de Glue
data "aws_iam_policy_document" "base_glue_policy" {
  for_each = { for item in var.glue_config : item.alias => item }

  statement {
    sid    = "S3AccessForGlue"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    sid    = "S3ObjectAccessForGlue"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    sid    = "CloudWatchLogsForGlue"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:*",
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-stream:*"
    ]
  }

  # Permisos CloudWatch para Glue Jobs
  statement {
    sid    = "CloudWatchGlue"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "GlueServiceBasicActions"
    effect = "Allow"
    actions = [
      "glue:GetJob",
      "glue:GetJobRun",
      "glue:GetJobRuns",
      "glue:BatchGetJobs",
      "glue:StartJobRun",
      "glue:StopJobRun",
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:BatchCreatePartition",
      "glue:BatchDeletePartition",
      "glue:BatchUpdatePartition"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "GlueJobBookmarkAccess"
    effect = "Allow"
    actions = [
      "glue:GetJobBookmark",
      "glue:ResetJobBookmark",
      "glue:UpdateJobBookmark"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "GlueConnectionsAccess"
    effect = "Allow"
    actions = [
      "glue:GetConnection",
      "glue:GetConnections",
      "glue:UseConnection"
    ]
    resources = ["*"]
  }


  statement {
    sid    = "VPCNetworkPermissions"
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeDhcpOptions"
    ]
    resources = ["*"]
  }

  statement {

    sid    = "ENIManagementPermissions"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:AttachNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:DescribeNetworkInterfaceAttribute"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "UnconditionalTaggingForGlue"
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["*"]

  }

  # Permisos adicionales de S3
  statement {
    sid    = "S3AdditionalPermissions"
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  # Permisos Kms para buckets S3
  statement {
    sid    = "KmsPermissions"
    effect = "Allow"
    actions = [
      "kms:Get*",
      "kms:GenerateDataKey",
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }




}

# Política personalizada para cada job (si se especifica)
data "aws_iam_policy_document" "custom_policy" {
  for_each = {
    for item in var.glue_config : item.alias => item
    if length(item.iam_statements) > 0
  }

  dynamic "statement" {
    for_each = each.value.iam_statements
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources

      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
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

# Política combinada (base + personalizada)
data "aws_iam_policy_document" "combined_policy" {
  for_each = { for item in var.glue_config : item.alias => item }

  source_policy_documents = [
    data.aws_iam_policy_document.base_glue_policy[each.key].json
  ]

  override_policy_documents = length(each.value.iam_statements) > 0 ? [
    data.aws_iam_policy_document.custom_policy[each.key].json
  ] : []
}
