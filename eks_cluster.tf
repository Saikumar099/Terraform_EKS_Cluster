resource "aws_iam_role" "EKS_cluster_first_role" {
    name = "EKS_cluster_first_role"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "EKS_cluster_first-AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.EKS_cluster_first_role.name
}

resource "aws_eks_cluster" "EKS_cluster_first" {
    name     = "EKS_cluster_first"
    role_arn = aws_iam_role.EKS_cluster_first_role.arn
    vpc_config {
        subnet_ids = [
            aws_subnet.public1.id,
            aws_subnet.public2.id,
            aws_subnet.private1.id,
            aws_subnet.private2.id
        ]
        security_group_ids = [
            aws_security_group.EKS_cluster_first_sg.id
        ]
    }
    depends_on = [aws_iam_role_policy_attachment.EKS_cluster_first-AmazonEKSClusterPolicy]
}
