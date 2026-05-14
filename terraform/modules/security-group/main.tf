## sg of alb
resource "aws_security_group" "alb_sg" {
  name = "${var.project_name}-alb-sg"

  description = "ALB Security Group"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_outbound_all" {
  security_group_id = aws_security_group.alb_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}

##sg of ec2

resource "aws_security_group" "ec2_sg" {
  name = "${var.project_name}-ec2-sg"

  description = "EC2 Security Group"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-ec2-sg"

  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_outbound_all" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}


resource "aws_security_group_rule" "allow_http_from_alb_to_ec2" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "allow_ssh_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22 
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  cidr_blocks             = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_tls_from_alb_to_ec2" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

##sg of rds

resource "aws_security_group" "rds_sg" {
  name = "${var.project_name}-rds-sg"

  description = "RDS Security Group"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}


resource "aws_security_group_rule" "allow_5432_from_ec2_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_vpc_security_group_egress_rule" "rds_outbound_all" {
  security_group_id = aws_security_group.rds_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}




