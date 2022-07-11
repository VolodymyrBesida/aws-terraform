# rds postgresql
  resource "aws_db_instance" "default" {
    allocated_storage    = var.allocated_storage_number
    engine               = var.engine_type
    engine_version       = var.engine_version_db
    instance_class       = var.instance_class_type
    name                 = var.db_name
    username             = var.db_username
    password             = var.db_password
    parameter_group_name = var.parameter_group_name_type
    skip_final_snapshot  = var.is_skip_final_snapshot
    publicly_accessible  = var.is_publicly_accessible
  }