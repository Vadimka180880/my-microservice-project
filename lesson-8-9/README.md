# Lesson 8-9 — Jenkins + Argo CD

## Як застосувати Terraform
1. `terraform init -reconfigure`
2. `terraform apply`

## Jenkins pipeline     
- Jenkins встановлюється через Helm.
- Pipeline збирає образ, пушить у ECR, оновлює values.yaml в GitOps репозиторії.
        
## Argo CD  
- Argo CD встановлюється через Helm.
- Argo Application слідкує за GitOps репозиторієм і синхронізує застосунок.

## Що потрібно заповнити
- `terraform.tfvars`: repo URL, Jenkins креденшели, bucket, ECR repo.
- `Jenkinsfile`: назви репозиторіїв і креденшелів.
