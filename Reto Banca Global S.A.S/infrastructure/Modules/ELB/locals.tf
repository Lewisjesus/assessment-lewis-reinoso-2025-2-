# locals.tf del módulo lb

locals {
  # Valores por defecto para todos los load balancers
  default_config = {
    description                      = "Application Load Balancer"
    internal                         = false
    load_balancer_type               = "application"
    idle_timeout                     = 60
    drop_invalid_header_fields       = true
    enable_deletion_protection       = false
    enable_cross_zone_load_balancing = true
    waf_arn                          = ""
  }

  # Defaults para target groups
  default_target_group_config = {
    healthy_threshold   = "3"
    interval            = "30"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "3"
    matcher             = "200"
    protocol_version    = "HTTP1"
    stickiness          = null
  }

  # Defaults para listeners
  default_listener_config = {
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
    rules           = []
  }

  # Merge de configuración por defecto con configuración del usuario
  # Cambiar esta parte en locals.tf:
  lb_config_merged = [
    for config in var.lb_config : merge(local.default_config, config, {
      # *** USAR SUBNETS DINÁMICAS ***
      subnets = var.dynamic_subnets
      # Mapeo dinámico de security groups
      security_groups = [var.security_groups_map["${config.alias}"]]
      target_groups = [
        for tg in config.target_groups : merge(local.default_target_group_config, tg, {
          # *** USAR VPC_ID DINÁMICO ***
          vpc_id = var.dynamic_vpc_id
        })
      ]
      listeners = [
        for listener in config.listeners : merge(local.default_listener_config, listener)
      ]
    })
  ]

  # Crear mapas para each con la configuración merged
  lb_config_map = {
    for config in local.lb_config_merged : config.alias => config
  }

  # Flatten target groups para crear recursos individuales
  target_groups_flattened = flatten([
    for lb_alias, lb_config in local.lb_config_map : [
      for tg in lb_config.target_groups : merge(tg, {
        lb_alias = lb_alias
        key       = "${lb_alias}-${tg.target_application}"
      })
    ]
  ])

  # Map de target groups
  target_groups_map = {
    for tg in local.target_groups_flattened : tg.key => tg
  }

  # Flatten listeners para crear recursos individuales
  listeners_flattened = flatten([
    for lb_alias, lb_config in local.lb_config_map : [
      for listener in lb_config.listeners : merge(listener, {
        lb_alias = lb_alias
        key       = "${lb_alias}-${listener.port}"
      })
    ]
  ])

  # Map de listeners
  listeners_map = {
    for listener in local.listeners_flattened : listener.key => listener
  }

  # Flatten listener rules para crear recursos individuales
  listener_rules_flattened = flatten([
    for listener_key, listener in local.listeners_map : [
      for rule in listener.rules : merge(rule, {
        listener_key = listener_key
        lb_alias    = listener.lb_alias
        key          = "${listener_key}-${rule.priority}"
      })
    ]
  ])

  # Map de listener rules
  listener_rules_map = {
    for rule in local.listener_rules_flattened : rule.key => rule
  }

  # lbs por tipo
  application_load_balancers = {
    for alias, config in local.lb_config_map : alias => config
    if config.load_balancer_type == "application"
  }

  network_load_balancers = {
    for alias, config in local.lb_config_map : alias => config
    if config.load_balancer_type == "network"
  }

  # lbs con WAF
  lbs_with_waf = {
    for alias, config in local.lb_config_map : alias => config
    if config.waf_arn != null && config.waf_arn != ""
  }

  # lbs internos vs externos
  internal_lbs = {
    for alias, config in local.lb_config_map : alias => config
    if config.internal == true
  }

  external_lbs = {
    for alias, config in local.lb_config_map : alias => config
    if config.internal == false
  }
}

 
