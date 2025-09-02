# locals.tf del módulo Glue Connections - CON SECRETS MANAGER

locals {
  # Lista completa de propiedades permitidas por AWS
  allowed_connection_properties = [
    "HOST", "PORT", "USERNAME", "PASSWORD", "ENCRYPTED_PASSWORD",
    "JDBC_DRIVER_JAR_URI", "JDBC_DRIVER_CLASS_NAME", "JDBC_ENGINE",
    "JDBC_ENGINE_VERSION", "CONFIG_FILES", "INSTANCE_ID",
    "JDBC_CONNECTION_URL", "JDBC_ENFORCE_SSL", "CUSTOM_JDBC_CERT",
    "SKIP_CUSTOM_JDBC_CERT_VALIDATION", "CUSTOM_JDBC_CERT_STRING",
    "CONNECTION_URL", "KAFKA_BOOTSTRAP_SERVERS", "KAFKA_SSL_ENABLED",
    "KAFKA_CUSTOM_CERT", "KAFKA_SKIP_CUSTOM_CERT_VALIDATION",
    "KAFKA_CLIENT_KEYSTORE", "KAFKA_CLIENT_KEYSTORE_PASSWORD", "KAFKA_CLIENT_KEY_PASSWORD",
    "ENCRYPTED_KAFKA_CLIENT_KEYSTORE_PASSWORD", "ENCRYPTED_KAFKA_CLIENT_KEY_PASSWORD",
    "KAFKA_SASL_MECHANISM", "KAFKA_SASL_PLAIN_USERNAME", "KAFKA_SASL_PLAIN_PASSWORD",
    "ENCRYPTED_KAFKA_SASL_PLAIN_PASSWORD", "KAFKA_SASL_SCRAM_USERNAME",
    "KAFKA_SASL_SCRAM_PASSWORD", "KAFKA_SASL_SCRAM_SECRETS_ARN",
    "ENCRYPTED_KAFKA_SASL_SCRAM_PASSWORD", "KAFKA_SASL_GSSAPI_KEYTAB",
    "KAFKA_SASL_GSSAPI_KRB5_CONF", "KAFKA_SASL_GSSAPI_SERVICE",
    "KAFKA_SASL_GSSAPI_PRINCIPAL", "SECRET_ID", "CONNECTOR_URL",
    "CONNECTOR_TYPE", "CONNECTOR_CLASS_NAME", "ENDPOINT", "ENDPOINT_TYPE",
    "ROLE_ARN", "REGION", "WORKGROUP_NAME", "CLUSTER_IDENTIFIER",
    "DATABASE", "SparkProperties"
  ]

  # Crear un mapa de configuraciones con valores por defecto
  glue_connections_config_map = {
    for config in var.glue_connections_config : config.alias => merge({
      # Valores por defecto
      description                        = "Glue connection for ${config.alias}"
      require_ssl                       = false
      skip_certificate_validation       = false
      custom_jdbc_certificate           = ""
      custom_jdbc_certificate_string    = ""
      username                          = null
      password                          = null
      secrets_manager_secret_arn        = config.secrets_manager_secret_arn
      connection_properties             = {}
      
      # Configuración específica de Kafka
      kafka_bootstrap_servers           = null
      kafka_ssl_enabled                 = false
      kafka_custom_cert                 = null
      kafka_skip_custom_cert_validation = false
      
      # Configuración específica de MongoDB
      mongodb_host                      = null
      mongodb_port                      = "27017"
      mongodb_database                  = null
      
      # JDBC específico
      jdbc_url                          = null
      class_name                        = null
      
      # Network requirements
      physical_connection_requirements  = var.physical_connection_requirements
    }, config)
  }
  
  # Separar conexiones por tipo para facilitar el manejo
  jdbc_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "JDBC"
  }
  
  kafka_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "KAFKA"
  }
  
  mongodb_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "MONGODB"
  }
  
  network_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "NETWORK"
  }
  
  marketplace_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "MARKETPLACE"
  }
  
  custom_connections = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.connection_type == "CUSTOM"
  }

  # NUEVA LÓGICA: Identificar conexiones que usan Secrets Manager
  connections_with_secrets = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.secrets_manager_secret_arn != null
  }

  # NUEVA LÓGICA: Identificar conexiones con credenciales directas (para advertencias)
  connections_with_direct_credentials = {
    for key, config in local.glue_connections_config_map : 
    key => config if config.username != null || config.password != null
  }
  
  # FILTRADO AUTOMÁTICO: Solo propiedades permitidas por AWS - ACTUALIZADO CON SECRETS
  build_connection_properties = {
    for key, config in local.glue_connections_config_map : key => {
      for prop_key, prop_value in merge(
        # Propiedades base del usuario - FILTRADAS automáticamente
        config.connection_properties != null ? {
          for prop_key, prop_value in config.connection_properties : prop_key => prop_value
          # FILTRO: Solo propiedades que están en la lista permitida por AWS
          if contains(local.allowed_connection_properties, prop_key)
        } : {},
        
        # Propiedades JDBC estándar (solo si tienen valor Y no es CUSTOM)
        (config.connection_type == "JDBC") ? {
          for k, v in merge(
            {
              "JDBC_CONNECTION_URL" = config.jdbc_url
              "JDBC_DRIVER_CLASS_NAME" = config.class_name
              "JDBC_ENFORCE_SSL" = config.require_ssl ? "true" : "false"
              "SKIP_CUSTOM_JDBC_CERT_VALIDATION" = config.skip_certificate_validation ? "true" : "false"
            },
            # NUEVA LÓGICA: Usar Secrets Manager o credenciales directas
            config.secrets_manager_secret_arn != null ? {
              "SECRET_ID" = config.secrets_manager_secret_arn
            } : {
              "USERNAME" = config.username
              "PASSWORD" = config.password
            }
          ) : k => v if v != null && v != ""
        } : {},
        
        # Propiedades Kafka estándar (solo si tienen valor)
        config.connection_type == "KAFKA" ? merge(
          {
            for k, v in {
              "KAFKA_BOOTSTRAP_SERVERS" = config.kafka_bootstrap_servers
              "KAFKA_SSL_ENABLED" = config.kafka_ssl_enabled ? "true" : "false"
              "KAFKA_CUSTOM_CERT" = config.kafka_custom_cert
              "KAFKA_SKIP_CUSTOM_CERT_VALIDATION" = config.kafka_skip_custom_cert_validation ? "true" : "false"
            } : k => v if v != null && v != ""
          },
          # NUEVA LÓGICA: Secrets Manager para Kafka
          config.secrets_manager_secret_arn != null ? {
            "KAFKA_SASL_SCRAM_SECRETS_ARN" = config.secrets_manager_secret_arn
          } : {
            for k, v in {
              "USERNAME" = config.username
              "PASSWORD" = config.password
            } : k => v if v != null && v != ""
          }
        ) : {},
        
        # Propiedades MongoDB estándar (solo si tienen valor)
        config.connection_type == "MONGODB" ? merge(
          {
            for k, v in {
              "CONNECTION_URL" = config.mongodb_host != null ? "mongodb://${config.mongodb_host}:${config.mongodb_port}/${config.mongodb_database != null ? config.mongodb_database : ""}" : null
            } : k => v if v != null && v != ""
          },
          # NUEVA LÓGICA: Secrets Manager para MongoDB
          config.secrets_manager_secret_arn != null ? {
            "SECRET_ID" = config.secrets_manager_secret_arn
          } : {
            for k, v in {
              "USERNAME" = config.username
              "PASSWORD" = config.password
            } : k => v if v != null && v != ""
          }
        ) : {}
      ) : prop_key => prop_value 
      # Para CUSTOM, permitir valores vacíos; para otros, filtrar
      if (config.connection_type == "CUSTOM") || (prop_value != null && prop_value != "")
    }
  }
}