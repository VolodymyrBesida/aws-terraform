variable "eb_address" {
  type = string
  description = "Default route for my realization of eb"
  default = "./modules/eb"
}

variable "rds_address" {
  type = string
  description = "Default route for my realization of rds"
  default = "./modules/rds"
}

variable "vpc_address" {
  type = string
  description = "Default route for my realization of vpc"
  default = "./modules/vpc"
}