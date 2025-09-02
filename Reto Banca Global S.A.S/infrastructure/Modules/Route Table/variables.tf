variable "domain" {
  type = string
}

variable "functionality" {
  type = string
}

variable "environment" {
  type = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
  nullable    = false
}

variable "cost_center" {
  description = "Centro de costos (9904, 6621, 1222...)"
  type        = string
  nullable    = false
}

variable "owner" {
  description = "Nombre de la persona que está encargada del Proyecto"
  type        = string
  nullable    = false
}

variable "area" {
  description = "talent-solutions, cloudops, etc…"
  type        = string
  nullable    = false
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}

variable "cidr_block_rt"{
  type = string
  description = "nombre del cidr"
  default = "0.0.0.0/0"
}

variable "nro_subredes_priv" {
  description="Nro de subredes privadas a crear"
  type = number
  default = 2
}

variable "public_rt_name"{
  type = string
  description = "nombre de la route table publica"
  default = "rtb-public-01"
}

variable "priv_rt_name"{
  type = string
  description = "nombre de la route table privada"
  default = "rtb-private-01"
}

variable "data_rt_name"{
  type = string
  description = "nombre de la route table data"
  default = "rtb-data-01"
}

variable "nro_subredes_data" {
  description="Nro de subredes privadas a crear"
  type = number
  default = 2 
}