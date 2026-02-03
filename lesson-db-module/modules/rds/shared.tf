locals {
  is_postgres = contains(["postgres", "aurora-postgresql"], var.engine)
  db_port     = var.port != 0 ? var.port : (local.is_postgres ? 5432 : 3306)

  pg_parameters = local.is_postgres ? [
    {
      name  = "max_connections"
      value = "200"
    },
    {
      name  = "log_statement"
      value = "all"
    },
    {
      name  = "work_mem"
      value = "4096"
    }
  ] : [
    {
      name  = "max_connections"
      value = "200"
    }
  ]
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db-subnet"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-subnet"
  })
}

resource "aws_security_group" "this" {
  name        = "${var.name_prefix}-db-sg"
  description = "DB access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.db_port
    to_port     = local.db_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-sg"
  })
}

resource "aws_db_parameter_group" "this" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.name_prefix}-rds-pg"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = local.pg_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rds-pg"
  })
}

resource "aws_rds_cluster_parameter_group" "this" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.name_prefix}-aurora-pg"
  family = var.aurora_parameter_group_family

  dynamic "parameter" {
    for_each = local.pg_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-aurora-pg"
  })
}
