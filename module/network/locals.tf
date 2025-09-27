locals {
  prefix = "${var.env}-${var.system_name}"

  public_subnet_cidrs = {
    for idx, az in var.public_subnet_azs :
    az => cidrsubnet(var.vpc_cidr, 8, idx)
  }

  private_subnet_cidrs = {
    for idx, az in var.private_subnet_azs :
    az => cidrsubnet(var.vpc_cidr, 8, idx + length(var.public_subnet_azs))
  }

  nat_public_subnet_key = length(var.public_subnet_azs) > 0 ? var.public_subnet_azs[0] : null
}
