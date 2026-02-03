# Lesson DB Module — універсальний RDS/Aurora модуль

## Опис
Модуль створює:
- RDS instance **або** Aurora Cluster залежно від `use_aurora`.
- DB Subnet Group
- Security Group
- Parameter Group (з базовими параметрами)

## Приклад використання
```hcl
module "rds" {
  source = "./modules/rds"

  name_prefix  = "demo"
  use_aurora   = false
  engine       = "postgres"
  engine_version = "15.5"
  instance_class = "db.t3.micro"

  vpc_id     = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-aaaaaaa", "subnet-bbbbbbb", "subnet-ccccccc"]

  db_name  = "appdb"
  username = "appuser"
  password = "change-me"
}
```

### Aurora приклад
```hcl
module "rds" {
  source     = "./modules/rds"
  use_aurora = true
  engine     = "aurora-postgresql"
  engine_version = "15.5"
  instance_class = "db.t3.medium"

  vpc_id     = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-aaaaaaa", "subnet-bbbbbbb", "subnet-ccccccc"]

  db_name  = "appdb"
  username = "appuser"
  password = "change-me"
}
```

## Змінні
- `use_aurora` — true для Aurora, false для RDS instance
- `engine` — postgres/mysql/aurora-postgresql/aurora-mysql
- `engine_version` — версія engine
- `instance_class` — клас інстансу
- `multi_az` — Multi-AZ для RDS
- `allocated_storage`, `storage_type` — тільки для RDS
- `vpc_id`, `subnet_ids` — мережа для DB Subnet Group
- `allowed_cidr_blocks` — дозволені CIDR для доступу
- `parameter_group_family`, `aurora_parameter_group_family`
- `backup_retention_period`, `skip_final_snapshot`, `deletion_protection`
- `publicly_accessible`
- `aurora_instance_count`

## Як змінити тип БД
- Для Aurora: `use_aurora = true` та `engine = "aurora-postgresql"` або `"aurora-mysql"`.
- Для RDS: `use_aurora = false` та `engine = "postgres"` або `"mysql"`.

## Запуск
1. `terraform init -reconfigure`
2. `terraform apply`

## Зауваження
- Parameter Group налаштований для PostgreSQL (max_connections, log_statement, work_mem). Для MySQL змініть параметри/сімейство під свою версію.
- Не забудьте `terraform destroy` після перевірки, щоб не було зайвих витрат.
