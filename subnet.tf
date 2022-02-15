resource "aws_subnet" "app-internet-subnet" {
    vpc_id = aws_vpc.nextcloud.id
    availability_zone = var.availability_zone
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "app-internet-subnet"
    }
}

resource "aws_subnet" "database-internet-subnet" {
    vpc_id = aws_vpc.nextcloud.id
    availability_zone = var.availability_zone
    cidr_block = "10.0.2.0/24"

    tags = {
        Name = "database-internet-subnet"
    }
}

resource "aws_subnet" "app-database-subnet" {
    vpc_id = aws_vpc.nextcloud.id
    availability_zone = var.availability_zone
    cidr_block = "10.0.3.0/24"

    tags = {
        Name = "app-database-subnet"
    }
}
