# Gestão de RH

Aplicação web para o banco do SEMINARIO_2 (RH), com visual inspirado no Senior X.

## Como rodar
Requer apenas Python 3.8+ (sem instalar pacotes):

    python3 server.py          # abre em http://localhost:8000
    python3 server.py --reset  # recria o banco a partir de db/*.sql

Na primeira execução o servidor converte `db/create_tables.sql` e `db/inserts_new.sql`
(MySQL) para um SQLite local (`rh.db`).

## O que tem
- CRUD completo das 17 tabelas, gerado a partir do schema (FKs viram listas de seleção).
- Painel lateral para criar/editar, exclusão com confirmação e mensagens de integridade.
- Tela "Consultas": as consultas 1.1–1.5 e 3.1–3.5 de `db/consultas.sql`, lidas do próprio arquivo.
  As functions MySQL (fn_*) foram recriadas como funções do SQLite em `server.py`.

## Triggers
As 5 triggers de `db/triggers_mysql.sql` (original MySQL) foram portadas para SQLite em `db/triggers.sql`
e são aplicadas a cada inicialização (o arquivo é idempotente). Qualquer insert/update/delete feito pela
aplicação passa por elas, e a mensagem de erro aparece na interface.

| Trigger | Evento | Regra |
|---|---|---|
| trg_salario_bi_validar_valor | BEFORE INSERT salarios | valor deve ser > 0 |
| trg_funcionario_au_historico_cargo | AFTER UPDATE funcionarios | troca de cargo fecha o histórico anterior e abre um novo |
| trg_salario_bi_validar_datas | BEFORE INSERT salarios | data fim não pode ser anterior ao início |
| trg_salario_bu_validar_datas | BEFORE UPDATE salarios | idem, na alteração |
| trg_salario_bd_impedir_exclusao_atual | BEFORE DELETE salarios | não exclui salário atual (sem data fim) |

## Observações
- As stored procedures (parte 4) não foram portadas; as consultas equivalentes estão nas telas de cadastro.
- Para usar MySQL de verdade, troque a camada `connect()`/`schema()` em `server.py`.
