resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.zebrah-vpc.id
    cidr_block = "10.0.0.0/20"
    availability_zone  = format("%s%s", var.region, "a")
    map_public_ip_on_launch = "true"

    tags = {
        Name = "${var.ENV_NAME} public"
        Environment = var.ENV_NAME
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.zebrah-vpc.id
    cidr_block = "10.0.32.0/20"
    availability_zone  = format("%s%s", var.region, "c")
    map_public_ip_on_launch = "false"

    tags = {
        Name = "${var.ENV_NAME} private"
        Environment = var.ENV_NAME
    }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.zebrah-vpc.id

    tags = {
        Name = "${var.ENV_NAME} main gateway"
    }
}

# Nat gateway #1
resource "aws_eip" "nat_1" {
    tags = {
        Name = "${var.ENV_NAME} eip-1"
    }
}
resource "aws_nat_gateway" "nat_1" {
    allocation_id = aws_eip.nat_1.id
    subnet_id = aws_subnet.public.id
    tags = {
        Name = "${var.ENV_NAME} NAT"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.zebrah-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }

    tags = {
        Name = "${var.ENV_NAME} public-1"
    }
}

# route tables for NAT and private subnet
resource "aws_route_table" "main-private" {
    vpc_id = aws_vpc.zebrah-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_1.id
    }

    tags = {
        Name = "${var.ENV_NAME} main-private-1"
    }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.main-public.id
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.main-private.id
}