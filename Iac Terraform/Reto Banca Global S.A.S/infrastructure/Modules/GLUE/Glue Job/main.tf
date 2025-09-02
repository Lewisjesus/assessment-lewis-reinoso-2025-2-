# main.tf del módulo Glue

# IAM Role para cada job
resource "aws_iam_role" "glue_execution_role" {
  for_each = local.glue_config_map
  
  name = join("-", [var.project, var.domain, var.environment, "glue", "role", each.value.alias])
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", "role", each.value.alias]) },
    var.resource_tags
  )
}

# IAM Policy para cada job
resource "aws_iam_policy" "glue_policy" {
  for_each = local.glue_config_map
  
  name        = join("-", [var.project, var.domain, var.environment, "glue", "policy", each.value.alias])
  description = "Policy for Glue job ${each.value.alias}"
  policy      = data.aws_iam_policy_document.combined_policy[each.key].json
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", "policy", each.value.alias]) },
    var.resource_tags
  )
}

# Attachment de política a rol
resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  for_each = local.glue_config_map
  
  role       = aws_iam_role.glue_execution_role[each.key].name
  policy_arn = aws_iam_policy.glue_policy[each.key].arn
}

# CloudWatch Log Group para cada job
resource "aws_cloudwatch_log_group" "glue_logs" {
  for_each = local.glue_config_map
  
  name              = "/aws-glue/jobs/${join("-", [var.project, var.domain, var.environment, "glue", each.value.alias])}"
  retention_in_days = each.value.log_retention_days
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", "logs", each.value.alias]) },
    var.resource_tags
  )
}

# Glue Job - tipo glueetl
resource "aws_glue_job" "glueetl" {
  for_each = local.glueetl_jobs
  
  name              = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias])
  role_arn          = aws_iam_role.glue_execution_role[each.key].arn
  glue_version      = each.value.glue_version
  worker_type       = each.value.worker_type
  number_of_workers = each.value.number_of_workers
  description       = each.value.description
  
  # CONEXIONES: Solo agregar si hay conexiones configuradas
  connections = length(local.resolved_connections[each.key]) > 0 ? local.resolved_connections[each.key] : null

  command {
    name            = each.value.job_type
    script_location = "${each.value.script_location}"
  }

  default_arguments = merge({
    "--TempDir"                          = "s3://${each.value.bucket_id}/${each.value.temp_location}"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = "s3://${each.value.bucket_id}/${each.value.spark_logs_location}"
    "--enable-metrics"                   = "true"
    "--enable-observability-metrics"     = "true"
    "--job-language"                     = each.value.job_language
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_logs[each.key].name
    "--continuous-log-logStreamPrefix"   = "${each.value.alias}"
  }, each.value.additional_default_arguments)
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias]) },
    var.resource_tags
  )
}

# Glue Job - tipo pythonshell
resource "aws_glue_job" "pythonshell" {
  for_each = local.pythonshell_jobs
  
  name         = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias])
  role_arn     = aws_iam_role.glue_execution_role[each.key].arn
  max_capacity = each.value.max_capacity
  description  = each.value.description
  
  # CONEXIONES: Solo agregar si hay conexiones configuradas
  connections = length(local.resolved_connections[each.key]) > 0 ? local.resolved_connections[each.key] : null

  command {
    name            = each.value.job_type
    script_location = "${each.value.script_location}"
    python_version  = each.value.python_version
  }

  default_arguments = merge({
    "--TempDir"                          = "s3://${each.value.bucket_id}/${each.value.temp_location}"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-metrics"                   = "true"
    "--additional-python-modules"        = "pandas,numpy,s3fs"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_logs[each.key].name
    "--continuous-log-logStreamPrefix"   = "${each.value.alias}"
  }, each.value.additional_default_arguments)
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias]) },
    var.resource_tags
  )
}

# Glue Job - tipo glueray
resource "aws_glue_job" "glueray" {
  for_each = local.glueray_jobs
  
  name              = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias])
  role_arn          = aws_iam_role.glue_execution_role[each.key].arn
  glue_version      = each.value.glue_version
  worker_type       = each.value.worker_type
  number_of_workers = each.value.number_of_workers
  description       = each.value.description
  
  # CONEXIONES: Solo agregar si hay conexiones configuradas
  connections = length(local.resolved_connections[each.key]) > 0 ? local.resolved_connections[each.key] : null

  command {
    name            = each.value.job_type
    script_location = "${each.value.script_location}"
    runtime         = each.value.runtime
  }

  default_arguments = merge({
    "--TempDir"                          = "s3://${each.value.bucket_id}/${each.value.temp_location}"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-metrics"                   = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = "s3://${each.value.bucket_id}/${each.value.spark_logs_location}"
    "--enable-observability-metrics"     = "true"
    "--job-language"                     = each.value.job_language
    "--pip-install"                      = "pandas,numpy,s3fs"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_logs[each.key].name
    "--continuous-log-logStreamPrefix"   = "${each.value.alias}"
  }, each.value.additional_default_arguments)
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", each.value.alias]) },
    var.resource_tags
  )
}