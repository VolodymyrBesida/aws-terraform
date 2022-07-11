output "db_endpoint" {
    value = aws_db_instance.default.endpoint
}

output "db_username_credential" {
  value = aws_db_instance.default.username
}