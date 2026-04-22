resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${var.name}-lt"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-node"
    }
  }
}
resource "aws_eks_node_group" "danit" {
  cluster_name    = aws_eks_cluster.danit.name
  node_group_name = var.name
  node_role_arn   = aws_iam_role.danit-node.arn
  subnet_ids      = module.vpc.public_subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  
  instance_types = ["t3.medium"]

  labels = {
    "node-type" : "tests"
  }

  depends_on = [
    aws_iam_role_policy_attachment.kubeedge-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.kubeedge-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.kubeedge-node-AmazonEC2ContainerRegistryReadOnly,
  ]
  tags = merge(
    var.tags,
    { Name = "${var.name}-node-group" }
  )
  
}


