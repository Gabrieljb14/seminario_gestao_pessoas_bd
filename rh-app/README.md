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

## Observações
- As stored procedures (parte 4) não foram portadas; as consultas equivalentes estão nas telas de cadastro.
- Para usar MySQL de verdade, troque a camada `connect()`/`schema()` em `server.py`.
