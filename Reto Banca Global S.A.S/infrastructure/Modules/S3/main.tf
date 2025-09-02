# Módulo S3 - main.tf
resource "aws_s3_bucket" "bucket" {
  for_each = { for item in var.s3_config : item.name => item }
  
  bucket = join("-", [var.project, var.domain, var.environment, each.value.name])
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, each.value.name]) },
    { Description = each.value.description },
    var.resource_tags
  )
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = { for item in var.s3_config : item.name => item }
  
  bucket = aws_s3_bucket.bucket[each.key].id
  versioning_configuration {
    status = each.value.versioning.enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  for_each = { for item in var.s3_config : item.name => item }
  
  bucket = aws_s3_bucket.bucket[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = each.value.server_side_encryption.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  for_each = { for item in var.s3_config : item.name => item if length(item.lifecycle_rules) > 0 }
  
  bucket = aws_s3_bucket.bucket[each.key].id

  dynamic "rule" {
    for_each = each.value.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "transition" {
        for_each = rule.value.transition != null ? [rule.value.transition] : []
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.noncurrent_version_expiration != null ? [rule.value.noncurrent_version_expiration] : []
        content {
          noncurrent_days = noncurrent_version_expiration.value.days
        }
      }
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "cors" {
  for_each = { for item in var.s3_config : item.name => item if length(item.cors_rules) > 0 }
  
  bucket = aws_s3_bucket.bucket[each.key].id

  dynamic "cors_rule" {
    for_each = each.value.cors_rules
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}

resource "aws_s3_bucket_policy" "policy" {
  for_each = { for item in var.s3_config : item.name => item }
  
  bucket = aws_s3_bucket.bucket[each.key].id
  policy = data.aws_iam_policy_document.dynamic_policy[each.key].json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  for_each = { for item in var.s3_config : item.name => item if try(item.enable_notifications, false) }
  
  bucket = aws_s3_bucket.bucket[each.key].id

  dynamic "queue" {
    for_each = try(each.value.notifications, [])
    content {
      id            = join("-", [var.project, var.domain, var.environment, each.key, queue.value.name])
      queue_arn     = queue.value.queue_arn
      events        = queue.value.events
      filter_prefix = try(queue.value.filter_prefix, null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_s3_bucket_policy.policy,
  ]
}