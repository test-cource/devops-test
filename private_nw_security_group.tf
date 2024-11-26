resource "aws_security_group" "private_nwvpc_sg" {
  name   = "${var.ENV_NAME}-private_nwvpc-cluster-sg"
  vpc_id = aws_vpc.zebrah-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.ENV_NAME}-private_nw-ecs-cluster-sg"
    Environment = var.ENV_NAME
  }
}
