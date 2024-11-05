# version指定しないと、明示的に指定していないパラメータが意図しない値になる場合がある
# terraform {
#   required_version = "1.5.6"
#   required_providers {
#     aws = "3.34.0"
#   }
# }