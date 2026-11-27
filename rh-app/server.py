#!/usr/bin/env python3
"""Aplicação web de RH conectada ao MySQL."""

import json
import os
import re
import sys
import mysql.connector

from datetime import date, datetime
from decimal import Decimal
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs, unquote


# ============================================================
# CONFIGURAÇÃO
# ============================================================

ROOT = os.path.dirname(os.path.abspath(__file__))

DB_CONFIG = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "aluno",
    "password": "aluno",
    "database": "seminario_bsi4"
}


# ============================================================
# LABELS
# ============================================================

LABELS = {
    "enderecos": (
        "CONCAT({a}.logradouro_endereco, ', ', "
        "{a}.numero_endereco, ' - ', {a}.bairro_endereco)"
    ),

    "contratos": (
        "CONCAT('Contrato #', {a}.id_contrato, ' · ', "
        "(SELECT nome_funcionario "
        " FROM funcionarios x "
        " WHERE x.id_funcionario = {a}.id_funcionario))"
    ),
}


# ============================================================
# CONEXÃO COM MYSQL
# ============================================================

def connect():
    return mysql.connector.connect(**DB_CONFIG)


# ============================================================
# CONVERSÃO PARA JSON
# ============================================================

def json_safe(value):
    """
    Converte tipos retornados pelo MySQL para tipos aceitos pelo JSON.
    """

    if isinstance(value, (datetime, date)):
        return value.isoformat()

    if isinstance(value, Decimal):
        return float(value)

    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")

    return value


def row_to_dict(row):
    return {
        key: json_safe(value)
        for key, value in row.items()
    }


def rows_to_dict(rows):
    return [row_to_dict(row) for row in rows]


# ============================================================
# SCHEMA
# ============================================================

def schema(con):
    """
    Descobre tabelas, colunas, PKs e FKs diretamente
    do banco MySQL.
    """

    out = {}

    cur = con.cursor(dictionary=True)

    # --------------------------------------------------------
    # TABELAS
    # --------------------------------------------------------

    cur.execute("""
        SELECT TABLE_NAME
        FROM information_schema.tables
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_TYPE = 'BASE TABLE'
        ORDER BY TABLE_NAME
    """)

    tables = [
        row["TABLE_NAME"]
        for row in cur.fetchall()
    ]

    for table in tables:

        # ----------------------------------------------------
        # COLUNAS
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                COLUMN_NAME,
                DATA_TYPE,
                IS_NULLABLE,
                COLUMN_KEY,
                EXTRA
            FROM information_schema.columns
            WHERE TABLE_SCHEMA = DATABASE()
              AND TABLE_NAME = %s
            ORDER BY ORDINAL_POSITION
        """, (table,))

        columns = cur.fetchall()

        # ----------------------------------------------------
        # FOREIGN KEYS
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                COLUMN_NAME,
                REFERENCED_TABLE_NAME,
                REFERENCED_COLUMN_NAME
            FROM information_schema.KEY_COLUMN_USAGE
            WHERE TABLE_SCHEMA = DATABASE()
              AND TABLE_NAME = %s
              AND REFERENCED_TABLE_NAME IS NOT NULL
        """, (table,))

        fk_rows = cur.fetchall()

        fks = {
            row["COLUMN_NAME"]: {
                "table": row["REFERENCED_TABLE_NAME"],
                "col": row["REFERENCED_COLUMN_NAME"]
            }
            for row in fk_rows
        }

        cols = []

        for column in columns:

            cols.append({
                "name": column["COLUMN_NAME"],
                "type": column["DATA_TYPE"].upper(),
                "notnull": column["IS_NULLABLE"] == "NO",
                "pk": 1 if column["COLUMN_KEY"] == "PRI" else 0,
                "fk": fks.get(column["COLUMN_NAME"]),
                "extra": column["EXTRA"]
            })

        pk = [
            column["name"]
            for column in cols
            if column["pk"]
        ]

        auto = (
            len(pk) == 1
            and any(
                column["name"] == pk[0]
                and "auto_increment" in column["extra"].lower()
                for column in cols
            )
        )

        out[table] = {
            "cols": cols,
            "pk": pk,
            "auto": auto
        }

    cur.close()

    return out


# ============================================================
# EXPRESSÃO DE LABEL
# ============================================================

def label_expr(sc, table, alias):
    """
    Define como um registro será apresentado quando
    uma FK precisar ser exibida na interface.
    """

    if table in LABELS:
        return LABELS[table].format(a=alias)

    name_column = next(
        (
            column["name"]
            for column in sc[table]["cols"]
            if column["name"].startswith("nome_")
        ),
        sc[table]["pk"][0]
    )

    return f"{alias}.{name_column}"


