-- ATRIBUIÇÕES
CREATE TABLE atribuicoes (
    id_atribuicao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_atribuicao VARCHAR(150) NOT NULL UNIQUE,
    descricao_atribuicao VARCHAR(255) NULL
);

-- DEPARTAMENTOS
CREATE TABLE departamentos (
    id_departamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL UNIQUE,
    descricao_departamento VARCHAR(200) NULL
);

-- ENDEREÇOS
CREATE TABLE enderecos (
    id_endereco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cep_endereco CHAR(9) NOT NULL,
    logradouro_endereco VARCHAR(200) NOT NULL,
    numero_endereco VARCHAR(10) NOT NULL,
    complemento_endereco VARCHAR(100) NULL,
    bairro_endereco VARCHAR(100) NOT NULL,
    cidade_endereco VARCHAR(100) NOT NULL,
    uf_endereco CHAR(2) NOT NULL
);

-- SITUAÇÕES
CREATE TABLE situacoes (
    id_situacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_situacao VARCHAR(50) NOT NULL UNIQUE,
    descricao_situacao VARCHAR(200) NULL
);

-- CARGOS
CREATE TABLE cargos (
    id_cargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(100) NOT NULL UNIQUE,
    descricao_cargo VARCHAR(200) NULL,
    id_departamento INT NOT NULL,

    CONSTRAINT fk_cargo_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
);

-- GRAU ESCOLARIDADE
CREATE TABLE graus_escolaridade (
    id_grau_escolaridade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_grau_escolaridade VARCHAR(100) NOT NULL UNIQUE,
    descricao_grau_escolaridade VARCHAR(200) NULL
);

-- ESTADO CIVIL
CREATE TABLE estados_civis (
    id_estado_civil INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_estado_civil VARCHAR(50) NOT NULL UNIQUE
);

-- CARGO ATRIBUIÇÃO
CREATE TABLE cargo_atribuicao (
    id_cargo INT NOT NULL,
    id_atribuicao INT NOT NULL,

    PRIMARY KEY (id_cargo, id_atribuicao),

    CONSTRAINT fk_cargo_atribuicao_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES cargos(id_cargo),

    CONSTRAINT fk_cargo_atribuicao_atribuicao
        FOREIGN KEY (id_atribuicao)
        REFERENCES atribuicoes(id_atribuicao)
);

-- FUNCIONÁRIOS
CREATE TABLE funcionarios (
    id_funcionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(255) NOT NULL,
    email_funcionario VARCHAR(255) NOT NULL UNIQUE,
    telefone_funcionario VARCHAR(20),
    cpf_funcionario CHAR(14) NOT NULL UNIQUE,
    status_funcionario BOOLEAN DEFAULT TRUE,

    id_estado_civil INT NOT NULL,
    id_situacao INT NOT NULL,
    id_endereco INT NOT NULL,
    id_cargo INT NOT NULL,
    id_grau_escolaridade INT NOT NULL,

    CONSTRAINT fk_funcionario_situacao
        FOREIGN KEY (id_situacao)
        REFERENCES situacoes(id_situacao),

    CONSTRAINT fk_funcionario_endereco
        FOREIGN KEY (id_endereco)
        REFERENCES enderecos(id_endereco),

    CONSTRAINT fk_funcionario_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES cargos(id_cargo),

    CONSTRAINT fk_funcionario_grau_escolaridade
        FOREIGN KEY (id_grau_escolaridade)
        REFERENCES graus_escolaridade(id_grau_escolaridade),

    CONSTRAINT fk_funcionario_estado_civil
        FOREIGN KEY (id_estado_civil)
        REFERENCES estados_civis(id_estado_civil)
);

-- BENEFÍCIOS
CREATE TABLE beneficios (
    id_beneficio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_beneficio VARCHAR(100) NOT NULL UNIQUE,
    descricao_beneficio VARCHAR(200) NULL,
    valor_padrao_beneficio DECIMAL(10,2) NOT NULL
);

-- CONTRATOS
CREATE TABLE contratos (
    id_contrato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    tipo_contrato VARCHAR(50) NOT NULL,
    data_admissao_contrato DATE NOT NULL,
    data_demissao_contrato DATE NULL,
    salario_contrato DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario)
);

-- CONTRATO BENEFÍCIO
CREATE TABLE contrato_beneficio (
    id_contrato INT NOT NULL,
    id_beneficio INT NOT NULL,
    valor_beneficio DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_contrato, id_beneficio),

    FOREIGN KEY (id_contrato)
        REFERENCES contratos(id_contrato),

    FOREIGN KEY (id_beneficio)
        REFERENCES beneficios(id_beneficio)
);

-- HISTÓRICO DE CARGOS
CREATE TABLE historico_cargos (
    id_historico_cargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_cargo INT NOT NULL,
    data_inicio_cargo DATE NOT NULL,
    data_fim_cargo DATE NULL,

    CONSTRAINT fk_historico_cargo_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario),

    CONSTRAINT fk_historico_cargo_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES cargos(id_cargo)
);

-- FÉRIAS
CREATE TABLE ferias (
    id_ferias INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data_inicio_ferias DATE NOT NULL,
    data_fim_ferias DATE NOT NULL,

    CONSTRAINT fk_ferias_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario)
);

-- SALÁRIOS
CREATE TABLE salarios (
    id_salario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    valor_salario DECIMAL(10,2) NOT NULL,
    data_inicio_salario DATE NOT NULL,
    data_fim_salario DATE NULL,

    FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario)
);

-- DEPENDENTES
CREATE TABLE dependentes (
    id_dependente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_dependente VARCHAR(255) NOT NULL,
    data_nascimento_dependente DATE NOT NULL,
    cpf_dependente CHAR(14) NOT NULL UNIQUE
);

-- FUNCIONÁRIO DEPENDENTE
CREATE TABLE funcionario_dependente (
    id_funcionario INT NOT NULL,
    id_dependente INT NOT NULL,
    grau_parentesco VARCHAR(50) NOT NULL,

    PRIMARY KEY (id_funcionario, id_dependente),

    CONSTRAINT fk_funcionario_dependente_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario),

    CONSTRAINT fk_funcionario_dependente_dependente
        FOREIGN KEY (id_dependente)
        REFERENCES dependentes(id_dependente)
);