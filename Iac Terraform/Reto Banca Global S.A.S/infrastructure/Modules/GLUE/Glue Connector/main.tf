
# Glue Connection - Universal para todos los tipos
resource "aws_glue_connection" "connections" {
  for_each = local.glue_connections_config_map

  name            = join("-", [var.project, var.domain, var.environment, "glue", "connection", each.value.alias])
  description     = each.value.description
  connection_type = each.value.connection_type

  # Propiedades de conexión dinámicas (solo si no están vacías)
  connection_properties = length(local.build_connection_properties[each.key]) > 0 ? local.build_connection_properties[each.key] : null

  # Configuración de red (CORREGIDO: incluir CUSTOM y otros tipos que requieren VPC)
  dynamic "physical_connection_requirements" {
    # for_each = each.value.physical_connection_requirements != null ? [each.value.physical_connection_requirements] : (
    #   # También crear si se proporcionan subnet_id o security_group_id_list directamente
    #   # CORREGIDO: Incluir CUSTOM, JDBC y otros tipos que requieren configuración de red
    #   (contains(["JDBC", "CUSTOM", "NETWORK"], each.value.connection_type) && 
    #    (each.value.subnet_id != null || (each.value.security_group_id_list != null && length(each.value.security_group_id_list) > 0))) ? [{
    #     availability_zone      = each.value.availability_zone
    #     security_group_id_list = each.value.security_group_id_list
    #     subnet_id             = each.value.subnet_id
    #   }] : []
    # )
    
    for_each = try([each.value.physical_connection_requirements[each.key]],[])

    content {
      availability_zone      = physical_connection_requirements.value.availability_zone
      security_group_id_list = physical_connection_requirements.value.security_group_id_list
      subnet_id              = physical_connection_requirements.value.subnet_id
    }
  }





  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "glue", "connection", each.value.alias]) },
    { Type = each.value.connection_type },
    var.resource_tags
  )
}
