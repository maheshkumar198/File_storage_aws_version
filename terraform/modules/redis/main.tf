resource "aws_security_group" "redis" {

  name = "${var.project_name}-redis-sg"

  vpc_id = var.vpc_id

  ingress {

    from_port = 6379
    to_port   = 6379

    protocol = "tcp"

    cidr_blocks = [
      "10.0.0.0/16"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-redis-sg"
  }
}

resource "aws_elasticache_subnet_group" "this" {

  name = "${var.project_name}-redis-subnet-group"

  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_cluster" "this" {

  cluster_id = "${var.project_name}-redis"
  transit_encryption_enabled = true
  engine = "redis"

  node_type = "cache.t3.micro"

  num_cache_nodes = 1

  port = 6379

  parameter_group_name = "default.redis7"

  subnet_group_name = aws_elasticache_subnet_group.this.name

  security_group_ids = [
    aws_security_group.redis.id
  ]
}

resource "aws_secretsmanager_secret" "redis" {

  name = "${var.project_name}-redis-secret"

  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "redis" {

  secret_id = aws_secretsmanager_secret.redis.id

  secret_string = jsonencode({

    REDIS_HOST = aws_elasticache_cluster.this.cache_nodes[0].address

    REDIS_PORT = "6379"
  })
}