# outputs.tf del módulo Glue Connections - CON SECRETS MANAGER

# Output consolidado con todas las conexiones creadas
output "glue_connections" {
  description = "Map of all Glue connections details"
  value = {
    for key, connection in aws_glue_connection.connections : key => {
      name              = connection.name
      arn               = connection.arn
      connection_type   = connection.connection_type
      description       = connection.description
      catalog_id        = connection.catalog_id
      connection_properties = connection.connection_properties
      physical_connection_requirements = connection.physical_connection_requirements
      uses_secrets_manager = local.glue_connections_config_map[key].secrets_manager_secret_arn != null
    }
  }
}

# Output específico para nombres de conexiones
output "glue_connection_names" {
  description = "Map of Glue connection names by alias"
  value = {
    for config in var.glue_connections_config : config.alias => 
    join("-", [var.project, var.domain, var.environment, "glue", "connection", config.alias])
  }
}

# Output específico para ARNs de conexiones
output "glue_connection_arns" {
  description = "Map of Glue connection ARNs by alias"
  value = {
    for key, connection in aws_glue_connection.connections : key => connection.arn
  }
}

# Output específico por tipo de conexión
output "glue_connections_by_type" {
  description = "Glue connections grouped by connection type"
  value = {
    jdbc        = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "JDBC" }
    kafka       = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "KAFKA" }
    mongodb     = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "MONGODB" }
    network     = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "NETWORK" }
    marketplace = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "MARKETPLACE" }
    custom      = { for key, connection in aws_glue_connection.connections : key => connection if connection.connection_type == "CUSTOM" }
  }
}

# Output para usar las conexiones en otros recursos
output "connection_names_for_jobs" {
  description = "List of connection names that can be used in Glue jobs"
  value = [
    for connection in aws_glue_connection.connections : connection.name
  ]
}

# NUEVO OUTPUT: Conexiones que usan Secrets Manager
output "connections_with_secrets_manager" {
  description = "Map of connections that use Secrets Manager for authentication"
  value = {
    for key, config in local.connections_with_secrets : key => {
      connection_name = aws_glue_connection.connections[key].name
      connection_arn  = aws_glue_connection.connections[key].arn
      secret_arn      = config.secrets_manager_secret_arn
      connection_type = config.connection_type
    }
  }
}

# NUEVO OUTPUT: Conexiones con credenciales directas (para auditoría de seguridad)
output "connections_with_direct_credentials" {
  description = "Map of connections using direct credentials (security audit)"
  sensitive   = true  # Marcar como sensible para evitar mostrar en logs
  value = {
    for key, config in local.connections_with_direct_credentials : key => {
      connection_name = aws_glue_connection.connections[key].name
      connection_type = config.connection_type
      warning         = "This connection uses direct credentials. Consider migrating to Secrets Manager for better security."
    }
  }
}

# NUEVO OUTPUT: Estadísticas de seguridad
output "connections_security_summary" {
  description = "Summary of connection authentication methods"
  value = {
    total_connections           = length(aws_glue_connection.connections)
    connections_with_secrets    = length(local.connections_with_secrets)
    connections_with_direct_creds = length(local.connections_with_direct_credentials)
    security_percentage         = length(local.connections_with_secrets) > 0 ? floor((length(local.connections_with_secrets) / length(aws_glue_connection.connections)) * 100) : 0
  }
}