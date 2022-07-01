# vpc
  resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/19"
    
    tags = {
      name = "Main VPC"
    }
  }

  # public subnets
    resource "aws_subnet" "public-subnet1" {
      vpc_id = aws_vpc.main.id
      cidr_block = "10.0.0.0/24"

      tags = {
        Name = "First PubS"
        name = "Public subnet 1 created with Tf"
      }
    }

    resource "aws_subnet" "public-subnet2" {
      vpc_id = aws_vpc.main.id
      cidr_block = "10.0.1.0/24"

      tags = {
        Name = "Second PubS"
        name = "Public subnet 2 created with Tf"
      }
    }

  #private subnet
    resource "aws_subnet" "private-subnet" {
      vpc_id = aws_vpc.main.id
      cidr_block = "10.0.2.0/24"

      tags = {
        Name = "Main PrS"
        name = "Private subnet created with Tf"
      }
    }


# rds postgresql
  resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  name                 = "demodb"
  username             = "postgres"
  password             = "Password1"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  publicly_accessible  = true
  }
# eb app
  resource "aws_elastic_beanstalk_application" "tf-eb" {
    name        = var.eb-name
    description = var.eb-describtion
  }

# eb env
  resource "aws_elastic_beanstalk_environment" "tf-eb-env" {
    name                = var.eb-env-name
    application         = aws_elastic_beanstalk_application.tf-eb.name
    solution_stack_name = var.eb-env-solution-stack-name

    setting {
      namespace = "aws:ec2:vpc"
      name      = "VPCId"
      value     = var.vpc_id
    }
    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     =  "aws-elasticbeanstalk-ec2-role"
    }
    setting {
      namespace = "aws:ec2:vpc"
      name      = "AssociatePublicIpAddress"
      value     =  "True"
    }
  
    setting {
      namespace = "aws:ec2:vpc"
      name      = "Subnets"
      value     = join(",", var.public_subnets)
    }
    setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "MatcherHTTPCode"
      value     = "200"
    }
    setting {
      namespace = "aws:elasticbeanstalk:environment"
      name      = "LoadBalancerType"
      value     = "application"
    }
    setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "InstanceType"
      value     = "t2.medium"
    }
    setting {
      namespace = "aws:ec2:vpc"
      name      = "ELBScheme"
      value     = "internet facing"
    }
    setting {
      namespace = "aws:autoscaling:asg"
      name      = "MinSize"
      value     = 1
    }
    setting {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = 2
    }
    setting {
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      name      = "SystemType"
      value     = "enhanced"
    }
    setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "CONNECTION_STRING"
      value     = "Server=${aws_db_instance.default.endpoint},5432;Database=demodb;User Id=postgres;Password=Password1;"
    }
  }

