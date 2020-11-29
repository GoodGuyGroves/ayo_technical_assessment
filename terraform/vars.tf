variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  type    = string
  default = "af-south-1"
}

variable "AWS_AZ" {
  type    = string
  default = "af-south-1a"
}

variable "EC2_INSTANCE" {
  type    = string
  default = "t3.small"
}

variable "AL2_AMI" {
  type    = string
  default = "ami-0bb140f2ff1df29fc"
}