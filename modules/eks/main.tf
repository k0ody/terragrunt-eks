# modules/eks/main.tf

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  # O EKS moderno usa Access Entries por padrão (Adeus aws-auth ConfigMap!)
  enable_cluster_creator_admin_permissions = true

  # Configuração de Rede (Injetada dinamicamente pelo Terragrunt)
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

  # O Data Plane (Seus Node Groups)
  eks_managed_node_groups = {
    workers_padrao = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      # Instâncias que vamos usar (Mesma que você usou no lab manual)
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      cluster_addons = {
        coredns    = { most_recent = true }
        kube-proxy = { most_recent = true }
        vpc-cni    = { most_recent = true }
      }

      # Tamanho do disco de cada node (gp3, 50GB)
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            delete_on_termination = true
          }
        }
      }
    }
  }
}