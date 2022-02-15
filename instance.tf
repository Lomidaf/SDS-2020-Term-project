resource "aws_instance" "app" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"
  #! Debugging
  key_name = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.app-nic.id
    device_index = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.app2database-nic.id
    device_index = 1
  }

  user_data = "${data.cloudinit_config.app-script.rendered}"

  tags = {
    Name = "app"
  }

}

resource "aws_network_interface" "app-nic" {
  subnet_id = aws_subnet.app-internet-subnet.id
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_network_interface" "app2database-nic" {
  subnet_id = aws_subnet.app-database-subnet.id
  security_groups = [aws_security_group.allow_all.id]
}

resource "aws_instance" "database" {
  ami           = var.ami
  availability_zone = var.availability_zone
  instance_type = "t2.micro"
  #! Debuging
  key_name = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.database-nic.id
    device_index = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.database2app-nic.id
    device_index = 1
  }

  user_data = "${data.cloudinit_config.database-script.rendered}"

  tags = {
    Name = "database"
  }
  
}

resource "aws_network_interface" "database-nic" {
  subnet_id = aws_subnet.database-internet-subnet.id
  security_groups = [aws_security_group.allow_database.id]
}

resource "aws_network_interface" "database2app-nic" {
  subnet_id = aws_subnet.app-database-subnet.id
  security_groups = [aws_security_group.allow_database.id]
}