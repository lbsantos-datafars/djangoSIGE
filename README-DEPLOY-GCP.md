# Deploy no Google Cloud Run

Este guia resume a forma recomendada de publicar este projeto no GCP com infraestrutura mínima e segura.

## Requisitos

- Conta GCP com projeto ativo
- `gcloud` instalado e autenticado
- Terraform instalado
- Docker instalado
- acesso ao GitHub Actions ou outro CI/CD

## 1. Preparar o projeto GCP

Ative as APIs:

```bash
gcloud services enable run.googleapis.com sqladmin.googleapis.com artifactregistry.googleapis.com secretmanager.googleapis.com
```

Crie o repositório de imagens no Artifact Registry:

```bash
gcloud artifacts repositories create djangosige \
  --repository-format=docker \
  --location=southamerica-east1 \
  --description="Imagens do DjangoSIGE"
```

## 2. Criar um secret para a Django SECRET_KEY

```bash
gcloud secrets create django-secret-key --replication-policy="automatic"
gcloud secrets versions add django-secret-key --data-file=/path/to/secret.txt
```

## 3. Build da imagem

```bash
docker build -t southamerica-east1-docker.pkg.dev/SEU_PROJETO/djangosige/djangosige:latest .
```

## 4. Configurar Terraform

Copie o exemplo:

```bash
cp infra/terraform/terraform.tfvars.example infra/terraform/terraform.tfvars
```

Edite o arquivo com os valores reais do projeto.

## 5. Deploy com Terraform

```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

## 6. Variáveis de ambiente em produção

Use o Cloud Run para injetar as variáveis de ambiente a partir de Secrets ou do próprio Terraform:

- `SECRET_KEY`
- `DEBUG=False`
- `ALLOWED_HOSTS=*`
- `CSRF_TRUSTED_ORIGINS=https://<service>.a.run.app`
- `DATABASE_URL`
- `PORT=8080`

## 7. O que NÃO deve ficar no repositório

- senhas
- chaves
- tokens
- secret keys
- URLs de banco reais

Esses valores devem entrar por:
- Secret Manager
- GitHub Actions Secrets
- variáveis de ambiente do provider da nuvem

## 8. Observações

- O Cloud Run é efêmero. Não guardar uploads ou arquivos em filesystem local.
- Para media e uploads, o recomendado é um bucket no Cloud Storage.
- O banco deve ser o Cloud SQL Postgres.
