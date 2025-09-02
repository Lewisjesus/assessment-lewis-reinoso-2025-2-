# # ######################################################################
# # #  WAF - Amazon Web Application Firewall
# # ######################################################################

output "web_acls" {
  description = "Map of WAF Web ACL details"
  value = {
    for name, web_acl in aws_wafv2_web_acl.web_acl : name => {
      id          = web_acl.id
      arn         = web_acl.arn
      name        = web_acl.name
      capacity    = web_acl.capacity
      description = web_acl.description
      scope       = web_acl.scope
    }
  }
}

output "ip_sets" {
  description = "Map of WAF IP Set details"
  value = {
    for name, ip_set in aws_wafv2_ip_set.ip_set : name => {
      id                 = ip_set.id
      arn                = ip_set.arn
      name               = ip_set.name
      description        = ip_set.description
      scope              = ip_set.scope
      ip_address_version = ip_set.ip_address_version
    }
  }
}