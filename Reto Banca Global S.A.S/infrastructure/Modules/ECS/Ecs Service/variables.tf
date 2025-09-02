
# variables.tf del módulo ECS Services - Actualizado con parámetros dinámicos

variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}

variable "project" {
  type        = string
  description = "Project name"

  validation {
    condition     = length(var.project) > 0
    error_message = "El valor de project no puede estar vacío."
  }
}

variable "domain" {
  type        = string
  description = "Domain declaration"

  validation {
    condition     = length(var.domain) > 0
    error_message = "El valor de domain no puede estar vacío."
  }
}

variable "environment" {
  type        = string
  description = "Environment name"

}

# NUEVAS VARIABLES PARA MANEJO DINÁMICO
variable "security_groups_map" {
  description = "Mapa de security groups desde módulo externo"
  type        = map(string)
  default     = {}
}

variable "images_map" {
  description = "Mapa de imágenes de contenedor desde módulo ECR"
  type        = map(string)
  default     = {}
}

variable "parameters_map" {
  description = "Mapa de parámetros de Parameter Store"
  type = map(object({
    name = string
    arn  = string
  }))
}

# *** NUEVA VARIABLE PARA SUBNETS DINÁMICAS ***
variable "dynamic_subnets" {
  description = "Lista de subnet IDs obtenidas dinámicamente del módulo VPC"
  type        = list(string)
}

# *** NUEVA VARIABLE PARA TARGET GROUPS DINÁMICOS ***
variable "target_groups_map" {
  description = "Mapa de Target Group ARNs desde módulo ELB"
  type        = map(string)
  default     = {}
}

