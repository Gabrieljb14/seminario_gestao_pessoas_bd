
/* ============================================================
   PARTE 1 — CONSULTAS COM SUBCONSULTAS E JOINS
   ============================================================ */


/* ------------------------------------------------------------
   1.1 — Funcionários com salário acima da média da empresa
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    s.valor_salario AS salario
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
LEFT JOIN departamentos d
    ON c.id_departamento = d.id_departamento
INNER JOIN salarios s
    ON f.id_funcionario = s.id_funcionario
WHERE s.data_fim_salario IS NULL
  AND s.valor_salario > (
    SELECT AVG(s2.valor_salario)
    FROM salarios s2
    WHERE s2.data_fim_salario IS NULL
)
ORDER BY s.valor_salario DESC;


/* ------------------------------------------------------------
   1.2 — Funcionários com o maior salário do departamento
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    s.valor_salario AS salario
FROM salarios s
INNER JOIN funcionarios f
    ON s.id_funcionario = f.id_funcionario
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
LEFT JOIN departamentos d
    ON c.id_departamento = d.id_departamento
WHERE s.data_fim_salario IS NULL
  AND s.valor_salario = (
    SELECT MAX(s2.valor_salario)
    FROM salarios s2
    INNER JOIN funcionarios f2
        ON s2.id_funcionario = f2.id_funcionario
    INNER JOIN cargos c2
        ON f2.id_cargo = c2.id_cargo
    WHERE s2.data_fim_salario IS NULL
      AND c2.id_departamento = c.id_departamento
)
ORDER BY d.nome_departamento, s.valor_salario DESC;


/* ------------------------------------------------------------
   1.3 — Funcionários acima da média salarial do departamento
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    s.valor_salario AS salario
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
INNER JOIN departamentos d
    ON c.id_departamento = d.id_departamento
INNER JOIN salarios s
    ON f.id_funcionario = s.id_funcionario
WHERE s.data_fim_salario IS NULL
  AND s.valor_salario > (
    SELECT AVG(s2.valor_salario)
    FROM salarios s2
    INNER JOIN funcionarios f2
        ON s2.id_funcionario = f2.id_funcionario
    INNER JOIN cargos c2
        ON f2.id_cargo = c2.id_cargo
    WHERE s2.data_fim_salario IS NULL
      AND c2.id_departamento = c.id_departamento
)
ORDER BY d.nome_departamento, s.valor_salario DESC;


/* ------------------------------------------------------------
   1.4 — Departamentos com quantidade de funcionários
         acima da média
   ------------------------------------------------------------ */

SELECT
    d.nome_departamento AS departamento,
    COUNT(f.id_funcionario) AS quantidade_funcionarios
FROM departamentos d
LEFT JOIN cargos c
    ON d.id_departamento = c.id_departamento
LEFT JOIN funcionarios f
    ON c.id_cargo = f.id_cargo
GROUP BY d.id_departamento, d.nome_departamento
HAVING COUNT(f.id_funcionario) > (
    SELECT AVG(quantidade)
    FROM (
        SELECT
            d2.id_departamento,
            COUNT(f2.id_funcionario) AS quantidade
        FROM departamentos d2
        LEFT JOIN cargos c2
            ON d2.id_departamento = c2.id_departamento
        LEFT JOIN funcionarios f2
            ON c2.id_cargo = f2.id_cargo
        GROUP BY d2.id_departamento
    ) AS departamentos_media
)
ORDER BY quantidade_funcionarios DESC;


