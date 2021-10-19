resource "aws_security_group" "https_sg" {
  name = "sg_https_${local.app_name}_${local.env}"
  description = "sg_${local.app_name}_${local.env}"
  vpc_id = local.vpc_id

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_${local.app_name}_${local.env}"
    Environment = local.env
  }
}

resource "aws_security_group" "http_sg" {
  name = "sg_http_${local.app_name}_${local.env}"
  description = "sg_${local.app_name}_${local.env}"
  vpc_id = local.vpc_id

  ingress {
    description = "HTTPS"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_${local.app_name}_${local.env}"
    Environment = local.env
  }
}

resource "aws_security_group" "outbound_to_all" {
  name = "sg_outbound_to_all_${local.app_name}_${local.env}"
  description = "sg_${local.app_name}_${local.env}"
  vpc_id = local.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_${local.app_name}_${local.env}"
    Environment = local.env
  }
}
