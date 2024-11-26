resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "${var.ENV_NAME}-ecs_service_role_policy"
  policy = file("policies/ecs-service-role-policy.json")
  role   = aws_iam_role.zebrah_ecs_role.id
}

resource "aws_iam_role" "zebrah_ecs_role" {
  name               = "${var.ENV_NAME}-zebrah_ecs_role"
  assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_security_group" "awsvpc_sg" {
  name   = "${var.ENV_NAME}-awsvpc-cluster-sg"
  vpc_id = aws_vpc.zebrah-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name        = "${var.ENV_NAME}-ecs-cluster-sg"
    Environment = var.ENV_NAME
  }
}

resource "aws_key_pair" "node_instance_key" {
  key_name   = "${var.ENV_NAME}node_instance_key"
  public_key = tls_private_key.engine.public_key_openssh

}


output "key_pair" {
    value = tls_private_key.engine.private_key_pem
}

resource "tls_private_key" "engine" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
