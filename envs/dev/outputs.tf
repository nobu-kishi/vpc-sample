output "vpc_id" {
  value = module.network.vpc_id
}

output "pub_subnet_ids" {
  value = module.network.pub_subnet_ids
}

output "pri_subnet_ids" {
  value = module.network.pri_subnet_ids
}