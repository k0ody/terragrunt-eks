# modules/vpc/outputs.tf

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs das subnets privadas (onde os nodes vao rodar)"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs das subnets publicas"
  value       = module.vpc.public_subnets
}