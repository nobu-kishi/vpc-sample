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

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = map(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = map(string)
}
