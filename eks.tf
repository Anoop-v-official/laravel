# Create an EKS cluster

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.20" 
  cluster_endpoint_public_access  = true
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  
  
  eks_managed_node_groups = {
    my_node_group = {
      desired_capacity = 2
      max_capacity     = 5
      min_capacity     = 1
      instance_type    = "t3a.medium"
      enable_cluster_creator_admin_permissions = true
    }
  }
}
resource "aws_cloudwatch_log_group" "custom_log_group" {
    name             = "/my-custom-log-group"
    retention_in_days = 30