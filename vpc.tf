resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
    enable_dns_support = true

    tags = {
        Name = "k8svpc"
    }
}