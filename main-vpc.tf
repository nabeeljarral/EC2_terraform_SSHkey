resource "aws_vpc" "staging" {
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${local.staging_env}-vpc"
  }
}

resource "aws_subnet" "staging" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "20.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.staging_env} Public-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.staging.id

  tags = {
    Name = "${local.staging_env}-IGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.staging_env}-route_table"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.staging.id
  route_table_id = aws_route_table.rt.id
}