# ============================================================
# RELATÓRIOS
# ============================================================

def reports():
    path = os.path.join(ROOT, "db", "consultas.sql")

    if not os.path.exists(path):
        return []

    txt = open(
        path,
        encoding="utf-8"
    ).read()

    pattern = re.compile(
        r"/\*\s*-{3,}\s*\n"
        r"\s*(\d)\.(\d)\s+—\s+([\s\S]*?)"
        r"-{3,}\s*\*/\s*([\s\S]*?;)"
    )

    result = []

    for match in pattern.finditer(txt):

        if match.group(1) not in "13":
            continue

        title = re.sub(
            r"\s+",
            " ",
            match.group(3)
        ).strip()

        result.append({
            "id": f"{match.group(1)}.{match.group(2)}",
            "title": title,
            "group": (
                "Subconsultas e joins"
                if match.group(1) == "1"
                else "Subconsultas com functions"
            ),
            "sql": match.group(4)
        })

    return result


# ============================================================
# ERROS
# ============================================================

def friendly(error):

    message = str(error)

    if "FOREIGN KEY" in message:
        return (
            "Este registro está vinculado a outros "
            "e não pode ser alterado ou excluído."
        )

    if "Duplicate entry" in message:
        return (
            "Já existe um registro com este valor."
        )

    if "cannot be null" in message.lower():
        return (
            "Preencha todos os campos obrigatórios."
        )

    if "Data truncated" in message:
        return (
            "O valor informado possui formato inválido."
        )

    return message


# ============================================================
# CONVERSÃO DE PARÂMETROS
# ============================================================

def convert_sql_params(sql):
    """
    Converte placeholders no formato SQLite (?) para
    placeholders aceitos pelo MySQL (%s).
    """

    return sql.replace("?", "%s")


# ============================================================
# HANDLER HTTP
# ============================================================

