resource "aws_instance" "app-svr" {
  ami           = "ami-0ec37230f5ced8b39"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.rocksea-public-subnet1.id
  vpc_security_group_ids = [
    aws_security_group.rocksea-sg.id,
    aws_security_group.app-svr-sg.id
  ]

  tags = {
    Name = "RockseaAppServerInstance"
  }
}
