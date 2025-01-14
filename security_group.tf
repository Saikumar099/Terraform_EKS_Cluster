resource "aws_security_group" "EKS_cluster_first_sg" {
    name        = "EKS_cluster_first_sg"
    description = "Allow all traffic"
    vpc_id      = aws_vpc.main.id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "k8s-sg"
    }      
}