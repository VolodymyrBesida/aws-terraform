variable eb-name {
  type = string
  description = "Name of AWS EB"
}

variable eb-describtion {
  type = string
  description = "Description value of 'description section' in EB"
  default = "My beanstalk application"
}

variable eb-env-name {
  type = string
  description = "Name of AWS EB environment"
}

variable eb-env-solution-stack-name {
  type         = string
  description   = "Solution stack for EB"
}

variable "tier" {
  type = string
}
 
//variable "vpc_id" {}
/*variable "public_subnets" {}
variable "elb_public_subnets" {}*/