variable "ecs_services" {
  description = "Configuración de servicios ECS"
  type = map(object({
    # Configuración del servicio
    cluster_name               = string
    desired_count              = number
    deployment_maximum_percent = optional(number, 200)
    deployment_minimum_percent = optional(number, 100)
    enable_execute_command     = optional(bool, false)
    force_new_deployment       = optional(bool, false)
    health_check_grace_period  = optional(number, 0)
    launch_type                = optional(string, "FARGATE")
    platform_version           = optional(string, "LATEST")
    scheduling_strategy        = optional(string, "REPLICA")
    image                      = optional(string)
    pid_mode                   = optional(string, null)

    # CONFIGURACIÓN DINÁMICA DE SECURITY GROUPS, IMAGEN, PARÁMETROS Y TARGET GROUPS
    security_group_key = optional(string) # Key para buscar en security_groups_map
    image_key          = optional(string) # Key para buscar en images_map
    parameter_key      = optional(string) # Key para buscar en parameters_map
    target_group_key   = optional(string) # Key para buscar en target_groups_map

    # Configuración de Capacity Providers
    use_capacity_providers = optional(bool, false)
    capacity_provider_strategy = optional(list(object({
      capacity_provider = string
      base              = optional(number, 0)
      weight            = optional(number, 1)
    })), [])

    # Configuración de red
    assign_public_ip = optional(bool, false)
    subnets          = optional(list(string), [])
    security_groups  = optional(list(string), []) # Se puede sobrescribir dinámicamente

    # Configuración de definición de tarea
    task_cpu                 = number
    task_memory              = number
    requires_compatibilities = optional(list(string), ["FARGATE"])

    # Configuración de roles de IAM (opcionales - se crean automáticamente si no se especifican)
    execution_role_arn = optional(string, null)
    task_role_arn      = optional(string, null)

    # Configuración adicional de permisos para el rol de la tarea
    task_iam_permissions = optional(list(object({
      Effect    = string
      Action    = list(string)
      Resource  = list(string)
      Condition = optional(map(any), {})
    })), null)

    # Políticas AWS managed adicionales para adjuntar al rol de la tarea
    task_managed_policy_arns = optional(list(string), [])

    # Configuración de contenedores
    containers = map(object({
      image                    = optional(string) # Se puede sobrescribir dinámicamente
      cpu                      = optional(number, null)
      memory                   = optional(number, null)
      memory_reservation       = optional(number, null)
      essential                = optional(bool, true)
      readonly_root_filesystem = optional(bool, false)

      # Configuración adicional
      entry_point = optional(list(string), null)
      command     = optional(list(string), null)
      user        = optional(string, null)

      # Etiquetas Docker
      docker_labels = optional(map(string), {})

      # Configuración de Linux Parameters
      linux_parameters = optional(object({
        capabilities = optional(object({
          add  = optional(list(string), [])
          drop = optional(list(string), [])
        }), null)
        init_process_enabled = optional(bool, false)
      }), null)

      # Configuración de puertos
      port_mappings = optional(list(object({
        name           = optional(string, null)
        container_port = number
        host_port      = optional(number, null)
        protocol       = optional(string, "tcp")
      })), [])

      # Configuración de entorno
      environment = optional(list(object({
        name  = string
        value = string
      })), [])

      # Configuración de secretos
      secrets = optional(list(object({
        name       = string
        value_from = string
      })), [])

      # Configuración de logs
      enable_cloudwatch_logs = optional(bool, true)
      log_configuration = optional(object({
        log_driver = optional(string, "awslogs")
        options    = optional(map(string), {})
        secret_options = optional(list(object({
          name       = string
          value_from = string
        })), [])
      }), null)

      # Configuración de FireLens
      firelens_configuration = optional(object({
        type    = string
        options = optional(map(string), {})
      }), null)

      # Configuración de healthcheck
      healthcheck = optional(object({
        command      = list(string)
        interval     = optional(number, 30)
        timeout      = optional(number, 5)
        retries      = optional(number, 3)
        start_period = optional(number, 0)
      }), null)

      # Configuración de montaje de volúmenes
      mount_points = optional(list(object({
        container_path = string
        source_volume  = string
        read_only      = optional(bool, false)
      })), [])

      # Configuración de dependencias
      depends_on = optional(list(object({
        container_name = string
        condition      = string
      })), [])
    }))

    # Configuración de volúmenes
    volumes = optional(list(object({
      name = string

      # Configuración de EFS
      efs_volume_configuration = optional(object({
        file_system_id          = string
        root_directory          = optional(string, "/")
        transit_encryption      = optional(string, "ENABLED")
        transit_encryption_port = optional(number, null)
        authorization_config = optional(object({
          access_point_id = string
          iam             = optional(string, "ENABLED")
        }), null)
      }), null)

      # Configuración de host
      host_path = optional(string, null)

      # Configuración de Docker
      docker_volume_configuration = optional(object({
        scope         = optional(string, "shared")
        autoprovision = optional(bool, true)
        driver        = optional(string, "local")
        driver_opts   = optional(map(string), {})
        labels        = optional(map(string), {})
      }), null)
    })), [])

    # Configuración de balanceador de carga
    load_balancer = optional(object({
      target_group_arn = optional(string, null)  # Ahora opcional - se asigna automáticamente
      container_name   = string
      container_port   = number
    }), null)

    # Configuración de Service Connect
    service_connect_config = optional(object({
      enabled   = optional(bool, false)
      namespace = optional(string, null)
      service = optional(object({
        port_name      = string
        discovery_name = optional(string, null)
        client_alias = optional(list(object({
          port     = number
          dns_name = string
        })), [])
      }), null)
      log_configuration = optional(object({
        log_driver = optional(string, "awslogs")
        options    = optional(map(string), {})
      }), null)
    }), null)

    # Configuración de Auto Scaling
    enable_autoscaling = optional(bool, false)
    autoscaling_config = optional(object({
      min_capacity = optional(number, 1)
      max_capacity = optional(number, 10)

      # Políticas de escalado
      scaling_policies = optional(list(object({
        name        = string
        policy_type = optional(string, "TargetTrackingScaling")

        # Configuración de Target Tracking
        target_tracking_configuration = optional(object({
          target_value           = number
          scale_in_cooldown      = optional(number, 300)
          scale_out_cooldown     = optional(number, 300)
          predefined_metric_type = string
          disable_scale_in       = optional(bool, false)
        }), null)

        # Configuración de Step Scaling
        step_scaling_configuration = optional(object({
          adjustment_type         = optional(string, "ChangeInCapacity")
          cooldown                = optional(number, 300)
          metric_aggregation_type = optional(string, "Average")

          step_adjustments = list(object({
            scaling_adjustment          = number
            metric_interval_lower_bound = optional(number, null)
            metric_interval_upper_bound = optional(number, null)
          }))
        }), null)
      })), [])

      # Configuración de alarmas de CloudWatch
      alarms = optional(list(object({
        name                = string
        comparison_operator = string
        evaluation_periods  = number
        metric_name         = string
        namespace           = string
        period              = number
        statistic           = string
        threshold           = number
        alarm_description   = optional(string, "")
        datapoints_to_alarm = optional(number, null)
        treat_missing_data  = optional(string, "missing")
        dimensions          = optional(map(string), {})
      })), [])
    }), null)

    # Configuración de logs
    log_retention_days     = optional(number, 30)
    log_encryption_key_arn = optional(string, null)

    # Etiquetas adicionales específicas para este servicio
    additional_tags = optional(map(string), {})
  }))
}
