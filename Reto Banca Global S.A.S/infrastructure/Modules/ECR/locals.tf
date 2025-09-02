# locals.tf del módulo ECR - CORREGIDO: Para estructura de LISTA

locals {
  # Valores por defecto para todos los repositorios ECR
  default_config = {
    description          = "ECR repository"
    force_delete         = false
    image_tag_mutability = "MUTABLE"
    access_type          = "private"
    encryption_configuration = [
      {
        encryption_type = "AES256"
        kms_key        = null
      }
    ]
    image_scanning_configuration = [
      {
        scan_on_push = true
      }
    ]
    lifecycle_rules = []
  }

  # Merge de configuración por defecto con configuración del usuario
  # CORREGIDO: Procesamos la LISTA y convertimos a mapa
  # ecr_config_merged = [
  #   for config in var.ecr_config : merge(local.default_config, config)
  # ]
   # MODIFICADO: Auto-resolver KMS key
  ecr_config_merged = [
    for config in var.ecr_config : merge(local.default_config, config, {
      # Auto-resolver KMS key si es necesario
      encryption_configuration = [
        for enc in coalesce(config.encryption_configuration, local.default_config.encryption_configuration) : {
          encryption_type = enc.encryption_type
          kms_key = enc.encryption_type == "KMS" ? (
            enc.kms_key != null && enc.kms_key != "" ? 
            enc.kms_key : 
            var.default_kms_key_arn
          ) : null
        }
      ]
    })
  ]

  # Crear mapas para each con la configuración merged
  ecr_config_map = {
    for config in local.ecr_config_merged : config.alias => config
  }

  # Repositorios que tienen políticas de ciclo de vida
  repositories_with_lifecycle = {
    for alias, config in local.ecr_config_map : alias => config
    if length(config.lifecycle_rules) > 0
  }

  # Repositorios por tipo de acceso
  private_repositories = {
    for alias, config in local.ecr_config_map : alias => config
    if config.access_type == "private"
  }

  public_repositories = {
    for alias, config in local.ecr_config_map : alias => config
    if config.access_type == "public"
  }

  # Repositorios con encriptación KMS (verificación segura)
  kms_encrypted_repositories = {
    for alias, config in local.ecr_config_map : alias => config
    if length(config.encryption_configuration) > 0 ? 
       config.encryption_configuration[0].encryption_type == "KMS" : false
  }

  # Repositorios con escaneo habilitado (verificación segura)
  scan_enabled_repositories = {
    for alias, config in local.ecr_config_map : alias => config
    if length(config.image_scanning_configuration) > 0 ? 
       config.image_scanning_configuration[0].scan_on_push == true : false
  }
}