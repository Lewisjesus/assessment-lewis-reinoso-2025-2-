################################################################################
# Recursos VPC
################################################################################
resource "aws_vpc" "main" {
  cidr_block           = var.cidrblock
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge({ Name = "${join("-", tolist([var.project, var.domain, var.vpc_name, var.environment]))}" })
}

###############################################################################
# Internet Gateway
###############################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    { Name = join("-", [var.project, var.domain, "igw", var.environment]) },
    var.resource_tags
  )
}

###############################################################################
# EIP y NAT Gateway
###############################################################################
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = merge(
    { Name = join("-", [var.project, var.domain, "eip", var.environment]) },
    var.resource_tags
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet["private-1a"].id

  tags = merge(
    { Name = join("-", [var.project, var.domain, "nat", var.environment]) },
    var.resource_tags
  )

  depends_on = [aws_internet_gateway.igw]
}

################################################################################
# Recursos SubNet Privada
################################################################################
resource "aws_subnet" "subnet" {
  for_each = { for item in var.subnet_config : item.name => item }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    { Name = join("-", [var.project, var.domain, "subnet", var.environment, each.value.name]) },
    each.value.tags,
    var.resource_tags
  )
}

resource "aws_route_table" "route_table" {
  for_each = { for item in var.subnet_config : item.name => item }

  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = each.value.route_table_config.routes
    content {
      cidr_block         = route.value.cidr_block
      transit_gateway_id = route.value.transit_gateway_id
    }
  }

  tags = merge(
    { Name = join("-", [var.project, var.domain, "rt", var.environment, each.value.name]) },
    var.resource_tags
  )
}

resource "aws_route_table_association" "route_table_association" {
  for_each = { for item in var.subnet_config : item.name => item }

  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route_table[each.key].id
}


################################################################################
# VPC Endpoint para S3
################################################################################

# Security Group por defecto para VPC Endpoints
# resource "aws_security_group" "vpc_endpoint_default" {
#   name_prefix = "${var.project}-${var.domain}-${var.environment}-vpc-endpoint-default-"
#   description = "Default security group for VPC endpoints"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.main.cidr_block]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(
#     { Name = "${var.project}-${var.domain}-${var.environment}-vpc-endpoint-default" },
#     var.resource_tags
#   )
# }

# resource "aws_vpc_endpoint" "endpoints" {
#   for_each = { for i, endpoint in var.endpoints : "${endpoint.service_name}-${i}" => endpoint }

#   vpc_id            = aws_vpc.main.id
#   service_name      = each.value.service_name
#   vpc_endpoint_type = each.value.vpc_endpoint_type
#   auto_accept       = each.value.auto_accept
#   policy            = each.value.policy

#   # Para endpoints de tipo Interface
#   subnet_ids = each.value.vpc_endpoint_type == "Interface" ? [for name in each.value.subnet_names : aws_subnet.subnet[name].id] : null
#   security_group_ids = each.value.vpc_endpoint_type == "Interface" ? try(each.value.security_group_ids, [aws_security_group.vpc_endpoint_default.id]) : null

#   private_dns_enabled = each.value.vpc_endpoint_type == "Interface" ? true : null

#   tags = merge(
#     { Name = join("-", [var.project, var.domain, replace(each.value.service_name, "com.amazonaws.${var.resource_tags.aws_region}.", ""), var.environment]) },
#     try(each.value.tags, {}),
#     var.resource_tags
#   )
# }

# resource "aws_vpc_endpoint_route_table_association" "endpoint_route_table" {
#   for_each = {
#     for pair in setproduct(keys(aws_vpc_endpoint.endpoints), keys(aws_route_table.route_table)) :
#     "${pair[0]}-${pair[1]}" => {
#       endpoint_id    = aws_vpc_endpoint.endpoints[pair[0]].id
#       route_table_id = aws_route_table.route_table[pair[1]].id
#       endpoint_type  = aws_vpc_endpoint.endpoints[pair[0]].vpc_endpoint_type
#     }
#     if var.endpoint_route_table_association_enabled &&
#     aws_vpc_endpoint.endpoints[pair[0]].vpc_endpoint_type == "Gateway"
#   }

#   vpc_endpoint_id = each.value.endpoint_id
#   route_table_id  = each.value.route_table_id
# }

resource "aws_vpc_endpoint" "endpoints" {
  for_each = { for i, endpoint in var.endpoints : "${endpoint.service_name}-${i}" => endpoint }

  vpc_id            = aws_vpc.main.id
  service_name      = each.value.service_name
  vpc_endpoint_type = each.value.vpc_endpoint_type
  auto_accept       = each.value.auto_accept
  policy            = each.value.policy

  # Para endpoints de tipo Interface
  # subnet_ids        = try(each.value.subnet_ids, null)
  subnet_ids = [for name in each.value.subnet_names:aws_subnet.subnet[name].id]
  security_group_ids = try(each.value.security_group_ids, null)

  private_dns_enabled = each.value.vpc_endpoint_type == "Interface" ? true : null

  tags = merge(
    { Name = join("-", [var.project, var.domain, replace(each.value.service_name, "com.amazonaws.${var.resource_tags.aws_region}.", ""), var.environment]) },
    try(each.value.tags, {}),
    var.resource_tags
  )
}

resource "aws_vpc_endpoint_route_table_association" "endpoint_route_table" {
  for_each = {
    for pair in setproduct(keys(aws_vpc_endpoint.endpoints), keys(aws_route_table.route_table)) :
    "${pair[0]}-${pair[1]}" => {
      endpoint_id    = aws_vpc_endpoint.endpoints[pair[0]].id
      route_table_id = aws_route_table.route_table[pair[1]].id
      endpoint_type  = aws_vpc_endpoint.endpoints[pair[0]].vpc_endpoint_type
    }
    if var.endpoint_route_table_association_enabled &&
    aws_vpc_endpoint.endpoints[pair[0]].vpc_endpoint_type == "Gateway"
  }

  vpc_endpoint_id = each.value.endpoint_id
  route_table_id  = each.value.route_table_id
}