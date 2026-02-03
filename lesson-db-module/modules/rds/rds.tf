resource "aws_db_instance" "this" {
  count = var.use_aurora ? 0 : 1

  identifier             = "${var.name_prefix}-rds"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  parameter_group_name   = aws_db_parameter_group.this[0].name
  username               = var.username
  password               = var.password
  db_name                = var.db_name
  port                   = local.db_port
  publicly_accessible    = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot    = var.skip_final_snapshot
  deletion_protection    = var.deletion_protection
  apply_immediately      = var.apply_immediately

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rds"
  })
}
