# Política de segurança

Este projeto é open source e não deve conter segredos, chaves, tokens, credenciais ou dados sensíveis no repositório.

## Regras

- nunca versionar `SECRET_KEY` reais
- nunca versionar senhas de banco, SMTP, serviços de nuvem ou tokens
- usar variáveis de ambiente, GitHub Actions secrets, Secret Manager ou equivalente
- manter apenas exemplos genéricos em arquivos como `.env.example`
- revisar PRs antes de merge para confirmar que não há segredos acidentais

## Ambientes recomendados

- desenvolvimento local: `.env` ignorado pelo Git
- CI/CD: secrets do provedor de pipeline
- produção: Secret Manager / Google Secret Manager / equivalente

## Exemplo seguro

- `.env.example` contém placeholders
- o runtime recebe valores reais via ambiente
- o repositório mantém apenas templates e instruções
