resource "aws_security_group" "rocksea-sg" {

  vpc_id = aws_vpc.rocksea-vpc.id
  name = "ROCKSEA-SG"

  tags = {
    Name = "ROCKSEA-SG"
    Project = "ROCKSEA"
  }
}

resource "aws_security_group" "app-svr-sg" {

  vpc_id = aws_vpc.rocksea-vpc.id
  name = "APP-SVR-SG"

  ingress {
    description      = "HTTP from external"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from external"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from external"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "APP-SVR-SG"
    Project = "ROCKSEA"
  }
}
