#!/usr/bin/env python3
"""Aplicação web de RH — servidor sem dependências externas (Python 3.8+).
Converte os scripts MySQL em db/ para SQLite na primeira execução e expõe
uma API CRUD genérica (baseada no schema) + as consultas de db/consultas.sql."""
import json, os, re, sqlite3, sys
from datetime import date
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs, unquote

ROOT = os.path.dirname(os.path.abspath(__file__))
DB = os.path.join(ROOT, "rh.db")
LABELS = {  # expressão que identifica um registro quando ele é referenciado (a = alias)
    "enderecos": "{a}.logradouro_endereco||', '||{a}.numero_endereco||' - '||{a}.bairro_endereco",
    "contratos": "'Contrato #'||{a}.id_contrato||' · '||(SELECT nome_funcionario FROM funcionarios x WHERE x.id_funcionario={a}.id_funcionario)",
}

def build_db():
    con = sqlite3.connect(DB)
    ddl = open(os.path.join(ROOT, "db/create_tables.sql"), encoding="utf-8").read()
    ddl = ddl.replace("INT NOT NULL AUTO_INCREMENT PRIMARY KEY", "INTEGER PRIMARY KEY AUTOINCREMENT")
    ddl = ddl.replace("DECIMAL(10,2)", "REAL")  # evita divisão inteira do SQLite nas consultas
    con.executescript(ddl)
    con.executescript(open(os.path.join(ROOT, "db/inserts_new.sql"), encoding="utf-8").read())
    con.commit(); con.close()

def connect():
    con = sqlite3.connect(DB)
    con.row_factory = sqlite3.Row
    con.execute("PRAGMA foreign_keys=ON")
    one = lambda sql, *a: (con.execute(sql, a).fetchone() or [None])[0]
    def anos(i):
        d = one("SELECT MIN(data_admissao_contrato) FROM contratos WHERE id_funcionario=?", i)
        if not d: return 0
        a, t = date.fromisoformat(d), date.today()
        return t.year - a.year - ((t.month, t.day) < (a.month, a.day))
    f = con.create_function
    f("fn_salario_atual", 1, lambda i: one("SELECT valor_salario FROM salarios WHERE id_funcionario=? AND data_fim_salario IS NULL ORDER BY data_inicio_salario DESC LIMIT 1", i) or 0)
    f("fn_tempo_empresa", 1, anos)
    f("fn_qtd_dependentes", 1, lambda i: one("SELECT COUNT(*) FROM funcionario_dependente WHERE id_funcionario=?", i))
    f("fn_media_salarial_departamento", 1, lambda i: round(one("SELECT AVG(s.valor_salario) FROM cargos c JOIN funcionarios f ON f.id_cargo=c.id_cargo JOIN salarios s ON s.id_funcionario=f.id_funcionario WHERE c.id_departamento=? AND s.data_fim_salario IS NULL", i) or 0, 2))
    return con

def schema(con):
    out = {}
    for (t,) in con.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"):
        fks = {r["from"]: {"table": r["table"], "col": r["to"]} for r in con.execute(f"PRAGMA foreign_key_list({t})")}
        cols = [{"name": r["name"], "type": r["type"].upper(), "notnull": bool(r["notnull"]), "pk": r["pk"],
                 "fk": fks.get(r["name"])} for r in con.execute(f"PRAGMA table_info({t})")]
        pk = [c["name"] for c in sorted((c for c in cols if c["pk"]), key=lambda c: c["pk"])]
        auto = len(pk) == 1 and next(c for c in cols if c["name"] == pk[0])["type"] == "INTEGER"
        out[t] = {"cols": cols, "pk": pk, "auto": auto}
    return out

def label_expr(sc, t, a):
    if t in LABELS: return LABELS[t].format(a=a)
    c = next((c["name"] for c in sc[t]["cols"] if c["name"].startswith("nome_")), sc[t]["pk"][0])
    return f"{a}.{c}"

def reports():
    txt = open(os.path.join(ROOT, "db/consultas.sql"), encoding="utf-8").read()
    pat = re.compile(r"/\*\s*-{3,}\s*\n\s*(\d)\.(\d) — ([\s\S]*?)-{3,}\s*\*/\s*([\s\S]*?;)")
    res = []
    for m in pat.finditer(txt):
        if m.group(1) not in "13": continue
        title = re.sub(r"\s+", " ", m.group(3)).strip()
        res.append({"id": f"{m.group(1)}.{m.group(2)}", "title": title,
                    "group": "Subconsultas e joins" if m.group(1) == "1" else "Subconsultas com functions", "sql": m.group(4)})
    return res

