# Lesson 7 — Helm

## Що реалізовано
- Terraform: VPC, EKS, ECR, S3/DynamoDB для state.
- Docker: образ Django завантажений у ECR.
- Helm chart: Deployment, Service (LoadBalancer), HPA, ConfigMap.

## Як запустити
1. Ініціалізувати Terraform:
   - `terraform init -reconfigure`
   - `terraform apply`
2. Підключити kubectl:
   - `aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks`
3. Зібрати і запушити образ у ECR:
   - `aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 804219314385.dkr.ecr.us-west-2.amazonaws.com`
   - `docker build -t lesson-7-ecr:latest .`
   - `docker tag lesson-7-ecr:latest 804219314385.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr:latest`
   - `docker push 804219314385.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr:latest`
4. Оновити values.yaml (env у ConfigMap).
5. Встановити Helm chart:
   - `helm upgrade --install django-app ./charts/django-app`

## Перевірка
- `kubectl get pods`
- `kubectl get svc`
- `kubectl get hpa`

## Нотатки
- Змінні середовища з теми 4 знаходяться у values.yaml → configMap.data.
