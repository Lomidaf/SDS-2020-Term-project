resource "aws_route_table" "app-internet-rt" {
    vpc_id = aws_vpc.nextcloud.id

    route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.nextcloud-gw.id
    }

    tags = {
        Name = "app-internet-rt"
    }
}

resource "aws_route_table_association" "app-internet-a" {
    subnet_id = aws_subnet.app-internet-subnet.id
    route_table_id = aws_route_table.app-internet-rt.id
}

resource "aws_route_table" "database-internet-rt" {
    vpc_id = aws_vpc.nextcloud.id

    route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.database-internet-natgw.id
    }

    tags = {
        Name = "app-internet-rt"
    }
}

resource "aws_route_table_association" "database-internet-a" {
    subnet_id = aws_subnet.database-internet-subnet.id
    route_table_id = aws_route_table.database-internet-rt.id
}

resource "aws_route_table" "app-database-rt" {
    vpc_id = aws_vpc.nextcloud.id

    route = []

    tags = {
        Name = "app-database-rt"
    }
}

resource "aws_route_table_association" "app-database-a" {
    subnet_id = aws_subnet.app-database-subnet.id
    route_table_id = aws_route_table.app-database-rt.id
}