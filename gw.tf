resource "aws_internet_gateway" "nextcloud-gw" {
  vpc_id = aws_vpc.nextcloud.id

  tags = {
    Name = "nextcloud-gw"
  }
}
