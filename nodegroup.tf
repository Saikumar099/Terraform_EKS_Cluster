resource "aws_iam_role" "eks_ng_role" {
    name = "eks_nodegroup_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect    = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                },
                Action    = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.eks_ng_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.eks_ng_role.name
}

resource "aws_iam_role_policy_attachment" "eks_containerregistry_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.eks_ng_role.name
}

resource "aws_eks_node_group" "eks_private_nodegroup" {
    cluster_name    = aws_eks_cluster.EKS_cluster_first.name
    node_group_name = "private-ng"
    node_role_arn   = aws_iam_role.eks_ng_role.arn
    subnet_ids      = [
        aws_subnet.private1.id,
        aws_subnet.private2.id
    ]

    instance_types = ["t2.micro"]
    ami_type       = "AL2_x86_64"
   
    scaling_config {
        desired_size = 1
        max_size     = 3
        min_size     = 1
    }
    depends_on = [
        aws_eks_cluster.EKS_cluster_first,
        aws_iam_role_policy_attachment.eks_nodegroup_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_containerregistry_policy
    ]
}

resource "aws_eks_node_group" "eks_public_nodegroup" {
    cluster_name    = aws_eks_cluster.EKS_cluster_first.name
    node_group_name = "public-ng"
    node_role_arn   = aws_iam_role.eks_ng_role.arn
    subnet_ids      = [
        aws_subnet.public1.id,
        aws_subnet.public2.id
    ]

    instance_types = ["t2.micro"]
    ami_type       = "AL2_x86_64"
   
    scaling_config {
        desired_size = 1
        max_size     = 3
        min_size     = 1
    }
    depends_on = [
        aws_eks_cluster.EKS_cluster_first,
        aws_iam_role_policy_attachment.eks_nodegroup_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_containerregistry_policy
    ]
  
}