module "network" {
  source = "../../module/network"

  name_prefix        = var.name_prefix
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  public_subnet_azs  = var.public_subnet_azs
  private_subnet_azs = var.private_subnet_azs
}
