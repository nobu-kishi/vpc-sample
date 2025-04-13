provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "1.10.3"
  required_providers {
    aws = "5.91.0"
  }
  backend "s3" {}
}