def friendly(e):
    m = str(e)
    if "FOREIGN KEY" in m: return "Este registro está vinculado a outros e não pode ser alterado ou excluído."
    if "UNIQUE" in m: return "Já existe um registro com este valor: " + m.split(": ")[-1].split(".")[-1].replace("_", " ")
    if "NOT NULL" in m: return "Preencha o campo obrigatório: " + m.split(".")[-1].replace("_", " ")
    return m

class H(BaseHTTPRequestHandler):
    def log_message(self, *a): pass
    def send(self, code, obj, ctype="application/json"):
        body = obj if isinstance(obj, bytes) else json.dumps(obj, ensure_ascii=False).encode()
        self.send_response(code); self.send_header("Content-Type", ctype + "; charset=utf-8")
        self.send_header("Content-Length", str(len(body))); self.end_headers(); self.wfile.write(body)
    def route(self, method):
        u = urlparse(self.path); parts = [unquote(p) for p in u.path.strip("/").split("/")]; qs = parse_qs(u.query)
        if method == "GET" and parts[0] != "api":
            return self.send(200, open(os.path.join(ROOT, "static/index.html"), "rb").read(), "text/html")
        con = connect(); sc = schema(con)
        try:
            if parts[1] == "schema": return self.send(200, sc)
            if parts[1] == "reports":
                rs = reports()
                if len(parts) == 2: return self.send(200, [{k: r[k] for k in ("id", "title", "group")} for r in rs])
                r = next(r for r in rs if r["id"] == parts[2])
                cur = con.execute(r["sql"])
                return self.send(200, {"columns": [d[0] for d in cur.description], "rows": [list(x) for x in cur.fetchall()]})
            t = parts[2]
            if t not in sc: return self.send(404, {"error": "Tabela não encontrada"})
            s = sc[t]
            if parts[1] == "options":
                rows = con.execute(f"SELECT {s['pk'][0]} AS id, {label_expr(sc, t, 't')} AS label FROM {t} t ORDER BY label").fetchall()
                return self.send(200, [dict(r) for r in rows])
            pk = json.loads(qs["pk"][0]) if "pk" in qs else None
            where = " AND ".join(f"{c}=?" for c in s["pk"]); pkv = [pk[c] for c in s["pk"]] if pk else []
            if method == "GET":
                extra = "".join(f", (SELECT {label_expr(sc, c['fk']['table'], 'r')} FROM {c['fk']['table']} r WHERE r.{c['fk']['col']}=t.{c['name']}) AS {c['name']}__label"
                                for c in s["cols"] if c["fk"])
                sql = f"SELECT * FROM (SELECT t.*{extra} FROM {t} t)"; args = []
                if qs.get("q"):
                    cols = [c["name"] for c in s["cols"] if not c["pk"] and c["type"][:3] in ("VAR", "CHA") or c["name"].endswith("__label")]
                    cols += [c["name"] + "__label" for c in s["cols"] if c["fk"]]
                    sql += " WHERE " + " OR ".join(f"IFNULL({c},'') LIKE ?" for c in dict.fromkeys(cols)); args = [f"%{qs['q'][0]}%"] * len(set(cols))
                order = ", ".join(s["pk"])
                return self.send(200, [dict(r) for r in con.execute(sql + f" ORDER BY {order} DESC" if s["auto"] else sql + f" ORDER BY {order}", args)])
            data = json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}") if method != "DELETE" else {}
            names = [c["name"] for c in s["cols"] if c["name"] in data and not (s["auto"] and c["name"] in s["pk"])]
            vals = [None if data[n] == "" else data[n] for n in names]
            if method == "POST":
                cur = con.execute(f"INSERT INTO {t} ({','.join(names)}) VALUES ({','.join('?' * len(names))})", vals)
            elif method == "PUT":
                con.execute(f"UPDATE {t} SET {','.join(n + '=?' for n in names)} WHERE {where}", vals + pkv)
            else:
                con.execute(f"DELETE FROM {t} WHERE {where}", pkv)
            con.commit(); self.send(200, {"ok": True})
        except sqlite3.Error as e:
            con.rollback(); self.send(400, {"error": friendly(e)})
        except (StopIteration, IndexError, KeyError):
            self.send(404, {"error": "Não encontrado"})
        finally:
            con.close()
    do_GET = lambda s: s.route("GET"); do_POST = lambda s: s.route("POST")
    do_PUT = lambda s: s.route("PUT"); do_DELETE = lambda s: s.route("DELETE")

if __name__ == "__main__":
    if "--reset" in sys.argv and os.path.exists(DB): os.remove(DB)
    if not os.path.exists(DB): build_db(); print("Banco criado a partir de db/*.sql")
    port = int(os.environ.get("PORT", 8000))
    print(f"RH rodando em http://localhost:{port}")
    ThreadingHTTPServer(("0.0.0.0", port), H).serve_forever()
