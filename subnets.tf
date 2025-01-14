resource "aws_subnet" "private1" {
    vpc_id                   = aws_vpc.main.id
    cidr_block               = "192.168.0.0/24"
    availability_zone        = "us-west-2a"
    map_public_ip_on_launch  = false
    tags = {
        Name = "k8s-private-2a"  
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/EKS_cluster_first"      = "owned"
    }
}


resource "aws_subnet" "private2" {
    vpc_id                   = aws_vpc.main.id
    cidr_block               = "192.168.1.0/24"
    availability_zone        = "us-west-2b"
    map_public_ip_on_launch  = false
    tags = {
        Name = "k8s-private-2b"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/EKS_cluster_first"      = "owned"
    }
}

resource "aws_subnet" "public1" {
    vpc_id                   = aws_vpc.main.id
    cidr_block               = "192.168.2.0/24"
    availability_zone        = "us-west-2a"
    map_public_ip_on_launch  = true
    tags = {
        Name = "k8s-public-2a"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/cluster/EKS_cluster_first"      = "owned"
    }
}

resource "aws_subnet" "public2" {
    vpc_id                   = aws_vpc.main.id
    cidr_block               = "192.168.3.0/24"
    availability_zone        = "us-west-2b"
    map_public_ip_on_launch  = true
    tags = {
        Name = "k8s-public-2b"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/cluster/EKS_cluster_first"      = "owned"
    }  
}

