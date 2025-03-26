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

variable "pub_cidrs" {
  description = "Public subnet CIDRs"
  type        = map(string)
}

variable "pri_cidrs" {
  description = "Private subnet CIDRs"
  type        = map(string)
}