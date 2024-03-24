# VPC creation
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "terraform-uc2-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" 
  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b" 
  tags = {
    Name = "public-subnet-b"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "terraform-igw"
  }
}


# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate public subnet A with public route table
resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate public subnet B with public route table
resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}