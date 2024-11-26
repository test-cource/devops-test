resource "aws_security_group" "nginxvpc_sg" {
  name   = "${var.ENV_NAME}-nginxvpc-cluster-sg"
  vpc_id = aws_vpc.zebrah-vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["85.198.144.34/32", "91.193.129.182/32", "80.254.2.190/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["85.198.144.34/32", "91.193.129.182/32", "80.254.2.190/32"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["85.198.144.34/32", "91.193.129.182/32", "80.254.2.190/32"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.ENV_NAME}-nginx-ecs-cluster-sg"
    Environment = var.ENV_NAME
  }
}
