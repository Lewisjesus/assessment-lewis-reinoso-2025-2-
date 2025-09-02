# locals {
#   flattened_ingress_rules = flatten([
#     for sg_item in var.sg_config : [
#       for rule in sg_item.ingress_rules : {
#         sg_name                 = sg_item.name
#         description             = rule.description
#         from_port               = rule.from_port
#         to_port                 = rule.to_port
#         protocol                = rule.protocol
#         cidr_blocks             = try(rule.cidr_blocks, [])
#         self                    = try(rule.self, false)
#         prefix_list_ids         = try(rule.prefix_list_ids, [])
#         source_security_group_id = try(rule.source_security_group_id, null)
#       }
#     ]
#   ])
  
#   flattened_egress_rules = flatten([
#     for sg in var.sg_config : [
#       for rule in sg.egress_rules : {
#         sg_name     = sg.name
#         description = rule.description
#         from_port   = rule.from_port
#         to_port     = rule.to_port
#         protocol    = rule.protocol
#         cidr_blocks = rule.cidr_blocks
#         prefix_list_ids = try(rule.prefix_list_ids, [])
#       }
#     ]
#   ])
# }

# En ./Modules/Security Group/locals.tf
locals {
  flattened_ingress_rules = flatten([
    for sg_item in var.sg_config : [
      for rule in sg_item.ingress_rules : {
        sg_name                  = sg_item.name
        description              = rule.description
        from_port                = rule.from_port
        to_port                  = rule.to_port
        protocol                 = rule.protocol
        cidr_blocks              = try(rule.cidr_blocks, [])
        self                     = try(rule.self, false)
        prefix_list_ids          = compact(rule.prefix_list_ids)  # ✅ Filtrar nulls aquí
        source_security_group_id = try(rule.sg_name, null)
      }
    ]
  ])

  flattened_egress_rules = flatten([
    for sg in var.sg_config : [
      for rule in sg.egress_rules : {
        sg_name         = sg.name
        description     = rule.description
        from_port       = rule.from_port
        to_port         = rule.to_port
        protocol        = rule.protocol
        cidr_blocks     = try(rule.cidr_blocks, [])
        prefix_list_ids = compact(rule.prefix_list_ids)  # ✅ Filtrar nulls aquí
        source_security_group_id = try(rule.sg_name, null)
      }
    ]
  ])
}