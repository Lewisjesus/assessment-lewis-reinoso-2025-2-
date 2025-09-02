# locals {
#   gateway_endpoints = {
#     for key, endpoint in aws_vpc_endpoint.endpoints : key => endpoint
#     if endpoint.vpc_endpoint_type == "Gateway"
#   }
# }

locals {
  gateway_endpoints = {
    for key, endpoint in aws_vpc_endpoint.endpoints : key => endpoint
    if endpoint.vpc_endpoint_type == "Gateway"
  }

  # Agregar locals para Interface endpoints
  interface_endpoints = {
    for key, endpoint in aws_vpc_endpoint.endpoints : key => endpoint
    if endpoint.vpc_endpoint_type == "Interface"
  }

  # Locals específicos para cada tipo de endpoint
  s3_endpoint_prefix_list_id = {
    for key, endpoint in local.gateway_endpoints : key => endpoint.prefix_list_id
    if strcontains(endpoint.service_name, "s3")
  }

  parameter_store_endpoint_prefix_list_id = {
    for key, endpoint in local.interface_endpoints : key => endpoint.prefix_list_id
    if endpoint.service_name == "com.amazonaws.us-east-1.ssm"
  }

  ecr_api_endpoint_prefix_list_id = {
    for key, endpoint in local.interface_endpoints : key => endpoint.prefix_list_id
    if endpoint.service_name == "com.amazonaws.us-east-1.ecr.api"
  }

  ecr_dkr_endpoint_prefix_list_id = {
    for key, endpoint in local.interface_endpoints : key => endpoint.prefix_list_id
    if endpoint.service_name == "com.amazonaws.us-east-1.ecr.dkr"
  }
}