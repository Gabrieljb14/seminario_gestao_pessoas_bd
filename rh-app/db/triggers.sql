-- Triggers da aplicação (versão SQLite).
-- O original em MySQL está em db/triggers_mysql.sql. Mudanças da portagem:
--   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT  ->  SELECT RAISE(ABORT, 'mensagem')
--   DECLARE/SET de variáveis não existe no SQLite; os valores que o original
--   calculava e não usava (departamento, média, fn_salario_atual, fn_tempo_empresa)
--   foram omitidos, sem mudar o comportamento.
-- Este arquivo é idempotente: o servidor o executa a cada inicialização.

-- TRIGGER 1: BEFORE INSERT em salarios - valor deve ser maior que zero
DROP TRIGGER IF EXISTS trg_salario_bi_validar_valor;
CREATE TRIGGER trg_salario_bi_validar_valor
BEFORE INSERT ON salarios
FOR EACH ROW
WHEN NEW.valor_salario <= 0
BEGIN
    SELECT RAISE(ABORT, 'O salário deve ser maior que zero');
END;

-- TRIGGER 2: AFTER UPDATE em funcionarios - registra troca de cargo no histórico
DROP TRIGGER IF EXISTS trg_funcionario_au_historico_cargo;
CREATE TRIGGER trg_funcionario_au_historico_cargo
AFTER UPDATE OF id_cargo ON funcionarios
FOR EACH ROW
WHEN OLD.id_cargo <> NEW.id_cargo
BEGIN
    UPDATE historico_cargos
       SET data_fim_cargo = date('now','localtime')
     WHERE id_funcionario = NEW.id_funcionario
       AND id_cargo = OLD.id_cargo
       AND data_fim_cargo IS NULL;

    INSERT INTO historico_cargos (id_funcionario, id_cargo, data_inicio_cargo, data_fim_cargo)
    VALUES (NEW.id_funcionario, NEW.id_cargo, date('now','localtime'), NULL);
END;

-- TRIGGER 3: BEFORE INSERT em salarios - data fim não pode ser anterior ao início
DROP TRIGGER IF EXISTS trg_salario_bi_validar_datas;
CREATE TRIGGER trg_salario_bi_validar_datas
BEFORE INSERT ON salarios
FOR EACH ROW
WHEN NEW.data_fim_salario IS NOT NULL AND NEW.data_fim_salario < NEW.data_inicio_salario
BEGIN
    SELECT RAISE(ABORT, 'A data de fim do salário não pode ser anterior à data de início');
END;

-- TRIGGER 4: BEFORE UPDATE em salarios - mesma regra de datas na alteração
DROP TRIGGER IF EXISTS trg_salario_bu_validar_datas;
CREATE TRIGGER trg_salario_bu_validar_datas
BEFORE UPDATE ON salarios
FOR EACH ROW
WHEN NEW.data_fim_salario IS NOT NULL AND NEW.data_fim_salario < NEW.data_inicio_salario
BEGIN
    SELECT RAISE(ABORT, 'A data de fim do salário não pode ser anterior à data de início');
END;

-- TRIGGER 5: BEFORE DELETE em salarios - não exclui o salário atual (sem data fim)
DROP TRIGGER IF EXISTS trg_salario_bd_impedir_exclusao_atual;
CREATE TRIGGER trg_salario_bd_impedir_exclusao_atual
BEFORE DELETE ON salarios
FOR EACH ROW
WHEN OLD.data_fim_salario IS NULL
BEGIN
    SELECT RAISE(ABORT, 'Não é permitido excluir o salário atual do funcionário');
END;