/* ------------------------------------------------------------
   1.5 — Funcionários com aumento salarial acima da média
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    s_anterior.valor_salario AS salario_anterior,
    s_atual.valor_salario AS salario_novo,
    ROUND(
        (
            (s_atual.valor_salario - s_anterior.valor_salario)
            / s_anterior.valor_salario
        ) * 100,
        2
    ) AS percentual_aumento
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
LEFT JOIN departamentos d
    ON c.id_departamento = d.id_departamento
INNER JOIN salarios s_atual
    ON f.id_funcionario = s_atual.id_funcionario
INNER JOIN salarios s_anterior
    ON f.id_funcionario = s_anterior.id_funcionario
WHERE s_atual.data_inicio_salario > s_anterior.data_inicio_salario
  AND s_atual.valor_salario > s_anterior.valor_salario
  AND (
      (
          (s_atual.valor_salario - s_anterior.valor_salario)
          / s_anterior.valor_salario
      ) * 100
  ) > (
      SELECT AVG(
          (
              (s2.valor_salario - s1.valor_salario)
              / s1.valor_salario
          ) * 100
      )
      FROM salarios s1
      INNER JOIN salarios s2
          ON s1.id_funcionario = s2.id_funcionario
      WHERE s2.data_inicio_salario > s1.data_inicio_salario
        AND s2.valor_salario > s1.valor_salario
  )
ORDER BY percentual_aumento DESC;





/* ============================================================
   PARTE 2 — CRIAÇÃO DAS FUNCTIONS
   ============================================================ */


/* ------------------------------------------------------------
   2.1 — Function: salário atual do funcionário
   ------------------------------------------------------------ */

DROP FUNCTION IF EXISTS fn_salario_atual;

DELIMITER //

