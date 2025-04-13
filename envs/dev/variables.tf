variable "name_prefix" {
  description = "Name prefix"
  type        = string

}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_azs" {
  description = "AZ list for public subnets"
  type        = list(string)
}

variable "private_subnet_azs" {
  description = "AZ list for private subnets"
  type        = list(string)
}
