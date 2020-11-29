resource "aws_security_group" "jenkins_webapp" {
  name        = "jenkins-webapp"
  description = "Allows HTTP, HTTPS and SSH in and out for Jenkins, SSH and Git."
  vpc_id      = data.aws_vpc.russ_vpc.id

  tags = {
    "Name" = "aYo Jenkins"
  }
}

resource "aws_security_group_rule" "jenkins_webapp_icmp" {
  protocol          = "icmp"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "http_outbound" {
  protocol          = "6"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "https_outbound" {
  protocol          = "6"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "http_inbound" {
  protocol          = "6"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "https_inbound" {
  protocol          = "6"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "ssh_outbound" {
  protocol          = "6"
  type              = "egress"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "ssh_inbound" {
  protocol          = "6"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}

resource "aws_security_group_rule" "http_jenkins_inbound" {
  protocol          = "6"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_webapp.id
}
