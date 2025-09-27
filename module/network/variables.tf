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

variable "create_nat_gateway" {
  description = "NAT Gatewayを作成するかの可否"
  type        = bool
  default     = false

  validation {
    condition     = var.create_nat_gateway == false || length(var.public_subnet_azs) > 0
    error_message = "NAT Gatewayを作成する場合は、少なくとも1つのパブリックサブネットを定義してください。"
  }
}
