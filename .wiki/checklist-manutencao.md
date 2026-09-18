# Checklist de manutenção

## Antes de editar

- [ ] Confirmar o app e o domínio envolvidos
- [ ] Revisar [djangosige/urls.py](../djangosige/urls.py)
- [ ] Ler a URL do módulo
- [ ] Verificar model e form relacionados
- [ ] Identificar templates impactados
- [ ] Checar se há testes existentes

## Durante a edição

- [ ] Manter compatibilidade com padrões Django do projeto
- [ ] Preferir alteração pequena e local
- [ ] Não quebrar fluxo de autenticação
- [ ] Não ignorar regras de permissões
- [ ] Respeitar nomenclatura e convenções do módulo

## Após a edição

- [ ] Rodar testes relevantes
- [ ] Validar a operação no navegador, quando aplicável
- [ ] Revisar impacto em telas dependentes
- [ ] Verificar se as URLs continuam funcionando com reverse_lazy
- [ ] Atualizar esta wiki se as convenções mudarem

## Sinais de alerta

- código duplicado em vários apps
- view com lógica de negócio espalhada sem form/model claro
- routes sem documentação ou sem suporte de permissão
- templates sem um view ou model claro de origem

## Boas práticas de manutenção

- leia primeiro o contexto do domínio antes de alterar
- teste o comportamento real em vez de apenas inferir
- documente mudanças de fluxo e regras de negócio
- mantenha a organização funcional por app
