# Final Project — DevOps Infrastructure on AWS

## Опис
Інфраструктура розгортає:
- VPC, EKS, ECR
- Jenkins + Argo CD (CI/CD)
- RDS або Aurora (через `rds_use_aurora`)
- Monitoring (Prometheus + Grafana)

## Структура
- `modules/` — всі Terraform модулі
- `charts/django-app` — Helm chart застосунку
- `Django/` — Dockerfile, Jenkinsfile, docker-compose

## Підготовка
1. Перевірити `terraform.tfvars` (або створити з прикладу).
2. Ініціалізувати Terraform:
   - `terraform init -reconfigure`

## Розгортання
- `terraform apply`

## Перевірка компонентів
```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```

## Доступ через port-forward
```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
kubectl port-forward svc/argocd-server 8081:443 -n argocd
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring
```

## CI/CD перевірка
1. Jenkins: Job `django-cicd` → **Build Now**.
2. Переконатись, що образ запушився у ECR.
3. Argo CD має синхронізувати застосунок із Git.

## Налаштування RDS/Aurora
- `rds_use_aurora = false` → створюється RDS instance
- `rds_use_aurora = true` → створюється Aurora cluster

## Важливо
- Після перевірки: `terraform destroy`.
- Пам'ятайте: `destroy` видаляє S3/DynamoDB для стейту.

## Змінні (ключові)
- `aws_region`
- `tf_state_bucket_name`, `tf_lock_table_name`
- `eks_cluster_name`
- `rds_use_aurora`, `rds_engine`, `rds_instance_class`
- `jenkins_admin_user`, `jenkins_admin_password`
- `grafana_admin_password`
        