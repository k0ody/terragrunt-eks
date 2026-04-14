# modules/vpc/main.tf

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Usamos sempre a versão maior fixada por segurança

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # O K8s precisa de NAT Gateway para os nodes privados baixarem imagens da internet
  enable_nat_gateway   = true
  single_nat_gateway   = true # MODO LAB: Usamos só 1 NAT para não gastar muito dinheiro
  enable_dns_hostnames = true

  # TAGS OBRIGATÓRIAS DO EKS! 
  # Sem isso, o Kubernetes não sabe onde colocar os Load Balancers.
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}