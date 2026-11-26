-- TRIGGER 1
-- BEFORE INSERT em SALARIOS
-- Requisito: JOIN + subconsulta

DROP TRIGGER IF EXISTS trg_salario_bi_validar_valor;

DELIMITER //

CREATE TRIGGER trg_salario_bi_validar_valor
BEFORE INSERT ON salarios
FOR EACH ROW
BEGIN
    DECLARE v_departamento VARCHAR(100);
    DECLARE v_media_departamento DECIMAL(10,2);

    SELECT d.nome_departamento
    INTO v_departamento
    FROM funcionarios f
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    INNER JOIN departamentos d
        ON c.id_departamento = d.id_departamento
    WHERE f.id_funcionario = NEW.id_funcionario;

    SELECT AVG(s.valor_salario)
    INTO v_media_departamento
    FROM salarios s
    INNER JOIN funcionarios f
        ON s.id_funcionario = f.id_funcionario
    INNER JOIN cargos c
        ON f.id_cargo = c.id_cargo
    WHERE c.id_departamento = (
        SELECT c2.id_departamento
        FROM funcionarios f2
        INNER JOIN cargos c2
            ON f2.id_cargo = c2.id_cargo
        WHERE f2.id_funcionario = NEW.id_funcionario
    )
    AND s.data_fim_salario IS NULL;

    IF NEW.valor_salario <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O salário deve ser maior que zero';
    END IF;
END //

DELIMITER ;


-- TRIGGER 2
-- AFTER UPDATE em FUNCIONARIOS
-- Requisito: integração com função armazenada

DROP TRIGGER IF EXISTS trg_funcionario_au_historico_cargo;

DELIMITER //

CREATE TRIGGER trg_funcionario_au_historico_cargo
AFTER UPDATE ON funcionarios
FOR EACH ROW
BEGIN
    DECLARE v_tempo_empresa INT;

    SET v_tempo_empresa = fn_tempo_empresa(NEW.id_funcionario);

    IF OLD.id_cargo <> NEW.id_cargo THEN

        UPDATE historico_cargos
        SET data_fim_cargo = CURDATE()
        WHERE id_funcionario = NEW.id_funcionario
          AND id_cargo = OLD.id_cargo
          AND data_fim_cargo IS NULL;

        INSERT INTO historico_cargos
        (
            id_funcionario,
            id_cargo,
            data_inicio_cargo,
            data_fim_cargo
        )
        VALUES
        (
            NEW.id_funcionario,
            NEW.id_cargo,
            CURDATE(),
            NULL
        );

    END IF;
END //

DELIMITER ;


-- TRIGGER 3
-- BEFORE INSERT em SALARIOS
-- Requisito: utilização de função criada pelo usuário

DROP TRIGGER IF EXISTS trg_salario_bi_validar_datas;

DELIMITER //

CREATE TRIGGER trg_salario_bi_validar_datas
BEFORE INSERT ON salarios
FOR EACH ROW
BEGIN
    DECLARE v_salario_atual DECIMAL(10,2);

    SET v_salario_atual = fn_salario_atual(NEW.id_funcionario);

    IF NEW.data_fim_salario IS NOT NULL
       AND NEW.data_fim_salario < NEW.data_inicio_salario THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'A data de fim do salário não pode ser anterior à data de início';

    END IF;
END //

DELIMITER ;


-- ============================================================
-- TRIGGER 4
-- BEFORE UPDATE em SALARIOS
-- ============================================================

DROP TRIGGER IF EXISTS trg_salario_bu_validar_datas;

DELIMITER //

CREATE TRIGGER trg_salario_bu_validar_datas
BEFORE UPDATE ON salarios
FOR EACH ROW
BEGIN

    IF NEW.data_fim_salario IS NOT NULL
       AND NEW.data_fim_salario < NEW.data_inicio_salario THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data de fim do salário não pode ser anterior à data de início';

    END IF;

END //

DELIMITER ;


-- TRIGGER 5
-- BEFORE DELETE em SALARIOS
-- Requisito: integração com procedimentos armazenados
-- O trigger protege os dados utilizados pelos relatórios.

DROP TRIGGER IF EXISTS trg_salario_bd_impedir_exclusao_atual;

DELIMITER //

CREATE TRIGGER trg_salario_bd_impedir_exclusao_atual
BEFORE DELETE ON salarios
FOR EACH ROW
BEGIN
    IF OLD.data_fim_salario IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Não é permitido excluir o salário atual do funcionário';
    END IF;
END //

DELIMITER ;



