variable "key_pair" {
  default = "rocksea-bastion"
}

resource "aws_instance" "rocksea-bastion" {
    ami = "ami-04876f29fd3a5e8ba"
    instance_type = "t2.micro"
    subnet_id = module.vpc.private_subnets[0]
    vpc_security_group_ids = [
        aws_security_group.rocksea-sg.id,
        aws_security_group.app-svr-sg.id
    ]
    key_name = "${var.key_pair}"
    count = 1
    tags = {
        Name = "rocksea-bastion"
    }
}

