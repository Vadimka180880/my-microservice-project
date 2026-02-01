# Lesson 8-9 — Jenkins + Argo CD

## Як застосувати Terraform (створення інфраструктури)
1. `terraform init -reconfigure`
2. `terraform apply`

### Порядок запуску після `terraform destroy`
1. `terraform init -reconfigure`
2. `terraform apply` (створює S3/DynamoDB, VPC, EKS, ECR, Jenkins, Argo CD)
3. Дочекатись готовності Jenkins і Argo CD (LB адреси в outputs)

## Jenkins pipeline
- Jenkins встановлюється через Helm (Terraform модуль `jenkins`).
- Pipeline:
	1) збирає Docker-образ з `docker-django/Dockerfile`;
	2) пушить в ECR;
	3) оновлює `lesson-7/charts/django-app/values.yaml` (тег образу);
	4) пушить зміни у гілку `lesson-8-9`.

### Як перевірити Jenkins job
1. Відкрити Jenkins за URL з outputs.
2. В Job `django-cicd` натиснути **Build Now**.
3. Переконатись у Console Output, що:
	 - образ запушився в ECR;
	 - `values.yaml` оновився і запушився в Git.

## Argo CD
- Argo CD встановлюється через Helm (Terraform модуль `argo_cd`).
- Argo Application дивиться на repo та шлях `lesson-7/charts/django-app`.
- Auto Sync увімкнено — після зміни Git Argo синхронізує застосунок.

### Як побачити результат в Argo CD
1. Відкрити Argo CD за URL з outputs.
2. Логін `admin`, пароль з outputs (initial admin password).
3. В `django-app` перевірити статуси **Synced**/**Healthy**.

## Що потрібно заповнити
- `terraform.tfvars`: repo URL, Jenkins креденшели, bucket, ECR repo, GitOps path.
- `Jenkinsfile`: шлях до Dockerfile, IDs креденшелів, гілка GitOps (`lesson-8-9`).

## Налаштовані значення (поточні)
- Dockerfile: `docker-django/Dockerfile`
- Git credentials ID: `git-cred`
- AWS credentials ID: `aws-cred`
- GitOps branch: `lesson-8-9`

## Як видалити інфраструктуру
`terraform destroy`

> Увага: після `destroy` видаляються S3 і DynamoDB для стейту. Наступний запуск починається з `terraform init -reconfigure`.
