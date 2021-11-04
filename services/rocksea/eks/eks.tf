module "rocksea" {
  source       = "../"
}


data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "larambla-cluster"
  vpc_id          = module.rocksea.vpc_id
  subnets         = module.rocksea.private_subnets

  worker_groups = [
    {
      instance_type = "t3a.large"
      asg_desired_capacity = 3
      asg_min_size         = 3
      asg_max_size         = 5
    }
  ]
}
