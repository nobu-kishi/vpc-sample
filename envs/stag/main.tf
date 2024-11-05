module "network" {
  source = "../../module/network"

  name      = local.name
  region    = local.region
  vpc_cidr  = local.vpc_cidr
  pub_cidrs = local.public_subnet_cidrs
  pri_cidrs = local.private_subnet_cidrs
}
