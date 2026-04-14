# modules/vpc/variables.tf

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
}

variable "azs" {
  description = "Zonas de Disponibilidade"
  type        = list(string)
}

variable "private_subnets" {
  description = "Blocos CIDR das subnets privadas"
  type        = list(string)
}

variable "public_subnets" {
  description = "Blocos CIDR das subnets publicas"
  type        = list(string)
}