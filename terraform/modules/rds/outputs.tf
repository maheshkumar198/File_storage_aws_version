output "db_instance_id" {
  value = aws_db_instance.this.id
}

output "db_instance_address" {
  value = aws_db_instance.this.address
}

output "db_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_instance_port" {
  value = aws_db_instance.this.port
}

output "db_security_group_id" {
  value = aws_security_group.this.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}

output "db_resource_id" {
  value = aws_db_instance.this.resource_id
}