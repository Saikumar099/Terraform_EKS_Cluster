resource "aws_eip" "nat_eip" {
    vpc = true
    tags = {
        Name = "k8s-nat-eip"
    }
} 

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public1.id
    tags = {
        Name = "k8s-nat-gw"
    }

    depends_on = [aws_internet_gateway.igw]
}

