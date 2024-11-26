#output "public_ip" {
#  description = "List of public IP addresses assigned to the instances, if applicable"
#  value       = aws_instance.this.*.public_ip
#}

#output "private_ip" {
#  description = "List of private IP addresses assigned to the instances, if applicable"
#  value       = aws_instance.this.*.private_ip
#}


output "docker_machine_public_ip_addresses" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.docker_machine.public_ip
}

output "docker_machine_private_ip_addresses" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = aws_instance.docker_machine.private_ip
}

output "docker_machine_public_dns_names" {
  description = "List of public DNS assigned to the instances, if applicable"
  value       = aws_instance.docker_machine.public_dns
}

output "casandra_public_ip_addresses" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.casandra.public_ip
}

output "casandra_private_ip_addresses" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = aws_instance.casandra.private_ip
}

output "casandra_public_dns_names" {
  description = "List of public DNS assigned to the instances, if applicable"
  value       = aws_instance.casandra.public_dns
}