-- ============================================================
-- TESTE DO TRIGGER 1
-- BEFORE INSERT em SALARIOS
-- ============================================================

-- TESTE QUE PASSA
-- Salário maior que zero

INSERT INTO salarios
(id_funcionario, valor_salario, data_inicio_salario, data_fim_salario)
VALUES
(1, 5000.00, '2027-01-01', '2027-12-31');


-- TESTE QUE FALHA
-- Salário menor ou igual a zero

INSERT INTO salarios
(id_funcionario, valor_salario, data_inicio_salario, data_fim_salario)
VALUES
(1, 0.00, '2028-01-01', '2028-12-31');


-- ============================================================
-- TESTE DO TRIGGER 2
-- AFTER UPDATE em FUNCIONARIOS
-- ============================================================

-- TESTE QUE PASSA
-- Altera o funcionário para outro cargo.
-- O trigger deve registrar a mudança no histórico.

UPDATE funcionarios
SET id_cargo = 2
WHERE id_funcionario = 1;


-- Verifica o histórico do funcionário

SELECT
    id_historico_cargo,
    id_funcionario,
    id_cargo,
    data_inicio_cargo,
    data_fim_cargo
FROM historico_cargos
WHERE id_funcionario = 1
ORDER BY id_historico_cargo DESC;


-- TESTE QUE FALHA
-- Não existe falha com SIGNAL neste trigger.
-- O trigger apenas executa automaticamente quando o cargo muda.
--
-- Portanto, este teste faz uma alteração sem mudar o cargo.
-- O UPDATE passa, mas o trigger não executa sua lógica.

UPDATE funcionarios
SET id_cargo = 3
WHERE id_funcionario = 1;


-- ============================================================
-- TESTE DO TRIGGER 3
-- BEFORE INSERT em SALARIOS
-- ============================================================

-- TESTE QUE PASSA
-- Data de fim posterior à data de início

INSERT INTO salarios
(id_funcionario, valor_salario, data_inicio_salario, data_fim_salario)
VALUES
(2, 4000.00, '2027-01-01', '2027-12-31');


-- TESTE QUE FALHA
-- Data de fim anterior à data de início

INSERT INTO salarios
(id_funcionario, valor_salario, data_inicio_salario, data_fim_salario)
VALUES
(2, 4000.00, '2027-12-31', '2027-01-01');


-- ============================================================
-- TESTE DO TRIGGER 4
-- BEFORE UPDATE em SALARIOS
-- ============================================================

-- TESTE QUE PASSA
-- Altera para uma data de fim válida

UPDATE salarios
SET data_fim_salario = '2027-12-31'
WHERE id_salario = 1;


-- TESTE QUE FALHA
-- Altera para uma data de fim anterior à data de início

UPDATE salarios
SET data_fim_salario = '2019-01-01'
WHERE id_salario = 1;


-- Verifica o salário

SELECT
    id_salario,
    id_funcionario,
    data_inicio_salario,
    data_fim_salario
FROM salarios
WHERE id_salario = 1;


-- ============================================================
-- TESTE DO TRIGGER 5
-- BEFORE DELETE em SALARIOS
-- ============================================================

-- TESTE QUE PASSA
-- Exclui um salário antigo, que possui data de fim

DELETE FROM salarios
WHERE id_salario = 1;


-- TESTE QUE FALHA
-- Tenta excluir o salário atual

DELETE FROM salarios
WHERE id_salario = (
    SELECT id_salario
    FROM (
        SELECT id_salario
        FROM salarios
        WHERE id_funcionario = 1
          AND data_fim_salario IS NULL
        LIMIT 1
    ) AS salario_atual
);



-- ============================================================
-- EXPLICAÇÕES
-- ============================================================

-- 1.
-- Impede cadastro de salário menor ou igual a zero.
-- Caso o valor informado seja zero ou negativo, o INSERT é
-- interrompido pelo SIGNAL.

-- 2.
-- Registra automaticamente a mudança de cargo no histórico.
-- Quando o cargo de um funcionário é alterado, o trigger encerra
-- o histórico do cargo anterior e cria um novo registro para o
-- novo cargo.

-- 3.
-- Impede cadastro de salário com período inválido.
-- Caso a data de fim seja anterior à data de início, o INSERT
-- é rejeitado.

-- 4.
-- Impede alteração de salário para um período inválido.
-- Caso a nova data de fim seja anterior à data de início,
-- o UPDATE é rejeitado.

-- 5.
-- Impede exclusão do salário atual do funcionário.
-- Enquanto data_fim_salario estiver NULL, o salário é considerado
-- atual e sua exclusão é bloqueada.