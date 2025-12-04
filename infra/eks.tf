module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "dwp-claims-eks"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size     = 2
      max_size     = 4
      desired_size = 2

      instance_types = ["t3.medium"]
    }
  }

  # 🔑 Ensure API is reachable from your machine
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  # For learning / testing only. Later you can lock this to your IP.
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # ✅ ADD THIS: Enable cluster access management
  enable_cluster_creator_admin_permissions = true

  # ✅ ADD THIS: Grant your IAM user access
  access_entries = {
    olusola = {
      principal_arn = "arn:aws:iam::139561979448:user/Olusola-project"
      
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = {
    Project = "dwp-claims-platform"
  }
}