CREATE FUNCTION fn_salario_atual(p_id_funcionario INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN

    DECLARE v_salario DECIMAL(10,2);

    SELECT s.valor_salario
    INTO v_salario
    FROM salarios s
    WHERE s.id_funcionario = p_id_funcionario
      AND s.data_fim_salario IS NULL
    ORDER BY s.data_inicio_salario DESC
    LIMIT 1;

    RETURN IFNULL(v_salario, 0);

END //

DELIMITER ;


/* ------------------------------------------------------------
   2.2 — Function: tempo de empresa
   ------------------------------------------------------------ */

DROP FUNCTION IF EXISTS fn_tempo_empresa;

DELIMITER //

CREATE FUNCTION fn_tempo_empresa(p_id_funcionario INT)
RETURNS INT
READS SQL DATA
BEGIN

    DECLARE v_anos INT;

    SELECT TIMESTAMPDIFF(
        YEAR,
        MIN(c.data_admissao_contrato),
        CURDATE()
    )
    INTO v_anos
    FROM contratos c
    WHERE c.id_funcionario = p_id_funcionario;

    RETURN IFNULL(v_anos, 0);

END //

DELIMITER ;


/* ------------------------------------------------------------
   2.3 — Function: quantidade de dependentes
   ------------------------------------------------------------ */

DROP FUNCTION IF EXISTS fn_qtd_dependentes;

DELIMITER //

CREATE FUNCTION fn_qtd_dependentes(p_id_funcionario INT)
RETURNS INT
READS SQL DATA
BEGIN

    DECLARE v_quantidade INT;

    SELECT COUNT(fd.id_dependente)
    INTO v_quantidade
    FROM funcionario_dependente fd
    WHERE fd.id_funcionario = p_id_funcionario;

    RETURN v_quantidade;

END //

DELIMITER ;


/* ------------------------------------------------------------
   2.4 — Function: média salarial do departamento
   ------------------------------------------------------------ */

DROP FUNCTION IF EXISTS fn_media_salarial_departamento;

DELIMITER //

CREATE FUNCTION fn_media_salarial_departamento(
    p_id_departamento INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN

    DECLARE v_media DECIMAL(10,2);

    SELECT ROUND(AVG(s.valor_salario), 2)
    INTO v_media
    FROM departamentos d
    INNER JOIN cargos c
        ON d.id_departamento = c.id_departamento
    INNER JOIN funcionarios f
        ON c.id_cargo = f.id_cargo
    INNER JOIN salarios s
        ON f.id_funcionario = s.id_funcionario
    WHERE d.id_departamento = p_id_departamento
      AND s.data_fim_salario IS NULL;

    RETURN IFNULL(v_media, 0);

END //

DELIMITER ;


/* ------------------------------------------------------------
   2.5 — Function: endereço completo do funcionário
   ------------------------------------------------------------ */

DROP FUNCTION IF EXISTS fn_endereco_funcionario;

DELIMITER //

CREATE FUNCTION fn_endereco_funcionario(
    p_id_funcionario INT
)
RETURNS VARCHAR(500)
READS SQL DATA
BEGIN

    DECLARE v_endereco VARCHAR(500);

    SELECT CONCAT(
        e.logradouro_endereco,
        ', ',
        e.numero_endereco,
        ' - ',
        e.bairro_endereco,
        ', ',
        e.cidade_endereco,
        ' - ',
        e.uf_endereco,
        ' - CEP: ',
        e.cep_endereco
    )
    INTO v_endereco
    FROM enderecos e
    INNER JOIN funcionarios f
        ON f.id_endereco = e.id_endereco
    WHERE f.id_funcionario = p_id_funcionario;

    RETURN v_endereco;

END //

DELIMITER ;



/* ============================================================
   PARTE 3 — CONSULTAS COM SUBCONSULTAS UTILIZANDO FUNCTIONS
   ============================================================ */


/* ------------------------------------------------------------
   3.1 — Funcionários acima da média salarial
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    fn_salario_atual(f.id_funcionario) AS salario
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
LEFT JOIN departamentos d
    ON c.id_departamento = d.id_departamento
WHERE fn_salario_atual(f.id_funcionario) > (
    SELECT AVG(fn_salario_atual(id_funcionario))
    FROM funcionarios
)
ORDER BY salario DESC;


/* ------------------------------------------------------------
   3.2 — Funcionários acima da média salarial do departamento
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    fn_salario_atual(f.id_funcionario) AS salario,
    fn_media_salarial_departamento(
        d.id_departamento
    ) AS media_departamento
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
INNER JOIN departamentos d
    ON c.id_departamento = d.id_departamento
WHERE fn_salario_atual(f.id_funcionario) >
      fn_media_salarial_departamento(d.id_departamento)
ORDER BY d.nome_departamento, salario DESC;


/* ------------------------------------------------------------
   3.3 — Funcionários com tempo de empresa acima da média
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    fn_tempo_empresa(f.id_funcionario) AS anos_empresa
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
INNER JOIN departamentos d
    ON c.id_departamento = d.id_departamento
WHERE fn_tempo_empresa(f.id_funcionario) > (
    SELECT AVG(fn_tempo_empresa(id_funcionario))
    FROM funcionarios
)
ORDER BY anos_empresa DESC;


/* ------------------------------------------------------------
   3.4 — Funcionários com maior quantidade de dependentes
   ------------------------------------------------------------ */

SELECT
    f.nome_funcionario AS funcionario,
    c.nome_cargo AS cargo,
    d.nome_departamento AS departamento,
    fn_qtd_dependentes(
        f.id_funcionario
    ) AS quantidade_dependentes
FROM funcionarios f
INNER JOIN cargos c
    ON f.id_cargo = c.id_cargo
INNER JOIN departamentos d
    ON c.id_departamento = d.id_departamento
WHERE fn_qtd_dependentes(f.id_funcionario) = (
    SELECT MAX(fn_qtd_dependentes(id_funcionario))
    FROM funcionarios
)
ORDER BY funcionario;


/* ------------------------------------------------------------
   3.5 — Departamentos com média salarial acima da média geral
   ------------------------------------------------------------ */

SELECT
    d.nome_departamento AS departamento,
    fn_media_salarial_departamento(
        d.id_departamento
    ) AS media_departamento
FROM departamentos d
WHERE fn_media_salarial_departamento(d.id_departamento) > (
    SELECT AVG(fn_salario_atual(id_funcionario))
    FROM funcionarios
    WHERE fn_salario_atual(id_funcionario) > 0
)
ORDER BY media_departamento DESC;




/* ============================================================
   PARTE 4 — CRIAÇÃO DAS STORED PROCEDURES
   Objetivo: armazenar consultas reutilizáveis para gerar
   relatórios de funcionários, salários, departamentos
   e dependentes.
   ============================================================ */



/* ============================================================
   PARTE 4 — CRIAÇÃO DAS STORED PROCEDURES
   ============================================================ */


/* ------------------------------------------------------------
   4.1 — Listar funcionários com cargo e departamento
   ------------------------------------------------------------ */

DROP PROCEDURE IF EXISTS sp_listar_funcionarios;

DELIMITER //

CREATE PROCEDURE sp_listar_funcionarios()
BEGIN

    SELECT
        f.id_funcionario AS id,
        f.nome_funcionario AS funcionario,
        f.email_funcionario AS email,
        f.telefone_funcionario AS telefone,
        c.nome_cargo AS cargo,
        d.nome_departamento AS departamento,
        s.nome_situacao AS situacao,
        g.nome_grau_escolaridade AS escolaridade
    FROM funcionarios f
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    LEFT JOIN departamentos d
        ON c.id_departamento = d.id_departamento
    INNER JOIN situacoes s
        ON f.id_situacao = s.id_situacao
    INNER JOIN graus_escolaridade g
        ON f.id_grau_escolaridade = g.id_grau_escolaridade
    ORDER BY d.nome_departamento, f.nome_funcionario;

END //

DELIMITER ;


/* ------------------------------------------------------------
   4.2 — Relatório salarial dos funcionários
   ------------------------------------------------------------ */

DROP PROCEDURE IF EXISTS sp_relatorio_salarial;

DELIMITER //

CREATE PROCEDURE sp_relatorio_salarial()
BEGIN

    SELECT
        f.nome_funcionario AS funcionario,
        c.nome_cargo AS cargo,
        d.nome_departamento AS departamento,
        fn_salario_atual(f.id_funcionario) AS salario,
        ROUND(
            fn_salario_atual(f.id_funcionario) /
            (
                SELECT AVG(s.valor_salario)
                FROM salarios s
                WHERE s.data_fim_salario IS NULL
            ) * 100,
            2
        ) AS percentual_da_media
    FROM funcionarios f
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    LEFT JOIN departamentos d
        ON c.id_departamento = d.id_departamento
    ORDER BY salario DESC;

END //

DELIMITER ;


/* ------------------------------------------------------------
   4.3 — Relatório completo de um funcionário
   ------------------------------------------------------------ */

DROP PROCEDURE IF EXISTS sp_relatorio_funcionario;

DELIMITER //

CREATE PROCEDURE sp_relatorio_funcionario(
    IN p_id_funcionario INT
)
BEGIN

    SELECT
        f.id_funcionario AS id,
        f.nome_funcionario AS funcionario,
        f.email_funcionario AS email,
        f.telefone_funcionario AS telefone,
        c.nome_cargo AS cargo,
        d.nome_departamento AS departamento,
        s.nome_situacao AS situacao,
        ec.nome_estado_civil AS estado_civil,
        g.nome_grau_escolaridade AS escolaridade,
        fn_salario_atual(f.id_funcionario) AS salario_atual,
        fn_tempo_empresa(f.id_funcionario) AS anos_empresa,
        fn_qtd_dependentes(f.id_funcionario) AS quantidade_dependentes,
        fn_endereco_funcionario(f.id_funcionario) AS endereco
    FROM funcionarios f
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    LEFT JOIN departamentos d
        ON c.id_departamento = d.id_departamento
    INNER JOIN situacoes s
        ON f.id_situacao = s.id_situacao
    INNER JOIN estados_civis ec
        ON f.id_estado_civil = ec.id_estado_civil
    INNER JOIN graus_escolaridade g
        ON f.id_grau_escolaridade = g.id_grau_escolaridade
    WHERE f.id_funcionario = p_id_funcionario;

END //

DELIMITER ;


/* ------------------------------------------------------------
   4.4 — Relatório de um departamento
   ------------------------------------------------------------ */

DROP PROCEDURE IF EXISTS sp_relatorio_departamento;

DELIMITER //

CREATE PROCEDURE sp_relatorio_departamento(
    IN p_id_departamento INT
)
BEGIN

    SELECT
        d.nome_departamento AS departamento,
        COUNT(DISTINCT f.id_funcionario) AS quantidade_funcionarios,
        ROUND(AVG(s.valor_salario), 2) AS salario_medio,
        MIN(s.valor_salario) AS menor_salario,
        MAX(s.valor_salario) AS maior_salario,
        fn_media_salarial_departamento(
            d.id_departamento
        ) AS media_function
    FROM departamentos d
    LEFT JOIN cargos c
        ON d.id_departamento = c.id_departamento
    LEFT JOIN funcionarios f
        ON c.id_cargo = f.id_cargo
    LEFT JOIN salarios s
        ON f.id_funcionario = s.id_funcionario
       AND s.data_fim_salario IS NULL
    WHERE d.id_departamento = p_id_departamento
    GROUP BY d.id_departamento, d.nome_departamento;

END //

DELIMITER ;


/* ------------------------------------------------------------
   4.5 — Relatório de dependentes dos funcionários
   ------------------------------------------------------------ */

DROP PROCEDURE IF EXISTS sp_relatorio_dependentes;

DELIMITER //

CREATE PROCEDURE sp_relatorio_dependentes()
BEGIN

    SELECT
        f.nome_funcionario AS funcionario,
        c.nome_cargo AS cargo,
        d.nome_departamento AS departamento,
        COUNT(dep.id_dependente) AS quantidade_dependentes,
        fn_qtd_dependentes(
            f.id_funcionario
        ) AS quantidade_function
    FROM funcionarios f
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    LEFT JOIN departamentos d
        ON c.id_departamento = d.id_departamento
    INNER JOIN funcionario_dependente fd
        ON f.id_funcionario = fd.id_funcionario
    INNER JOIN dependentes dep
        ON fd.id_dependente = dep.id_dependente
    GROUP BY
        f.id_funcionario,
        f.nome_funcionario,
        c.nome_cargo,
        d.nome_departamento
    HAVING COUNT(dep.id_dependente) > 0
    ORDER BY quantidade_dependentes DESC, funcionario;

END //

DELIMITER ;




/* ============================================================
   PARTE 5 — TESTES DAS FUNCTIONS
   Objetivo: chamar cada Function individualmente para
   verificar o valor retornado.
   ============================================================ */



/* ============================================================
   PARTE 5 — TESTES DAS FUNCTIONS
   ============================================================ */

/* 5.1 — Testar salário atual */

SELECT fn_salario_atual(1);


/* 5.2 — Testar tempo de empresa */

SELECT fn_tempo_empresa(1);


/* 5.3 — Testar quantidade de dependentes */

SELECT fn_qtd_dependentes(2);


/* 5.4 — Testar média salarial do departamento */

SELECT fn_media_salarial_departamento(1);


/* 5.5 — Testar endereço do funcionário */

SELECT fn_endereco_funcionario(1);




/* ============================================================
   PARTE 6 — TESTES DAS STORED PROCEDURES
   Objetivo: executar os procedimentos e exibir seus relatórios.
   ============================================================ */



/* ============================================================
   PARTE 6 — TESTES DAS STORED PROCEDURES
   ============================================================ */


/* 6.1 — Testar listagem de funcionários */

CALL sp_listar_funcionarios();


/* 6.2 — Testar relatório salarial */

CALL sp_relatorio_salarial();


/* 6.3 — Testar relatório de um funcionário */

CALL sp_relatorio_funcionario(2);


/* 6.4 — Testar relatório de um departamento */

CALL sp_relatorio_departamento(1);


/* 6.5 — Testar relatório de dependentes */

CALL sp_relatorio_dependentes();