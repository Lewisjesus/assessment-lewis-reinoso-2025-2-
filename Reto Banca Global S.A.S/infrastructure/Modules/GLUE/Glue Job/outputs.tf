# outputs.tf del módulo Glue

# Output consolidado con todos los jobs creados
output "glue_jobs" {
  description = "Map of all Glue jobs details"
  value = merge(
    # Jobs de tipo glueetl
    {
      for key, job in aws_glue_job.glueetl : key => {
        type           = "glueetl"
        name           = job.name
        arn            = job.arn
        role_arn       = job.role_arn
        glue_version   = job.glue_version
        worker_type    = job.worker_type
        num_workers    = job.number_of_workers
        connections    = job.connections
        log_group_name = aws_cloudwatch_log_group.glue_logs[key].name
        log_group_arn  = aws_cloudwatch_log_group.glue_logs[key].arn
      }
    },
    # Jobs de tipo pythonshell
    {
      for key, job in aws_glue_job.pythonshell : key => {
        type           = "pythonshell"
        name           = job.name
        arn            = job.arn
        role_arn       = job.role_arn
        max_capacity   = job.max_capacity
        python_version = job.command[0].python_version
        connections    = job.connections
        log_group_name = aws_cloudwatch_log_group.glue_logs[key].name
        log_group_arn  = aws_cloudwatch_log_group.glue_logs[key].arn
      }
    },
    # Jobs de tipo glueray
    {
      for key, job in aws_glue_job.glueray : key => {
        type           = "glueray"
        name           = job.name
        arn            = job.arn
        role_arn       = job.role_arn
        glue_version   = job.glue_version
        worker_type    = job.worker_type
        num_workers    = job.number_of_workers
        runtime        = job.command[0].runtime
        connections    = job.connections
        log_group_name = aws_cloudwatch_log_group.glue_logs[key].name
        log_group_arn  = aws_cloudwatch_log_group.glue_logs[key].arn
      }
    }
  )
}

# Output específico para nombres de jobs
output "glue_job_names" {
  description = "Map of Glue job names by alias"
  value = {
    for config in var.glue_config : config.alias => 
    join("-", [var.project, var.domain, var.environment, "glue", config.alias])
  }
}

# Output específico para ARNs de jobs
output "glue_job_arns" {
  description = "Map of Glue job ARNs by alias"
  value = merge(
    { for key, job in aws_glue_job.glueetl : key => job.arn },
    { for key, job in aws_glue_job.pythonshell : key => job.arn },
    { for key, job in aws_glue_job.glueray : key => job.arn }
  )
}

# Output específico para roles IAM
output "glue_iam_roles" {
  description = "Map of IAM roles for Glue jobs"
  value = {
    for key, role in aws_iam_role.glue_execution_role : key => {
      name = role.name
      arn  = role.arn
    }
  }
}

# Output específico para log groups
output "glue_log_groups" {
  description = "Map of CloudWatch log groups for Glue jobs"
  value = {
    for key, log_group in aws_cloudwatch_log_group.glue_logs : key => {
      name = log_group.name
      arn  = log_group.arn
    }
  }
}

# NUEVO OUTPUT: Jobs con sus conexiones asociadas
output "glue_jobs_connections" {
  description = "Map of Glue jobs with their associated connections"
  value = {
    for alias, config in local.glue_config_map : alias => {
      job_name              = join("-", [var.project, var.domain, var.environment, "glue", alias])
      configured_connections = config.connections
      resolved_connections  = local.resolved_connections[alias]
    }
  }
}