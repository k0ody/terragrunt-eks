# live/dev/vpc/terragrunt.hcl

# 1. Herança: Puxa o cofre do S3 e o Provider da raiz (aquele arquivo mestre)
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# 2. Fonte: Diz de onde puxar o código base (nossa receita)
terraform {
  source = "../../../modules/vpc"
}

# 3. Inputs: As variáveis específicas apenas para o ambiente de DEV
inputs = {
  vpc_name = "vpc-lab-sre-dev"
  vpc_cidr = "10.0.0.0/16"

  # Vamos usar 2 Zonas de Disponibilidade (Alta disponibilidade básica para o EKS)
  azs             = ["us-east-1a", "us-east-1b"]
  
  # Redes Privadas (Onde os nodes do EKS vão ficar escondidos da internet)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  
  # Redes Públicas (Onde os Load Balancers e o NAT Gateway vão ficar)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}