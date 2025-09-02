output "security_groups" {
  description = "Map of security groups details"
  value = {
    for key, sg in aws_security_group.sg : key => {
      id          = sg.id
      arn         = sg.arn
      name        = sg.name
      description = sg.description
      vpc_id      = sg.vpc_id
    }
  }
}