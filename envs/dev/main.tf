module "network" {
  source = "../../module/network"

  env                = var.env
  system_name        = var.system_name
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  public_subnet_azs  = var.public_subnet_azs
  private_subnet_azs = var.private_subnet_azs
  create_nat_gateway = var.create_nat_gateway
}
