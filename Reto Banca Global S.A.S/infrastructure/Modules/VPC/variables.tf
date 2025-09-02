################################################################################
# Variable VPC
################################################################################
variable "resource_tags" {
  type        = map(string)
  description = "Additional resource tags"
}


variable "cidrblock" {
}

variable "environment" {
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "vpc_name" {
  type        = string
  description = "nombre de la vpc"
}

variable "subnet_name" {
  type        = string
  description = "nombre de la subnet"
}

variable "domain" {
}

variable "project" {
}

variable "instance_tenancy" {
}

variable "tags" {
  description = "Tags commons"
  type        = map(string)
}

variable "id_tgw_db" {
  description = "External Database ID"
  type        = string
}

# variables.tf en el módulo VPC
variable "endpoints" {
  description = "Configuración de los VPC endpoints"
  type = list(object({
    service_name      = string
    vpc_endpoint_type = string
    auto_accept       = bool
    subnet_names      = optional(list(string), [])
    security_group_ids = optional(list(string), [])
    policy            = string
    tags              = map(string)
  }))
  default = []
}

variable "endpoint_route_table_association_enabled" {
  description = "Habilitar/Deshabilitar la asociación de endpoints con route tables"
  type        = bool
}


################################################################################
# Variable Subnet
################################################################################

# variables.tf del módulo
variable "subnet_config" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
    private           = bool
    route_table_config = object({
      routes = list(object({
        cidr_block         = string
        transit_gateway_id = string
      }))
    })
    tags = map(string)
  }))
  description = "Configuration for subnets"
}
