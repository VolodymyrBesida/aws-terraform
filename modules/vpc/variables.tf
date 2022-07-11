variable "main_vpc_cidr_block_address" {
  type = string
  description = "Default address for main VPC cidr block"
  default = "10.0.0.0/19"
}

variable "first_public_subnet_cidr_block_address" {
  type = string
  description = "Default address for first public subnet that will be used in Load Balancer"
  default = "10.0.0.0/24"
}

variable "is_mapable_public_ip_on_launch" {
  type = bool
  default = true
}

variable "second_public_subnet_cidr_block_address" {
  type = string
  description = "Default address for second public subnet that will be used in Load Balancer"
  default = "10.0.1.0/24"
}

variable "privat_subnet_cidr_block_address" {
  type = string
  description = "Default address for privat subnet"
  default = "10.0.2.0/24"
}

variable "public_accesible_route_table_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}