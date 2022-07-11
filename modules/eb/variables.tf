variable eb-name {
  type = string
  description = "Name of AWS EB"
  default = "my-geo-application"
}

variable eb-describtion {
  type = string
  description = "Description value of 'description section' in EB"
  default = "My beanstalk application"
}

variable eb-env-name {
  type = string
  description = "Name of AWS EB environment"
  default = "my-geo-app-environment"
}

variable eb-env-solution-stack-name {
  type         = string
  description   = "Solution stack for EB"
  default = "64bit Amazon Linux 2018.03 v3.4.21 running Tomcat 8.5 Java 8"
}

variable "db_instance_endpoint" {
  type = string
  description = "Instance address for connecting to database"
}

variable "db_instance_username" {
  type = string
  description = "Username for connection to database"
}

variable "main_vpc_id" {
  type = string
  description = "Id of main VPC"
}

variable "loadb_public_subnet1_id" {
  type = string
  description = "Id of first subnet for load balancer"
}

variable "loadb_public_subnet2_id" {
  type = string
  description = "Id of second subnet for load balancer"
}