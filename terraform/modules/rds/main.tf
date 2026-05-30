locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_db_subnet_group" "this" {
  
  name       = "${local.name_prefix}-rds-subnets"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${local.name_prefix}-rds-subnet-group"
  }
}

resource "aws_security_group" "this" {
  
  name        = "${local.name_prefix}-rds-sg"
  description = "Security group for ${local.name_prefix} RDS"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = length(var.allowed_security_group_ids) > 0 ? [1] : []

    content {
      description     = "Database access from allowed security groups"
      from_port       = var.port
      to_port         = var.port
      protocol        = "tcp"
      security_groups = var.allowed_security_group_ids
    }
  }

  dynamic "ingress" {
    for_each = length(var.allowed_cidr_blocks) > 0 ? [1] : []

    content {
      description = "Database access from allowed CIDR blocks"
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-rds-sg"
  }
}

resource "random_password" "db_password" {
  length  = 20
  special = true
  override_special = "!#$%^&*()-_=+[]{}<>?"
 
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name = var.aws_db_secret_name 
  recovery_window_in_days = 0
  
}

resource "aws_secretsmanager_secret_version" "rds_secret_value" {

  secret_id = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({

    host     = aws_db_instance.this.address
    username = aws_db_instance.this.username
    password = random_password.db_password.result
    database = aws_db_instance.this.db_name
    port     = aws_db_instance.this.port
  })

  
}

resource "aws_db_instance" "this" {
  identifier = "${local.name_prefix}-db"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  iam_database_authentication_enabled = true
  username                    = var.username
  password                    = random_password.db_password.result
  db_name                     = var.db_name
  port                        = var.port
  publicly_accessible         = var.publicly_accessible
  multi_az                    = var.multi_az
  storage_encrypted           = true
  backup_retention_period     = var.backup_retention_period
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  deletion_protection         = var.deletion_protection
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = var.skip_final_snapshot ? null : "${local.name_prefix}-final-snapshot"
  db_subnet_group_name        = aws_db_subnet_group.this.name
  vpc_security_group_ids      = [aws_security_group.this.id]

  tags = {
    Name = "${local.name_prefix}-db"
  }
  
}
