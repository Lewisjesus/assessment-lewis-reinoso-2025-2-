# Agregar esto al inicio del archivo para obtener el ID de la cuenta
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "dynamic_policy" {
  for_each = { for item in var.s3_config : item.name => item }

  # Declaraciones existentes
  dynamic "statement" {
    for_each = each.value["statements"]
    content {
      sid       = statement.value["sid"]
      actions   = statement.value["actions"]
      resources = ["arn:aws:s3:::${join("-", tolist([var.project, var.domain, var.environment, "${each.key}/*"]))}"]
      effect    = statement.value["effect"]
      principals {
        type        = statement.value["type"]
        identifiers = statement.value["identifiers"]
      }

      dynamic "condition" {
        for_each = statement.value["condition"]
        content {
          test     = condition.value["test"]
          variable = condition.value["variable"]
          values   = condition.value["values"]
        }
      }
    }
  }

  # # Declaración S3->SQS
  # dynamic "statement" {
  #   for_each = try(each.value.enable_notifications, false) ? [1] : []
  #   content {
  #     sid       = "AllowS3ToSQSNotification"  # Cambiado el Sid para que sea único
  #     actions   = ["sqs:SendMessage"]
  #     resources = [var.sqs_queue_arn]
  #     effect    = "Allow"
  #     principals {
  #       type        = "Service"
  #       identifiers = ["s3.amazonaws.com"]
  #     }

  #     # Condiciones dinámicas
  #     dynamic "condition" {
  #       for_each = each.value.notification_conditions
  #       content {
  #         test     = condition.value["test"]
  #         variable = condition.value["variable"]
  #         values   = condition.value["values"]
  #       }
  #     }

  #     # Condición fija para el ARN del bucket
  #     condition {
  #       test     = "ArnLike"
  #       variable = "aws:SourceArn"
  #       values   = ["arn:aws:s3:::${aws_s3_bucket.bucket[each.key].id}"]
  #     }
  #   }
  # }
}