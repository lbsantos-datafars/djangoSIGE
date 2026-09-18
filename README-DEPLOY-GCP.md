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

## 9. Débitos técnicos identificados

Os itens abaixo foram identificados durante a revisão da arquitetura para Cloud Run e precisam ser tratados antes de considerar o deploy em produção como estável.

### 9.1. Media e uploads persistentes
- O projeto usa `MEDIA_ROOT` em filesystem local em [djangosige/configs/settings.py](djangosige/configs/settings.py).
- Em Cloud Run, o contêiner não é persistente; arquivos salvos localmente podem desaparecer e não sobreviver a novas réplicas.
- Ação recomendada: migrar uploads para Cloud Storage e configurar `MEDIA_ROOT`/`MEDIA_URL` para acesso externo.

### 9.2. Static files na nuvem
- O sistema coleta arquivos estáticos em `STATIC_ROOT`, mas ainda não configura um backend de produção robusto.
- Ação recomendada: usar buckets do Cloud Storage ou WhiteNoise em produção, dependendo da arquitetura final.

### 9.3. Dependência do banco local em desenvolvimento
- O arquivo [docker-compose.yml](docker-compose.yml) ainda prepara um PostgreSQL local para ambiente de dev.
- Em produção, o app deve depender do Cloud SQL e deixar de considerar um banco embutido no contêiner.
- Ação recomendada: separar explicitamente `dev`, `staging` e `prod`.

### 9.4. Variáveis de ambiente e segurança
- O projeto já foi ajustado para leitura via ambiente, mas ainda vale reforçar a regra de nunca versionar segredos reais.
- Ação recomendada: manter `SECRET_KEY`, `DATABASE_URL`, tokens e chaves sempre em Secret Manager ou GitHub Actions Secrets.

### 9.5. Startup e migração automatizada
- O arranque do app foi ajustado para executar `migrate` e `collectstatic`, mas a aplicação ainda deve ser validada em cenário real com banco externo.
- Ação recomendada: validar migrações e carregamento de conteúdo em ambiente de staging antes do deploy em produção.

### 9.6. Infraestrutura de produção ainda precisa de validação real
- O Terraform e o workflow foram preparados, mas dependem do projeto GCP real, permissões e secrets reais.
- Ação recomendada: executar deploy em ambiente de staging e validar login, uploads, PDFs e operações críticas do ERP.

### 9.7. Processo de rollback e observabilidade
- Ainda não há revisão explícita de rollback, alertas, logs e health checks estratificados para produção.
- Ação recomendada: adicionar endpoints/health checks, alertas e política de rollout controlado.

### 9.8. Dependências do código legado
- O projeto usa patterns legados do Django e regras de negócio densas, o que exige testes mais extensivos em staging antes de produção.
- Ação recomendada: cobrir fluxos críticos de cadastro, vendas, financeiro e fiscal em automação de CI/CD.

## 10. Prioridade recomendada

1. Media e uploads em storage externo
2. Static files em ambiente de produção
3. Cloud SQL real e validação de migrações
4. Health checks e observabilidade
5. Testes de regressão em staging
6. Deploy final em produção
