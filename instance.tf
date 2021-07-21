resource "aws_instance" "app-svr" {
  ami           = "ami-08508144e576d5b64"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.rocksea-public-subnet1.id

  tags = {
    Name = "RockseaAppServerInstance"
  }
}
