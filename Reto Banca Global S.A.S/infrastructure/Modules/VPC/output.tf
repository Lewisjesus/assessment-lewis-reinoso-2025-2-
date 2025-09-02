output "id" {
  description = "id vpc"
  value = aws_vpc.main.id
}

output "subnets" {
  description = "Map of subnet details"
  value = {
    for key, subnet in aws_subnet.subnet : key => {
      id                = subnet.id
      arn              = subnet.arn
      cidr_block       = subnet.cidr_block
      availability_zone = subnet.availability_zone
      route_table_id   = aws_route_table.route_table[key].id
      tags             = subnet.tags
    }
  }
}

# output "s3_endpoint_prefix_list_id" {
#   description = "Prefix list ID for the S3 VPC endpoint"
#   value = { for k, v in aws_vpc_endpoint.endpoints : 
#             k => v.prefix_list_id if v.vpc_endpoint_type == "Gateway" && 
#             contains(split(".", v.service_name), "s3") }
# }



# # Para Parameter Store
# output "parameter_store_endpoint_prefix_list_id" {
#   description = "Prefix list ID for the Parameter Store (SSM) VPC endpoint"
#   value = { 
#     for k, v in aws_vpc_endpoint.endpoints :
#     k => v.prefix_list_id 
#     if v.vpc_endpoint_type == "Interface" && 
#        v.service_name == "com.amazonaws.us-east-1.ssm"
#   }
# }

# # Para ECR API
# output "ecr_api_endpoint_prefix_list_id" {
#   description = "Prefix list ID for the ECR API VPC endpoint"
#   value = { 
#     for k, v in aws_vpc_endpoint.endpoints :
#     k => v.prefix_list_id 
#     if v.vpc_endpoint_type == "Interface" && 
#        v.service_name == "com.amazonaws.us-east-1.ecr.api"
#   }
# }

# # Para ECR DKR
# output "ecr_dkr_endpoint_prefix_list_id" {
#   description = "Prefix list ID for the ECR DKR VPC endpoint"
#   value = { 
#     for k, v in aws_vpc_endpoint.endpoints :
#     k => v.prefix_list_id 
#     if v.vpc_endpoint_type == "Interface" && 
#        v.service_name == "com.amazonaws.us-east-1.ecr.dkr"
#   }
# }

# Output para S3 (Gateway endpoint)
output "s3_endpoint_prefix_list_id" {
  description = "Prefix list ID for the S3 VPC endpoint"
  value       = local.s3_endpoint_prefix_list_id
}

# Output para Parameter Store (Interface endpoint)
output "parameter_store_endpoint_prefix_list_id" {
  description = "Prefix list ID for the Parameter Store (SSM) VPC endpoint"
  value       = local.parameter_store_endpoint_prefix_list_id
}

# Output para ECR API (Interface endpoint)
output "ecr_api_endpoint_prefix_list_id" {
  description = "Prefix list ID for the ECR API VPC endpoint"
  value       = local.ecr_api_endpoint_prefix_list_id
}

# Output para ECR DKR (Interface endpoint)
output "ecr_dkr_endpoint_prefix_list_id" {
  description = "Prefix list ID for the ECR DKR VPC endpoint"
  value       = local.ecr_dkr_endpoint_prefix_list_id
}

# Debug output para ver todas las claves disponibles
output "debug_all_endpoint_keys" {
  description = "Debug: All available endpoint keys"
  value = {
    s3_keys      = keys(local.s3_endpoint_prefix_list_id)
    ssm_keys     = keys(local.parameter_store_endpoint_prefix_list_id)
    ecr_api_keys = keys(local.ecr_api_endpoint_prefix_list_id)
    ecr_dkr_keys = keys(local.ecr_dkr_endpoint_prefix_list_id)
    all_endpoints = {
      for key, endpoint in aws_vpc_endpoint.endpoints : key => {
        service_name = endpoint.service_name
        type         = endpoint.vpc_endpoint_type
        prefix_list_id = endpoint.prefix_list_id
      }
    }
  }
}