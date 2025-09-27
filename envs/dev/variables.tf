variable "env" {
  description = "環境名"
  type        = string
}

variable "system_name" {
  description = "システム名"
  type        = string
}

variable "region" {
  description = "リージョン"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDR"
  type        = string
}

variable "public_subnet_azs" {
  description = "パブリックサブネットのAZリスト"
  type        = list(string)
}

variable "private_subnet_azs" {
  description = "プライベートサブネットのAZリスト"
  type        = list(string)
}
