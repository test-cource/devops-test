resource "aws_instance" "docker_machine" {
  ami = data.aws_ami.ubuntu_18_04.id
  instance_type = "t3.xlarge"
  iam_instance_profile = "ecsInstanceRole"
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ENV_NAME}_main_ecs>> /etc/ecs/ecs.config
EOF
  tags = {
    Name = "${var.ENV_NAME} docker_machine"
  }

root_block_device {
  volume_size = "30"
}

# the VPC subnet
subnet_id = aws_subnet.public.id

# the security group
vpc_security_group_ids = [
  aws_security_group.sshvpc_sg.id,
  aws_security_group.nginxvpc_sg.id,
  aws_security_group.private_nwvpc_sg.id,
]

# the public SSH key
key_name = aws_key_pair.node_instance_key.key_name
}
