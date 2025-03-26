module "network" {
  source = "../../module/network"

  name_prefix = var.name_prefix
  region      = var.region
  vpc_cidr    = var.vpc_cidr
  pub_cidrs   = var.public_subnet_cidrs
  pri_cidrs   = var.private_subnet_cidrs
}
