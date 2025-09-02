# locals.tf del módulo Glue

locals {
  # Valores por defecto para todos los jobs
  default_config = {
    description         = "AWS Glue Job"
    script_location     = "scripts/"
    temp_location       = "temp/"
    spark_logs_location = "spark-event-logs/"
    glue_version        = "5.0"
    worker_type         = "G.1X"
    number_of_workers   = 10
    job_language        = "python"
    runtime             = "Ray2.4"
    max_capacity        = 0.0625
    python_version      = "3.9"
    log_retention_days  = 14
    additional_default_arguments = {}
    iam_statements      = []
    connections         = []  # Lista vacía por defecto
  }

  # Merge de configuración por defecto con configuración del usuario
  glue_config_merged = [
    for config in var.glue_config : merge(local.default_config, config)
  ]

  # Crear mapas para each con la configuración merged
  glue_config_map = {
    for config in local.glue_config_merged : config.alias => config
  }

  # Mapas específicos por tipo de job
  glueetl_jobs = {
    for alias, config in local.glue_config_map : alias => config
    if config.job_type == "glueetl"
  }

  pythonshell_jobs = {
    for alias, config in local.glue_config_map : alias => config
    if config.job_type == "pythonshell"
  }

  glueray_jobs = {
    for alias, config in local.glue_config_map : alias => config
    if config.job_type == "glueray"
  }

  # NUEVA LÓGICA PARA RESOLVER CONEXIONES
  # Mapear alias de conexiones a nombres reales de conexiones de AWS
  resolved_connections = {
    for alias, config in local.glue_config_map : alias => [
      for connection_alias in config.connections : 
      try(var.available_connections[connection_alias].name, connection_alias)
    ]
  }

  # Crear lista de jobs que tienen conexiones para validación
  jobs_with_connections = {
    for alias, config in local.glue_config_map : alias => config
    if length(config.connections) > 0
  }
}