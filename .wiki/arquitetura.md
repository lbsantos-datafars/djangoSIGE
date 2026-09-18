# Arquitetura do repositório

## 1. Estrutura do projeto

O projeto está organizado como um projeto Django com múltiplos apps de negócio, todos dentro de [djangosige](../djangosige):

- [djangosige/apps/base](../djangosige/apps/base) — base, dashboard e helpers gerais
- [djangosige/apps/login](../djangosige/apps/login) — autenticação, perfil e usuários
- [djangosige/apps/cadastro](../djangosige/apps/cadastro) — clientes, fornecedores, empresas, produtos, etc.
- [djangosige/apps/vendas](../djangosige/apps/vendas) — orçamentos, pedidos e pagamentos
- [djangosige/apps/compras](../djangosige/apps/compras) — compras, pagamentos e fluxo de entrada
- [djangosige/apps/estoque](../djangosige/apps/estoque) — movimentações e locais
- [djangosige/apps/financeiro](../djangosige/apps/financeiro) — contas, lançamentos, fluxo de caixa
- [djangosige/apps/fiscal](../djangosige/apps/fiscal) — notas fiscais, tributos e natureza de operação

## 2. Configuração central

A configuração principal está em:
- [djangosige/configs/settings.py](../djangosige/configs/settings.py)

Nesse arquivo encontra-se:
- INSTALLED_APPS
- MIDDLEWARE
- ROOT_URLCONF
- TEMPLATES
- STATIC_URL e MEDIA_ROOT
- TIME_ZONE e LANGUAGE_CODE
- autenticação e permissões

Observações importantes:
- o projeto usa middleware customizado para páginas que exigem login
- os apps são registrados em ordem funcional
- a URL global é montada em [djangosige/urls.py](../djangosige/urls.py)

## 3. Roteamento principal

A rota principal do sistema é definida em [djangosige/urls.py](../djangosige/urls.py):

- /admin/
- /login/
- /cadastro/
- /fiscal/
- /vendas/
- /compras/
- /financeiro/
- /estoque/

A partir disso, cada app define suas próprias URLs com prefixes e padrões específicos.

## 4. Padrão de app

A estrutura mais comum de um app é:

- apps.py
- urls.py
- models/
- views/
- forms/
- templates/
- migrations/

Exemplo:
- [djangosige/apps/login/urls.py](../djangosige/apps/login/urls.py)
- [djangosige/apps/cadastro/views/empresa.py](../djangosige/apps/cadastro/views/empresa.py)
- [djangosige/apps/cadastro/models/empresa.py](../djangosige/apps/cadastro/models/empresa.py)

O padrão do repositório é seguir o fluxo:

1. URL do módulo
2. View ou mixin
3. Formulário
4. Modelo
5. Template

## 5. Base da UI

A aplicação base expõe o dashboard principal e os handlers de erro:
- [djangosige/apps/base/views.py](../djangosige/apps/base/views.py)
- [djangosige/apps/base/urls.py](../djangosige/apps/base/urls.py)

Essa área serve como centro de informação operacional do sistema, resumindo quantidade de cadastros, agenda do dia e alertas de pendências.

## 6. Autenticação e autorização

O projeto usa Django Auth como base e um middleware customizado em [djangosige/middleware.py](../djangosige/middleware.py). A configuração de login e permissões é reforçada por views e rotas específicas em login.

Pontos relevantes:
- login e usuário são app próprios
- o middleware controla páginas que requerem autenticação
- permissões são verificadas por código de permissão em views e ações de CRUD

## 7. Testes

A suíte de testes fica em [tests](../tests) e é organizada por módulos.

Estrutura típica:
- [tests/test_security_ajax_views.py](../tests/test_security_ajax_views.py)
- [tests/test_settings.py](../tests/test_settings.py)
- [tests/base](../tests/base)
- [tests/cadastro](../tests/cadastro)
- [tests/vendas](../tests/vendas)

Recomenda-se seguir o padrão de testar comportamento real e não apenas mocks de UI ou abstrações.

## 8. Regras de negócio do domínio

O projeto é um ERP para gestão empresarial e o domínio é bastante rico:
- cadastro de pessoas e empresas
- produtos, fornecedores, clientes, transportadoras
- vendas, compras, estoque, financeiro e fiscal
- processamento e acompanhamento de contas a pagar/receber

Logo, alterações em um app podem impactar diretamente processos de integração com outros módulos.

## 9. Recomendações para edição

Antes de tocar em qualquer parte:
- identificar o app e domínio correspondente
- verificar a URL do módulo
- verificar os modelos relacionados
- verificar os templates e forms afetados
- executar testes relacionados

## 10. Resumo funcional

O sistema comporta-se como um ERP modular, com foco em operação contábil/administrativa e fluxo de comércio. O código está mais orientado a telas e workflows do que a APIs REST bem isoladas.

Em outras palavras, o principal ponto de entrada do entendimento é sempre:
- settings
- urls
- app do domínio
- model/form/view correspondente
