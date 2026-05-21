# Vereinfachtes Terraform-Beispiel für einen Managed Kubernetes Cluster.
# Diese Datei ist kein vollständiges Production-Setup.
# Das Labor-Repository setzt einen vorhandenen Kubernetes-Cluster voraus.

terraform {
  required_version = ">= 1.6.0" # benötigte Terraform-Version

  required_providers {
    aws = {
      source  = "hashicorp/aws" # AWS Provider verwenden
      version = "~> 5.0"        # Provider-Version festlegen
    }
  }
}

provider "aws" {
  region = "eu-central-1" # AWS-Region Frankfurt
}

resource "aws_eks_cluster" "productline" {
  name     = "productline-cluster" # Name des Kubernetes-Clusters
  role_arn = "arn:aws:iam::123456789012:role/example-eks-cluster-role"

  vpc_config {
    subnet_ids = [
      "subnet-example-private-a", # privates Subnetz A
      "subnet-example-private-b"  # privates Subnetz B
    ]
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.productline.name # Ziel-Cluster
  node_group_name = "productline-workers"            # Name der Worker-Gruppe
  node_role_arn   = "arn:aws:iam::123456789012:role/example-eks-node-role"

  subnet_ids = [
    "subnet-example-private-a", # Subnetz für Worker Nodes
    "subnet-example-private-b"
  ]

  scaling_config {
    desired_size = 3 # gewünschte Anzahl Worker Nodes
    min_size     = 2 # minimale Anzahl
    max_size     = 5 # maximale Anzahl
  }

  instance_types = ["t3.medium"] # Beispiel-Instanztyp
}
