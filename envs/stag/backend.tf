terraform {
  backend "s3" {
    bucket = "stag-network-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}