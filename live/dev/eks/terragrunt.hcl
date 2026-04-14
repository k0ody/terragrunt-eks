# live/dev/eks/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/eks"
}

# 1. A DEPENDÊNCIA: O Terragrunt vai ler o state da VPC antes de rodar o EKS
dependency "vpc" {
  config_path = "../vpc"
  
  # Mock: Caso a VPC não exista ainda na hora do "plan", ele não quebra
  mock_outputs = {
    vpc_id          = "vpc-mock123"
    private_subnets = ["subnet-mock1", "subnet-mock2"]
  }
}

# 2. OS INPUTS: Aqui passamos os dados que vieram do módulo da VPC!
inputs = {
  cluster_name    = "cluster-lab-sre-dev"
  cluster_version = "1.31"
  
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
}