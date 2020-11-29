resource "aws_instance" "jenkins_webapp" {
  ami               = var.AL2_AMI
  instance_type     = var.EC2_INSTANCE
  availability_zone = var.AWS_AZ
  security_groups   = [aws_security_group.jenkins_webapp.id]
  subnet_id         = data.aws_subnet.public_1a.id
  key_name = aws_key_pair.russ_desktop.id

#  root_block_device = [{
#    volume_type           = "gp2",
#    volume_size           = "30",
#    delete_on_termination = true,
#    encrypted             = true
#  }]

  tags = {
    "Name" = "aYo Jenkins"
  }

    user_data = file("scripts/user-data.sh")
}

resource "aws_key_pair" "russ_desktop" {
  key_name   = "russ-desktop-id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAD9AW5nVBjf29RaCkmhe8WkJlvgWJVmMMxuoeqvEIn4SNlJb7fYjYeMokemCV+VDg/6lH9w4T9cqbW1AflpziZKGsBv2XB+x6zGmcdnuLqQvCPNdWYUx4dgWOPcbWsuPp6bVhzsuulWirmeVS1cohUwoGW9oIDH4BWpqZq6BPD8HRFxNcVu4lSoBOGrrc2azKm9KLbwsDN6t5y6xfTXjGYJNE8/kxgWv5dn1dpIIK6hh3VFckzrZ95qEsmaLOvJPA+9ukca+qYWD9Tto151rOG/tnC++ULvBAr77ysoJaNJcdLDDXsPD6ueCEYFa9jgvf6Te1OGNMESl5CHcDB8U+3rObf4KbABG6mfKhYTOAEGcnNebNdFavXzhwK/3o8QxW4mTA66l+VlNLLH45DjUrtuD1DFLjbiKhSQ8hrxcxwSEDv91vFZ928sFLTKyIDo+UCTEkFWuhAgtobt9qfMnAuMGPhRdy+9ttpF26uDCPPzTel31Zk2aGiySUQAbpHUpSFzgSq4it/K/UrG7tLx9WL137u+qR3klTJH9CsPrPvZk3UknpXSlhPy1kHD1Rt5IuyoD56NEnd/cjyKqt2F5MlqhcEapSklOwQIVAu+gf9G7RwmjdXK2x4vxy0hK8DavTakupvIw88/i0O+EHengKFrpaIS0+3YkNH5j1AehgFvB+5E5XGRGX7UQlI5j40R6mQjh2qpPGnNhQegIy3F168eqRKuxwUxuMbFb2ZQvFFChvPHWJ7Cwjj3ZSS5XjAOiafNLXtAaE0oFk7NLE8KizqpedE/aH4gjTDQIth/g+LJVphtMFHvDmW3hxuRXCR5YVZrbw7c0MpvqXd2SeYIMto+Kxv6jYvEmj50S44fe5tRa1dbXLsthRdaETMPfj06VMEuxh3uGcpC+oYeQOwypjL7xoLPOZQEKBIH7+8erWKc2rCSD1G8rs9gvyqG4wk1jvCNDMe6hWO0zH+3aa8Mgmh4i4G+z2oouRm2g3t2ZMjZwhjIo/TK1eGMXcLUcBEZDJM9UeKZQ8NbwD1a7HxQWSRoBCzOUl32pzzlXv0r/9EdDNBXkUnp2KC7U7Mb8mPbrfvn8OTcv5T72H4xSM5ePNDJ02PtNwqpYt+90YwoM9ZzekncoUEMqz47uAp0fXDEgReiRRWh4stBaIfj2j0Y2UKIxDmeU8DeGRy82WdFXs/JuctVGrBNDEHBtu4NtKdVGEolblSxV3gQvFa6yLQ05X+08f0RjhcLE40z5qrbEQ9+nqg1g2PqeqUkG0yg7PPm23y6Xgc2uT15b4dcJJ0vOjaVZBzzudtPrrgxQ0RJiCIk7d5fwOym28mCK8k0tM4woM94H19j/U= russ desktop"
}