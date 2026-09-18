# Wiki de onboarding para agentes de IA

Esta pasta foi criada para acelerar o entendimento do projeto e reduzir o custo de leitura inicial por agentes de IA e colaboradores.

## Objetivo

Servir como mapa de navegação do repositório, com foco em:
- arquitetura geral do Django
- organização de apps por domínio
- padrões de URL, views e modelos
- fluxo de desenvolvimento e testes
- convenções para edições e manutenção

## Visão geral do projeto

O repositório é um sistema de gestão empresarial em Django, organizado por módulos de negócio:
- cadastro
- login
- vendas
- compras
- estoque
- financeiro
- fiscal
- base

A configuração principal está em [djangosige/configs/settings.py](../djangosige/configs/settings.py), e a roteamento principal em [djangosige/urls.py](../djangosige/urls.py).

## Arquivos centrais

- [README.md](../README.md) — visão geral do projeto, dependências e instalação
- [manage.py](../manage.py) — entrypoint do Django
- [djangosige/configs/settings.py](../djangosige/configs/settings.py) — apps instaladas, middleware, templates e configuração de media/static
- [djangosige/urls.py](../djangosige/urls.py) — roteamento principal por módulo
- [djangosige/middleware.py](../djangosige/middleware.py) — middleware customizado de autenticação
- [djangosige/apps/base/views.py](../djangosige/apps/base/views.py) — dashboard e handlers de erro

## Estrutura em alto nível

- [djangosige/apps](../djangosige/apps) — módulos do sistema
- [djangosige/templates](../djangosige/templates) — templates HTML por área
- [djangosige/static](../djangosige/static) — CSS/JS/imagens estáticos
- [tests](../tests) — suíte de testes do projeto
- [fixtures](../fixtures) — dados iniciais e fixtures

## Índice rápido

- [Arquitetura do repositório](arquitetura.md)
- [Mapa de apps e módulos](mapa-de-apps.md)
- [Guia para agentes de IA](guia-agentes.md)
- [Checklist de manutenção](checklist-manutencao.md)

## Como usar esta wiki

1. Comece pela arquitetura geral.
2. Identifique o app relevante pelo prefixo da URL ou pelo domínio de negócio.
3. Siga o fluxo: modelo → formulário → view → URL → template.
4. Valide com testes e, quando possível, com a operação real no navegador.

## Observações importantes

- A aplicação usa o padrão Django com apps separados por contexto funcional.
- O projeto tem autenticação e autorização via Django Auth + middleware customizado.
- O código tem forte acoplamento entre modelos e views, especialmente em cadastros e operações financeiras.
- Muitas telas usam views baseadas em classes e templates de cadastro genéricos.

## Recomendação para agentes de IA

Ao analisar uma mudança, prefira este fluxo:

1. Localizar o módulo pelo nome do domínio e rota.
2. Ler o arquivo de URL do módulo.
3. Ler a view principal e o model relacionado.
4. Checar se há forms, mixins e templates associados.
5. Validar com testes específicos e, se necessário, rodar o projeto localmente.

---

Esta wiki deve ser atualizada sempre que o projeto evoluir, principalmente quando houver:
- criação de novos apps
- reorganização de URL patterns
- mudança de convenções de autenticação
- alterações em scripts de povoamento ou testes
