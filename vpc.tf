resource "aws_vpc" "zebrah-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  //main_route_table_id = aws_route_table.public-route-table.id
  //default_route_table_id = aws_route_table.public-route-table.id
  tags = {
    Name        = "${var.ENV_NAME} vpc"
    Environment = var.ENV_NAME
  }
}