class H(BaseHTTPRequestHandler):

    def log_message(self, *args):
        pass

    # --------------------------------------------------------
    # RESPOSTA
    # --------------------------------------------------------

    def send(self, code, obj, ctype="application/json"):

        if isinstance(obj, bytes):
            body = obj
        else:
            body = json.dumps(
                obj,
                ensure_ascii=False
            ).encode("utf-8")

        self.send_response(code)

        self.send_header(
            "Content-Type",
            ctype + "; charset=utf-8"
        )

        self.send_header(
            "Content-Length",
            str(len(body))
        )

        self.end_headers()

        self.wfile.write(body)

    # --------------------------------------------------------
    # ROTEAMENTO
    # --------------------------------------------------------

    def route(self, method):

        parsed = urlparse(self.path)

        parts = [
            unquote(part)
            for part in parsed.path.strip("/").split("/")
        ]

        qs = parse_qs(parsed.query)

        # ----------------------------------------------------
        # INTERFACE WEB
        # ----------------------------------------------------

        if method == "GET" and (
            len(parts) == 0
            or parts[0] != "api"
        ):

            static_dir = os.path.join(ROOT, "static")

            # Procura automaticamente o arquivo HTML dentro
            # da pasta static.
            html_files = []

            if os.path.isdir(static_dir):

                for name in os.listdir(static_dir):

                    path = os.path.join(
                        static_dir,
                        name
                    )

                    if (
                        os.path.isfile(path)
                        and name.lower().endswith(".html")
                    ):
                        html_files.append(path)

            if html_files:

                index = sorted(html_files)[0]

                with open(index, "rb") as f:

                    return self.send(
                        200,
                        f.read(),
                        "text/html"
                    )

            return self.send(
                404,
                {
                    "error": "Nenhum arquivo HTML encontrado em /static",
                    "procurado_em": static_dir
                }
            )

        con = None

        try:

            con = connect()

            sc = schema(con)

            # ------------------------------------------------
            # SCHEMA
            # ------------------------------------------------

            if len(parts) > 1 and parts[1] == "schema":

                return self.send(
                    200,
                    sc
                )

            # ------------------------------------------------
            # RELATÓRIOS
            # ------------------------------------------------

            if len(parts) > 1 and parts[1] == "reports":

                rs = reports()

                if len(parts) == 2:

                    return self.send(
                        200,
                        [
                            {
                                key: report[key]
                                for key in (
                                    "id",
                                    "title",
                                    "group"
                                )
                            }
                            for report in rs
                        ]
                    )

                report = next(
                    (
                        report
                        for report in rs
                        if report["id"] == parts[2]
                    ),
                    None
                )

                if not report:

                    return self.send(
                        404,
                        {
                            "error": "Relatório não encontrado"
                        }
                    )

                cur = con.cursor()

                sql = convert_sql_params(
                    report["sql"]
                )

                cur.execute(sql)

                rows = cur.fetchall()

                columns = [
                    description[0]
                    for description in cur.description
                ]

                rows = [
                    [
                        json_safe(value)
                        for value in row
                    ]
                    for row in rows
                ]

                cur.close()

                return self.send(
                    200,
                    {
                        "columns": columns,
                        "rows": rows
                    }
                )

            # ------------------------------------------------
            # TABELA
            # ------------------------------------------------

            if len(parts) < 3:

                return self.send(
                    404,
                    {
                        "error": "Rota inválida"
                    }
                )

            table = parts[2]

            if table not in sc:

                return self.send(
                    404,
                    {
                        "error": "Tabela não encontrada"
                    }
                )

            table_schema = sc[table]

            # ------------------------------------------------
            # OPTIONS
            # ------------------------------------------------

            if parts[1] == "options":

                pk = table_schema["pk"][0]

                label = label_expr(
                    sc,
                    table,
                    "t"
                )

                sql = (
                    f"SELECT {pk} AS id, "
                    f"{label} AS label "
                    f"FROM {table} t "
                    f"ORDER BY label"
                )

                cur = con.cursor(
                    dictionary=True
                )

                cur.execute(sql)

                rows = rows_to_dict(
                    cur.fetchall()
                )

                cur.close()

                return self.send(
                    200,
                    rows
                )

            # ------------------------------------------------
            # CHAVE PRIMÁRIA
            # ------------------------------------------------

            pk = None

            pk_columns = table_schema["pk"]

            # O frontend pode enviar a chave primária de duas formas:
            #
            # ?pk={"id_funcionario":1}
            #
            # ou, para tabelas com uma única chave primária:
            #
            # ?id=1

            if "pk" in qs:

                pk = json.loads(
                    qs["pk"][0]
                )

            elif "id" in qs and len(pk_columns) == 1:

                pk = {
                    pk_columns[0]: qs["id"][0]
                }

            where = " AND ".join(
                f"{column}=%s"
                for column in pk_columns
            )

            pk_values = (
                [
                    pk[column]
                    for column in pk_columns
                ]
                if pk
                else []
            )

            # ------------------------------------------------
            # GET
            # ------------------------------------------------

            if method == "GET":

                extra = []

                for column in table_schema["cols"]:

                    if column["fk"]:

                        fk_table = column["fk"]["table"]
                        fk_col = column["fk"]["col"]
                        column_name = column["name"]

                        expression = label_expr(
                            sc,
                            fk_table,
                            "r"
                        )

                        extra.append(
                            f"""
                            (
                                SELECT {expression}
                                FROM {fk_table} r
                                WHERE r.{fk_col} = t.{column_name}
                            ) AS {column_name}__label
                            """
                        )

                extra_sql = ""

                if extra:
                    extra_sql = "," + ",".join(extra)

                sql = (
                    f"SELECT t.*{extra_sql} "
                    f"FROM {table} t"
                )

                args = []

                # --------------------------------------------
                # PESQUISA
                # --------------------------------------------

                if qs.get("q"):

                    searchable = []

                    for column in table_schema["cols"]:

                        data_type = column["type"]

                        if data_type in (
                            "VARCHAR",
                            "CHAR",
                            "TEXT",
                            "TINYTEXT",
                            "MEDIUMTEXT",
                            "LONGTEXT"
                        ):

                            searchable.append(
                                column["name"]
                            )

                    for column in table_schema["cols"]:

                        if column["fk"]:

                            searchable.append(
                                column["name"] + "__label"
                            )

                    searchable = list(
                        dict.fromkeys(
                            searchable
                        )
                    )

                    if searchable:

                        sql += " WHERE " + " OR ".join(
                            f"IFNULL({column}, '') LIKE %s"
                            for column in searchable
                        )

                        args = [
                            f"%{qs['q'][0]}%"
                            for _ in searchable
                        ]

                # --------------------------------------------
                # ORDENAÇÃO
                # --------------------------------------------

                order = ", ".join(
                    table_schema["pk"]
                )

                if table_schema["auto"]:

                    sql += f" ORDER BY {order} DESC"

                else:

                    sql += f" ORDER BY {order}"

                cur = con.cursor(
                    dictionary=True
                )

                cur.execute(
                    sql,
                    args
                )

                rows = rows_to_dict(
                    cur.fetchall()
                )

                cur.close()

                return self.send(
                    200,
                    rows
                )

            # ------------------------------------------------
            # RECEBER DADOS
            # ------------------------------------------------

            if method != "DELETE":

                length = int(
                    self.headers.get(
                        "Content-Length",
                        0
                    )
                )

                raw = self.rfile.read(
                    length
                )

                data = (
                    json.loads(raw)
                    if raw
                    else {}
                )

            else:

                data = {}

            # ------------------------------------------------
            # CAMPOS
            # ------------------------------------------------

            names = []

            for column in table_schema["cols"]:

                name = column["name"]

                if name not in data:
                    continue

                # Não permite que a aplicação altere
                # uma PK AUTO_INCREMENT.
                if (
                    table_schema["auto"]
                    and name in table_schema["pk"]
                ):
                    continue

                names.append(name)

            values = [
                None if data[name] == ""
                else data[name]
                for name in names
            ]

            cur = con.cursor()

            # ------------------------------------------------
            # INSERT
            # ------------------------------------------------

            if method == "POST":

                if not names:

                    return self.send(
                        400,
                        {
                            "error": "Nenhum campo informado."
                        }
                    )

                placeholders = ", ".join(
                    ["%s"] * len(names)
                )

                sql = (
                    f"INSERT INTO {table} "
                    f"({','.join(names)}) "
                    f"VALUES ({placeholders})"
                )

                cur.execute(
                    sql,
                    values
                )

            # ------------------------------------------------
            # UPDATE
            # ------------------------------------------------

            elif method == "PUT":

                if not pk:

                    return self.send(
                        400,
                        {
                            "error": "Chave primária não informada."
                        }
                    )

                if not names:

                    return self.send(
                        400,
                        {
                            "error": "Nenhum campo para atualizar."
                        }
                    )

                assignments = ", ".join(
                    f"{name}=%s"
                    for name in names
                )

                sql = (
                    f"UPDATE {table} "
                    f"SET {assignments} "
                    f"WHERE {where}"
                )

                cur.execute(
                    sql,
                    values + pk_values
                )

            # ------------------------------------------------
            # DELETE
            # ------------------------------------------------

            elif method == "DELETE":

                if not pk:

                    return self.send(
                        400,
                        {
                            "error": "Chave primária não informada."
                        }
                    )

                sql = (
                    f"DELETE FROM {table} "
                    f"WHERE {where}"
                )

                cur.execute(
                    sql,
                    pk_values
                )

            else:

                return self.send(
                    405,
                    {
                        "error": "Método não suportado."
                    }
                )

            # ------------------------------------------------
            # COMMIT
            # ------------------------------------------------

            con.commit()

            return self.send(
                200,
                {
                    "ok": True
                }
            )

        except mysql.connector.Error as error:

            if con:
                con.rollback()

            return self.send(
                400,
                {
                    "error": friendly(error)
                }
            )

        except (StopIteration, IndexError, KeyError):

            return self.send(
                404,
                {
                    "error": "Não encontrado"
                }
            )

        except Exception as error:

            if con:
                con.rollback()

            return self.send(
                500,
                {
                    "error": str(error)
                }
            )

        finally:

            if con:
                con.close()

    # --------------------------------------------------------
    # HTTP
    # --------------------------------------------------------

    def do_GET(self):
        self.route("GET")

    def do_POST(self):
        self.route("POST")

    def do_PUT(self):
        self.route("PUT")

    def do_DELETE(self):
        self.route("DELETE")


# ============================================================
# INICIALIZAÇÃO
# ============================================================

if __name__ == "__main__":

    port = int(
        os.environ.get(
            "PORT",
            8000
        )
    )

    # Testa a conexão antes de iniciar o servidor.
    try:

        con = connect()

        cur = con.cursor()

        cur.execute(
            "SELECT DATABASE()"
        )

        database = cur.fetchone()[0]

        cur.close()
        con.close()

        print(
            f"Conectado ao MySQL: {database}"
        )

    except mysql.connector.Error as error:

        print(
            "ERRO AO CONECTAR AO MYSQL:"
        )

        print(
            error
        )

        sys.exit(1)

    print(
        f"RH rodando em http://localhost:{port}"
    )

    ThreadingHTTPServer(
        ("0.0.0.0", port),
        H
    ).serve_forever()