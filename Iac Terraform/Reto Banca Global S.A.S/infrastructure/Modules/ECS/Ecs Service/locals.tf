locals {
  # Generar nombres de recursos siguiendo la convención de nomenclatura estándar
  service_names = {
    for k, v in var.ecs_services : k => "${var.project}-${var.domain}-${var.environment}-ecs-service-${k}"
  }

  task_definition_names = {
    for k, v in var.ecs_services : k => "${var.project}-${var.domain}-${var.environment}-task-${k}"
  }

  log_group_names = {
    for k, v in var.ecs_services : k => "/aws/ecs/${var.project}-${var.domain}-${var.environment}-${k}"
  }

  # SOLUCIÓN 2: Procesar servicios individualmente (evita recreación masiva)
  processed_ecs_services = {
    for service_key, service in var.ecs_services : service_key => merge(service, {
      # Solo sobrescribir los campos dinámicos, mantener el resto igual
      subnets = length(service.subnets) > 0 ? service.subnets : var.dynamic_subnets
      
      security_groups = service.security_group_key != null ? [
        var.security_groups_map[service.security_group_key]
      ] : service.security_groups

      # Mapeo automático de Target Group
      load_balancer = service.target_group_key != null ? {
        target_group_arn = var.target_groups_map[service.target_group_key]
        container_name   = service.load_balancer != null ? service.load_balancer.container_name : keys(service.containers)[0]
        container_port   = service.load_balancer != null ? service.load_balancer.container_port : service.containers[keys(service.containers)[0]].port_mappings[0].container_port
      } : service.load_balancer

      # Procesar contenedores individualmente
      containers = {
        for container_key, container in service.containers : container_key => merge(container, {
          # Solo sobrescribir imagen y secrets dinámicamente
          image = service.image_key != null ? var.images_map[service.image_key] : (
            container.image != null ? container.image : service.image
          )
          
          secrets = service.parameter_key != null ? [
            for param_key, param_data in var.parameters_map : {
              name      = param_data.name
              value_from = param_data.arn
            }
            if startswith(param_key, service.parameter_key)
          ] : container.secrets
        })
      }
    })
  }

  # Validar dependencias entre contenedores
  container_dependencies_validation = {
    for service_key, service in local.processed_ecs_services : service_key => {
      for container_key, container in service.containers : container_key => {
        valid_dependencies = [
          for dep in container.depends_on : 
          contains(keys(service.containers), dep.container_name)
        ]
      }
    }
  }
}