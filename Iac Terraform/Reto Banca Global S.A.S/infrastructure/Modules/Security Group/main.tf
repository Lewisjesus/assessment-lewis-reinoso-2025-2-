resource "aws_security_group" "sg" {
  for_each = { for item in var.sg_config : item.name => item }
  
  name        = join("-", [var.project, var.domain, var.environment, "sg", each.value.name])
  description = each.value.description
  vpc_id      = var.vpc_id
  
  tags = merge(
    { Name = join("-", [var.project, var.domain, var.environment, "sg", each.value.name]) },
    var.resource_tags
  )
}

resource "aws_security_group_rule" "ingress" {
  for_each = {
    for idx, rule in local.flattened_ingress_rules :
    "${rule.sg_name}-ingress-${idx}" => rule
  }
  
  type                     = "ingress"
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.sg[each.value.sg_name].id
  
  # Solo especificar los campos que tienen valores - evitar conflictos
  cidr_blocks              = each.value.self == true ? null : (length(each.value.cidr_blocks) > 0 ? each.value.cidr_blocks : null)
  prefix_list_ids          = each.value.self == true ? null : (length(each.value.prefix_list_ids) > 0 ? each.value.prefix_list_ids : null)
  source_security_group_id = each.value.self == true  ? null : try(aws_security_group.sg["${each.value.source_security_group_id}"].id,null)  ## solo para asociar sg creados por terraform mas no desde consola
  self                     = each.value.self == true ? true : null
  
  depends_on = [aws_security_group.sg]
}

resource "aws_security_group_rule" "egress" {
  for_each = {
    for idx, rule in local.flattened_egress_rules :
    "${rule.sg_name}-egress-${idx}" => rule
  }
  
  type              = "egress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.sg[each.value.sg_name].id
  
  # Usar source_security_group_id solo cuando esté definido
  source_security_group_id = each.value.source_security_group_id != null ? aws_security_group.sg["${each.value.source_security_group_id}"].id : null
  
  # Usar cidr_blocks por defecto cuando no hay source_security_group_id
  cidr_blocks = length(each.value.cidr_blocks) > 0 ? each.value.cidr_blocks : (
    each.value.source_security_group_id == null ? ["0.0.0.0/0"] : null
  )
  
  prefix_list_ids = length(each.value.prefix_list_ids) > 0 ? each.value.prefix_list_ids : null
  
  depends_on = [aws_security_group.sg]
}