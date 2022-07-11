variable "allocated_storage_number" {
  type = number
  default = 10
}

variable "engine_type" {
  type = string
  description = "Default type of database"
  default = "postgres"
}

variable "engine_version_db" {
  type = string
  description = "Version of db engine"
  default = "13.4"
}

variable "instance_class_type" {
  type = string
  description = "Type of db instance type,important to know what should be used because it can change your bills"
  default = "db.t3.micro"
}

variable "db_name" {
  type = string
  description = "Database name that could be triggered"
  default = "demodb"
}

variable "db_username" {
    type = string
    description = "Database username"
    default = "postgres"
}

variable "db_password" {
  type = string
  description = "Database password for your username"
  default = "Password1"
}

variable "parameter_group_name_type" {
  type = string
  description = "Where the database would be stored (group name)"
  default = "default.postgres13"
}

variable "is_skip_final_snapshot" {
  type = bool
  default = true
}

variable "is_publicly_accessible" {
  type = bool
  default = true
}