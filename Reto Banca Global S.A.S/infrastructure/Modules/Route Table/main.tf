resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_rt
    gateway_id = aws_internet_gateway.igw.id
  }
  tags         = merge({Name = "${join("-",tolist([var.project, var.domain, var.public_rt_name, var.environment ]))}"})
}
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.subnets_public[0].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_rt
    nat_gateway_id = aws_nat_gateway.natgw.id
} 
  tags = merge({Name = "${join("-",tolist([var.project, var.domain, var.priv_rt_name, var.environment ]))}"})
}

resource "aws_route_table_association" "priv_rta" {
  count = var.nro_subredes_priv
  subnet_id      = aws_subnet.subnets_private[count.index].id
  route_table_id = aws_route_table.priv_rt.id
}

resource "aws_route_table" "data_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${join("-",tolist([var.project, var.domain, var.data_rt_name, var.environment ]))}"
  }

  route {
    cidr_block = var.cidr_block_rt
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "data_rta" {
  count          = var.nro_subredes_data
  subnet_id      = aws_subnet.subnets_data[count.index].id
  route_table_id = aws_route_table.data_rt.id
}