module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "rocksea-vpc"
  cidr = "172.16.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  private_subnets = ["172.16.10.0/24", "172.16.20.0/24", "172.16.30.0/24"]
  public_subnets  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]

  public_dedicated_network_acl   = true
  public_inbound_acl_rules       = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  public_outbound_acl_rules      = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
