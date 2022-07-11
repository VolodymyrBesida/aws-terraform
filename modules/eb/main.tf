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
      value     = var.main_vpc_id
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
      value     = "${var.loadb_public_subnet1_id},${var.loadb_public_subnet2_id}"
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
      name      = "JDBC_CONNECTION_STRING"
      value     = "jdbc:postgresql://${var.db_instance_endpoint}:5432/demodb?user=${var.db_instance_username}&password=Password1"
    }
  }
