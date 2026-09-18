# Guia para agentes de IA

## Objetivo

Este guia orienta agentes de IA a explorar e modificar o repositório com eficiência, sem perder contexto sobre o domínio do ERP.

## 1. Primeiros pontos de leitura

Ao entrar no projeto, o agente deve começar por:

1. [README.md](../README.md)
2. [djangosige/configs/settings.py](../djangosige/configs/settings.py)
3. [djangosige/urls.py](../djangosige/urls.py)
4. app de domínio relacionado à tarefa
5. arquivos de tests relacionados

Esses passos permitem compreender contexto geral antes de propor correções ou implementações.

## 2. Como localizar o módulo correto

Se a tarefa envolve uma tela, fluxo ou regra de negócio, siga esta ordem:

- identificar o prefixo da URL
- localizar o app correspondente
- abrir o urls.py do app
- estudar a view e o model envolvidos
- confirmar os templates usados

Exemplo:
- tarefa em cadastro de empresa → app cadastro
- tarefa em nota fiscal → app fiscal
- tarefa em fluxo de caixa → app financeiro

## 3. Fluxo recomendado de investigação

Para cada ajuste, faça:

1. buscar a URL ou nome da funcionalidade
2. ler o urls.py do app
3. ler a view principal
4. verificar form e model
5. olhar template relevante
6. confirmar se há testes cobrindo o caso

## 4. Práticas de alteração segura

- manter o padrão do projeto de view por classe
- respeitar o acoplamento entre URL, form, model e template
- preferir alterações pequenas e localizadas
- verificar se o nome das rotas e os reverse_lazy continuam consistentes
- quando alterar modelos, checar widgets/queries/filters usados em templates

## 5. Como validar mudanças

Antes de concluir a tarefa, execute verificações relevantes:

- testes específicos do app alterado
- testes de segurança e ajax, quando a alteração mexer em telas ou endpoints
- execução manual do fluxo quando o comportamento for visual ou de regra de negócio

Comandos comuns:

- uv run python manage.py test
- uv run python manage.py test tests.test_security_ajax_views
- uv run python manage.py runserver

## 6. Padrões visíveis no código

Este repositório usa vários padrões típicos do Django legado:

- views baseadas em classes
- uso de mixins e classes de base em cadastros
- URLs com regex antigos (re_path como alias de url)
- templates em estrutura organizada por módulo
- models bem específicos por domínio

## 7. Principais riscos de erro

Entre os riscos mais comuns:

- alterar a URL e esquecer o reverse_lazy
- mexer em model sem verificar templates ou forms
- quebrar fluxo de autenticação ou middleware
- criar dependência entre módulos sem revisar as imports
- alterar regras de negócio sem escrever ou ajustar testes

## 8. Checklist para implementação

Antes de finalizar uma tarefa, confirmar:

- [ ] módulo correto identificado
- [ ] URL e app confirmados
- [ ] model e form revisados
- [ ] view e template afetados verificados
- [ ] testes relacionados executados
- [ ] edição compatível com o domínio do ERP

## 9. Prompt útil para agentes

Uso recomendado em prompts de IA:

> Analise este app Django do ERP, identifique a rota, a view e o model relacionados ao fluxo solicitado, explique a relação entre URL, form e template, e proponha a alteração mínima de forma compatível com a arquitetura existente.

## 10. Resumo

O agente deve tratar o projeto como um ERP modular em Django, com foco em domínio funcional e em contexto de UI do sistema. O entendimento correto vem da leitura em camadas: URL → app → view → form → model → template → testes.
