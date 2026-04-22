module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.name}-vpc"
  cidr = "10.10.0.0/16"

  azs = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]

  public_subnets = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24"
  ]

  private_subnets = [
    "10.10.101.0/24",
    "10.10.102.0/24",
    "10.10.103.0/24"
  ]

  enable_nat_gateway = false
  single_nat_gateway = true
  map_public_ip_on_launch = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = merge(var.tags, {
    "kubernetes.io/cluster/${var.name}" = "shared"
  })
}