# vpc
  resource "aws_vpc" "main" {
    cidr_block = var.main_vpc_cidr_block_address
    
    tags = {
      name = "Main VPC"
    }
  }

  # availability zones
    data "aws_availability_zones" "azs" {
      state = "available"
    }

  # public subnets
    resource "aws_subnet" "public-subnet1" {
      availability_zone = "${data.aws_availability_zones.azs.names[0]}"
      vpc_id = aws_vpc.main.id
      cidr_block = var.first_public_subnet_cidr_block_address
      map_public_ip_on_launch = var.is_mapable_public_ip_on_launch
      tags = {
        Name = "First PubS"
        name = "Public subnet 1 created with Tf"
      }
    }

    resource "aws_subnet" "public-subnet2" {
      availability_zone = "${data.aws_availability_zones.azs.names[1]}"
      vpc_id = aws_vpc.main.id
      cidr_block = var.second_public_subnet_cidr_block_address
      map_public_ip_on_launch = var.is_mapable_public_ip_on_launch
      tags = {
        Name = "Second PubS"
        name = "Public subnet 2 created with Tfm"
      }
    }

  # private subnet
    resource "aws_subnet" "private-subnet" {
      vpc_id = aws_vpc.main.id
      cidr_block = var.privat_subnet_cidr_block_address

      tags = {
        Name = "Main PrS"
        name = "Private subnet created with Tf"
      }
    }

  # internet gateway
    resource "aws_internet_gateway" "igw" {
      vpc_id = aws_vpc.main.id

      tags = {
        Name = "Main IGW"
        name = "IGW for my pb subnets"
      }
    }

  # nat gateway eip
    resource "aws_eip" "nat_eip" {
      vpc = true
      depends_on = [
        aws_internet_gateway.igw
      ]
      tags = {
        Name = "NAT Gateway EIP"
        name = "nat gateway eip for my pr subnet"
      }
    }

  # nat gateway
    resource "aws_nat_gateway" "nat" {
      allocation_id = aws_eip.nat_eip.id
      subnet_id = aws_subnet.public-subnet1.id
      tags = {
        Name = "Main NAT Gateway"
      }
    }

  # routing tables
    resource "aws_route_table" "public-route-table" {
      vpc_id = aws_vpc.main.id

      route {
        cidr_block = var.public_accesible_route_table_cidr_block
        gateway_id = aws_internet_gateway.igw.id
      }

      tags = {
        Name = "Public Route table"
        name = "Public route table for subnets"
      }
    }

    resource "aws_route_table" "private-route-table" {
      vpc_id = aws_vpc.main.id

      route {
        cidr_block = var.public_accesible_route_table_cidr_block
        gateway_id = aws_internet_gateway.igw.id
      }

      tags = {
        Name = "Private Route table"
        name = "Private route table for private subnet"
      }
    }

    # association
      # public
        resource "aws_route_table_association" "public-association1" {
          subnet_id = aws_subnet.public-subnet1.id
          route_table_id = aws_route_table.public-route-table.id
        }

        resource "aws_route_table_association" "public-association2" {
          subnet_id = aws_subnet.public-subnet2.id
          route_table_id = aws_route_table.public-route-table.id
        }
      # private
        resource "aws_route_table_association" "private-association" {
          subnet_id = aws_subnet.private-subnet.id
          route_table_id = aws_route_table.private-route-table.id
        }
