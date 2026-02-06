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

| Змінна | Опис | Default |
|---|---|---|
| `name_prefix` | Префікс назв ресурсів | `app` |
| `use_aurora` | Створювати Aurora (true) або RDS (false) | `false` |
| `engine` | Engine: postgres/mysql/aurora-postgresql/aurora-mysql | `postgres` |
| `engine_version` | Версія engine | `15.5` |
| `instance_class` | Клас інстансу | `db.t3.micro` |
| `multi_az` | Multi-AZ для RDS | `false` |
| `allocated_storage` | Розмір диску для RDS (GB) | `20` |
| `storage_type` | Тип диску для RDS | `gp3` |
| `db_name` | Початкова DB | `appdb` |
| `username` | Master username | `appuser` | 
| `password` | Master password | _required_ |
| `port` | Порт (0 = default by engine) | `0` |  
| `vpc_id` | VPC ID | _required_ | 
| `subnet_ids` | Subnet IDs для subnet group | _required_ |
| `allowed_cidr_blocks` | Дозволені CIDR | `["0.0.0.0/0"]` |
| `parameter_group_family` | Family для RDS parameter group | `postgres15` |
| `aurora_parameter_group_family` | Family для Aurora parameter group | `aurora-postgresql15` |
| `backup_retention_period` | Retention (days) | `7` |
| `skip_final_snapshot` | Пропустити фінальний snapshot | `true` |
| `deletion_protection` | Захист від видалення | `false` |
| `publicly_accessible` | Публічний доступ | `false` |
| `aurora_instance_count` | К-сть інстансів Aurora | `1` |
| `apply_immediately` | Apply immediately | `true` |
| `tags` | Теги | `{}` |

## Як змінити тип БД
- Для Aurora: `use_aurora = true` та `engine = "aurora-postgresql"` або `"aurora-mysql"`.
- Для RDS: `use_aurora = false` та `engine = "postgres"` або `"mysql"`.

## Запуск
1. `terraform init -reconfigure`
2. `terraform apply`

## Зауваження
- Parameter Group налаштований для PostgreSQL (max_connections, log_statement, work_mem). Для MySQL змініть параметри/сімейство під свою версію.
- Не забудьте `terraform destroy` після перевірки, щоб не було зайвих витрат.
