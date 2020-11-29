data "aws_vpc" "russ_vpc" {
  id = "vpc-08e13a204ede421f5"
}

data "aws_subnet" "public_1a" {
  id = "subnet-0a98dc0cecd8268a3"
}

#data "aws_security_group" "selected" {
#  id = var.security_group_id
#}