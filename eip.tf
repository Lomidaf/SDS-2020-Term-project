resource "aws_eip" "natgw-eip" {
    vpc = true
}

resource "aws_eip" "app-eip" {
    vpc                       = true
    network_interface         = aws_network_interface.app-nic.id
    depends_on                = [aws_internet_gateway.nextcloud-gw]
}
