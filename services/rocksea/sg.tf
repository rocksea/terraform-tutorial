#module "vpc" {
#  source = "./vpc"
#}


resource "aws_security_group" "ssl-sg" {

  vpc_id = module.vpc.vpc_id
  name = "ssl-sg"

  ingress {
    description      = "HTTP from external"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSL-SG"
  }
}

resource "aws_security_group" "http-sg" {

  vpc_id = module.vpc.vpc_id
  name = "http-sg"

  ingress {
    description      = "HTTP from external"
    from_port        = 80
    to_port          = 80
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
    Name = "HTTP-SG"
  }
}

resource "aws_security_group" "https-sg" {

  vpc_id = module.vpc.vpc_id
  name = "https-sg"

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
    Name = "HTTPS-SG"
  }
}
