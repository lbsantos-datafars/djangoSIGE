# Mapa de apps e módulos

## App: base

Local: [djangosige/apps/base](../djangosige/apps/base)

Função:
- dashboard inicial
- indicadores e alertas
- páginas base
- handlers de erro 404/500

Pontos importantes:
- [djangosige/apps/base/views.py](../djangosige/apps/base/views.py)
- [djangosige/apps/base/urls.py](../djangosige/apps/base/urls.py)

## App: login

Local: [djangosige/apps/login](../djangosige/apps/login)

Função:
- autenticação
- cadastro de usuários
- perfil do usuário
- seleção de empresa
- permissões

Arquivos centrais:
- [djangosige/apps/login/urls.py](../djangosige/apps/login/urls.py)
- [djangosige/apps/login/models.py](../djangosige/apps/login/models.py)
- [djangosige/apps/login/views.py](../djangosige/apps/login/views.py)

## App: cadastro

Local: [djangosige/apps/cadastro](../djangosige/apps/cadastro)

Função:
- clientes
- fornecedores
- empresas
- transportadoras
- produtos
- categorias, marcas, unidades
- dados base do sistema

Arquivos centrais:
- [djangosige/apps/cadastro/models/__init__.py](../djangosige/apps/cadastro/models/__init__.py)
- [djangosige/apps/cadastro/views/empresa.py](../djangosige/apps/cadastro/views/empresa.py)
- [djangosige/apps/cadastro/models/empresa.py](../djangosige/apps/cadastro/models/empresa.py)
- [djangosige/apps/cadastro/models/produto.py](../djangosige/apps/cadastro/models/produto.py)

## App: vendas

Local: [djangosige/apps/vendas](../djangosige/apps/vendas)

Função:
- orçamentos
- pedidos de venda
- pagamentos
- fluxo comercial

Arquivos relevantes:
- [djangosige/apps/vendas/urls.py](../djangosige/apps/vendas/urls.py)
- [djangosige/apps/vendas/models](../djangosige/apps/vendas/models)
- [djangosige/apps/vendas/views](../djangosige/apps/vendas/views)

## App: compras

Local: [djangosige/apps/compras](../djangosige/apps/compras)

Função:
- compras
- orçamentos de compra
- pedidos de compra
- pagamentos e fluxo de entrada

Arquivos relevantes:
- [djangosige/apps/compras/models](../djangosige/apps/compras/models)
- [djangosige/apps/compras/views](../djangosige/apps/compras/views)

## App: estoque

Local: [djangosige/apps/estoque](../djangosige/apps/estoque)

Função:
- movimentações de estoque
- locais e controle de produtos
- consulta de saldo e movimentação

Arquivos relevantes:
- [djangosige/apps/estoque/models](../djangosige/apps/estoque/models)
- [djangosige/apps/estoque/views](../djangosige/apps/estoque/views)

## App: financeiro

Local: [djangosige/apps/financeiro](../djangosige/apps/financeiro)

Função:
- lançamento financeiro
- contas a pagar/receber
- fluxo de caixa
- plano de contas

Arquivos relevantes:
- [djangosige/apps/financeiro/models](../djangosige/apps/financeiro/models)
- [djangosige/apps/financeiro/views](../djangosige/apps/financeiro/views)

## App: fiscal

Local: [djangosige/apps/fiscal](../djangosige/apps/fiscal)

Função:
- notas fiscais
- natureza de operação
- tributos
- processamento fiscal

Arquivos relevantes:
- [djangosige/apps/fiscal/models](../djangosige/apps/fiscal/models)
- [djangosige/apps/fiscal/views](../djangosige/apps/fiscal/views)

## Como identificar o módulo certo

Use a seguinte heurística:

- rota com prefixo /cadastro/ → cadastro
- rota com prefixo /login/ → login
- rota com prefixo /vendas/ → vendas
- rota com prefixo /compras/ → compras
- rota com prefixo /estoque/ → estoque
- rota com prefixo /financeiro/ → financeiro
- rota com prefixo /fiscal/ → fiscal

Quando a alteração for funcional e não necessariamente estrutural, siga a regra:

URL → view → form → model → template

## Convenção de arquivos

A maior parte do código segue a convenção de Django por app, com arquivos dedicados a:
- models
- views
- URLs
- forms
- templates
- tests

A arquitetura é mais orientada ao comportamento do ERP do que à criação de um backend REST completo.
