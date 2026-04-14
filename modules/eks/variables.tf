# modules/eks/variables.tf

variable "cluster_name" {
  description = "Nome do Cluster K8s"
  type        = string
}

variable "cluster_version" {
  description = "Versão do Kubernetes"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs das Subnets Privadas"
  type        = list(string)
}