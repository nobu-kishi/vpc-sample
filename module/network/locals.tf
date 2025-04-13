locals {
  public_subnet_cidrs = {
    for idx, az in var.public_subnet_azs :
    az => cidrsubnet(var.vpc_cidr, 8, idx)
  }

  private_subnet_cidrs = {
    for idx, az in var.private_subnet_azs :
    az => cidrsubnet(var.vpc_cidr, 8, idx + length(var.public_subnet_azs))
  }
}