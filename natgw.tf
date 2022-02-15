resource "aws_nat_gateway" "database-internet-natgw" {
    allocation_id = aws_eip.natgw-eip.id
    subnet_id     = aws_subnet.app-internet-subnet.id

    tags = {
        Name = "database-internet-natgw"
    }

    # To ensure proper ordering, it is recommended to add an explicit dependency
    # on the Internet Gateway for the VPC.
    depends_on = [aws_internet_gateway.nextcloud-gw]
}