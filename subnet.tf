data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "rocksea-public-subnet1" {
  vpc_id = aws_vpc.rocksea-vpc.id
  cidr_block  = "172.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public-zone-1"
  }
}


