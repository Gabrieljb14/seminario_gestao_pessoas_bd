-- =====================================================
-- INSERTS ATRIBUIÇÕES
-- =====================================================

INSERT INTO atribuicoes
(nome_atribuicao, descricao_atribuicao)
VALUES
('Gestão de Pessoas', 'Gestão e acompanhamento de colaboradores'),
('Recrutamento e Seleção', 'Processos de recrutamento e seleção'),
('Administração de Pessoal', 'Rotinas administrativas de pessoal'),
('Controle de Ponto', 'Controle da jornada de trabalho'),
('Folha de Pagamento', 'Processamento da folha de pagamento'),
('Gestão de Benefícios', 'Administração dos benefícios'),
('Treinamento e Desenvolvimento', 'Capacitação e desenvolvimento profissional'),
('Avaliação de Desempenho', 'Acompanhamento do desempenho'),
('Comunicação Interna', 'Comunicação entre colaboradores'),
('Gestão de Projetos', 'Planejamento e acompanhamento de projetos');


-- =====================================================
-- INSERTS DEPARTAMENTOS
-- =====================================================

INSERT INTO departamentos
(nome_departamento, descricao_departamento)
VALUES
('Recursos Humanos', 'Gestão de pessoas e recursos humanos'),
('Financeiro', 'Gestão financeira da empresa'),
('Contabilidade', 'Controle e registros contábeis'),
('Administrativo', 'Rotinas administrativas'),
('Compras', 'Aquisição de produtos e serviços'),
('Logística', 'Gestão de transporte e operações logísticas'),
('Produção', 'Operações de produção'),
('Tecnologia da Informação', 'Gestão de tecnologia e sistemas'),
('Marketing', 'Marketing e comunicação da empresa'),
('Comercial', 'Vendas e relacionamento com clientes');


-- =====================================================
-- INSERTS ENDEREÇOS
-- =====================================================

INSERT INTO enderecos
(cep_endereco, logradouro_endereco, numero_endereco,
complemento_endereco, bairro_endereco, cidade_endereco, uf_endereco)
VALUES
('88010-100', 'Rua Felipe Schmidt', '100', NULL, 'Centro', 'Florianópolis', 'SC'),
('88015-200', 'Rua Bocaiúva', '245', 'Apto 301', 'Centro', 'Florianópolis', 'SC'),
('88020-300', 'Avenida Mauro Ramos', '580', NULL, 'Centro', 'Florianópolis', 'SC'),
('88025-400', 'Rua Lauro Linhares', '1250', 'Sala 204', 'Trindade', 'Florianópolis', 'SC'),
('88030-500', 'Rua Madre Benvenuta', '870', NULL, 'Trindade', 'Florianópolis', 'SC'),
('88032-600', 'Rua João Pio Duarte Silva', '415', 'Casa 02', 'Córrego Grande', 'Florianópolis', 'SC'),
('88034-700', 'Avenida Pequeno Príncipe', '1450', NULL, 'Campeche', 'Florianópolis', 'SC'),
('88036-800', 'Rua Deputado Antônio Edu Vieira', '920', 'Bloco B', 'Pantanal', 'Florianópolis', 'SC'),
('88040-900', 'Rua Geral do Itacorubi', '730', NULL, 'Itacorubi', 'Florianópolis', 'SC'),
('88045-110', 'Rua das Gaivotas', '310', 'Apto 502', 'Ingleses', 'Florianópolis', 'SC'),
('88050-120', 'Rua Luiz Delfino', '455', NULL, 'Agronômica', 'Florianópolis', 'SC'),
('88055-130', 'Rua Henrique Veras do Nascimento', '680', 'Casa', 'Lagoa da Conceição', 'Florianópolis', 'SC'),
('88060-140', 'Rodovia João Gualberto Soares', '2150', NULL, 'Rio Vermelho', 'Florianópolis', 'SC'),
('88065-150', 'Rua Intendente Antônio Damasco', '390', 'Fundos', 'Santo Antônio de Lisboa', 'Florianópolis', 'SC'),
('88070-160', 'Rua Santos Saraiva', '1120', NULL, 'Estreito', 'Florianópolis', 'SC'),
('88075-170', 'Rua General Eurico Gaspar Dutra', '845', 'Apto 103', 'Estreito', 'Florianópolis', 'SC'),
('88080-180', 'Rua Coronel Pedro Demoro', '560', NULL, 'Coqueiros', 'Florianópolis', 'SC'),
('88085-190', 'Rua Desembargador Pedro Silva', '1320', 'Sala 05', 'Coqueiros', 'Florianópolis', 'SC'),
('88090-210', 'Rua João Meirelles', '275', NULL, 'Abraão', 'Florianópolis', 'SC'),
('88095-220', 'Rua Paschoal Apóstolo Pítsica', '960', 'Apto 701', 'Agronômica', 'Florianópolis', 'SC'),
('88100-230', 'Rua Antônio Maria Coelho', '180', NULL, 'Centro', 'São José', 'SC'),
('88105-240', 'Avenida Presidente Kennedy', '950', 'Sala 12', 'Campinas', 'São José', 'SC'),
('88110-250', 'Rua Gerôncio Thives', '640', NULL, 'Barreiros', 'São José', 'SC'),
('88115-260', 'Rua Domingos André Zanini', '325', 'Casa 01', 'Kobrasol', 'São José', 'SC'),
('88120-270', 'Avenida Leoberto Leal', '1180', NULL, 'Barreiros', 'São José', 'SC'),
('88125-280', 'Rua Koesa', '470', 'Apto 402', 'Kobrasol', 'São José', 'SC'),
('88130-290', 'Rua Vereador Arthur Mariano', '810', NULL, 'Forquilhinhas', 'São José', 'SC'),
('88135-310', 'Rua Adhemar da Silva', '255', 'Casa', 'Campinas', 'São José', 'SC'),
('88140-320', 'Rua João Grumiche', '590', NULL, 'Roçado', 'São José', 'SC'),
('88145-330', 'Rua Jair Hamms', '735', 'Sala 08', 'Kobrasol', 'São José', 'SC'),
('88301-340', 'Rua XV de Novembro', '125', NULL, 'Centro', 'Itajaí', 'SC'),
('88302-350', 'Avenida Sete de Setembro', '890', 'Apto 203', 'Centro', 'Itajaí', 'SC'),
('88303-360', 'Rua Brusque', '420', NULL, 'Centro', 'Itajaí', 'SC'),
('88304-370', 'Rua Indaial', '680', 'Casa', 'São João', 'Itajaí', 'SC'),
('88305-380', 'Avenida Ministro Victor Konder', '1550', NULL, 'Centro', 'Itajaí', 'SC'),
('88306-390', 'Rua Estefano José Vanolli', '315', 'Sala 03', 'São Vicente', 'Itajaí', 'SC'),
('88307-410', 'Rua Expedicionário Aleixo Maba', '540', NULL, 'São Vicente', 'Itajaí', 'SC'),
('88308-420', 'Rua José Pereira Liberato', '925', 'Apto 601', 'São Judas', 'Itajaí', 'SC'),
('88309-430', 'Rua Alberto Werner', '230', NULL, 'Vila Operária', 'Itajaí', 'SC'),
('88310-440', 'Rua José Eugênio Müller', '775', 'Casa 02', 'Fazenda', 'Itajaí', 'SC'),
('88200-450', 'Rua João Bauer', '155', NULL, 'Centro', 'Brusque', 'SC'),
('88201-460', 'Avenida Cônsul Carlos Renaux', '730', 'Sala 10', 'Centro', 'Brusque', 'SC'),
('88202-470', 'Rua Azambuja', '410', NULL, 'Azambuja', 'Brusque', 'SC'),
('88203-480', 'Rua Primeiro de Maio', '895', 'Apto 302', 'Primeiro de Maio', 'Brusque', 'SC'),
('88204-490', 'Rua Felipe Schmidt', '320', NULL, 'Centro', 'Brusque', 'SC'),
('88205-510', 'Rua Hercílio Luz', '645', 'Casa', 'Centro', 'Brusque', 'SC'),
('88206-520', 'Rua Augusto Bauer', '280', NULL, 'Jardim Maluche', 'Brusque', 'SC'),
('88207-530', 'Rua Sete de Setembro', '1105', 'Sala 04', 'Santa Terezinha', 'Brusque', 'SC'),
('88208-540', 'Rua Pedro Werner', '515', NULL, 'São Luiz', 'Brusque', 'SC'),
('88209-550', 'Rua Florianópolis', '360', 'Apto 204', 'Águas Claras', 'Brusque', 'SC');


-- =====================================================
-- INSERTS SITUAÇÕES
-- =====================================================

INSERT INTO situacoes
(nome_situacao, descricao_situacao)
VALUES
('Ativo', 'Funcionário ativo na empresa'),
('Inativo', 'Funcionário atualmente inativo'),
('Férias', 'Funcionário afastado por período de férias'),
('Afastado', 'Funcionário temporariamente afastado'),
('Licença Médica', 'Funcionário afastado por motivo médico'),
('Licença Maternidade', 'Funcionária afastada por licença maternidade'),
('Licença Paternidade', 'Funcionário afastado por licença paternidade'),
('Aviso Prévio', 'Funcionário cumprindo período de aviso prévio'),
('Suspenso', 'Funcionário temporariamente suspenso'),
('Desligado', 'Funcionário desligado da empresa');


-- =====================================================
-- INSERTS CARGOS
-- =====================================================

INSERT INTO cargos
(nome_cargo, descricao_cargo, id_departamento)
VALUES
('Analista de Recursos Humanos', 'Atuação em processos de recursos humanos', 1),
('Assistente de Recursos Humanos', 'Apoio às atividades de recursos humanos', 1),
('Coordenador de Recursos Humanos', 'Coordenação das atividades de recursos humanos', 1),
('Analista de Departamento Pessoal', 'Atuação nas rotinas de departamento pessoal', 1),
('Especialista em Treinamento', 'Responsável por treinamentos e desenvolvimento', 1),
('Analista Financeiro', 'Atuação em análises e controles financeiros', 2),
('Assistente Financeiro', 'Apoio às atividades financeiras', 2),
('Coordenador Financeiro', 'Coordenação das operações financeiras', 2),
('Analista de Contas a Pagar', 'Controle das contas e pagamentos', 2),
('Analista de Contas a Receber', 'Controle das contas e recebimentos', 2),
('Contador', 'Responsável pelas atividades contábeis', 3),
('Analista Contábil', 'Análise e execução de atividades contábeis', 3),
('Assistente Contábil', 'Apoio às atividades contábeis', 3),
('Coordenador Contábil', 'Coordenação do setor contábil', 3),
('Auxiliar Contábil', 'Auxílio nos processos contábeis', 3),
('Analista Administrativo', 'Atuação nas rotinas administrativas', 4),
('Assistente Administrativo', 'Apoio às atividades administrativas', 4),
('Coordenador Administrativo', 'Coordenação das atividades administrativas', 4),
('Secretário Administrativo', 'Suporte às atividades administrativas', 4),
('Auxiliar Administrativo', 'Auxílio nas rotinas administrativas', 4),
('Analista de Compras', 'Atuação nos processos de compras', 5),
('Comprador', 'Responsável pela aquisição de produtos e serviços', 5),
('Assistente de Compras', 'Apoio ao setor de compras', 5),
('Coordenador de Compras', 'Coordenação dos processos de compras', 5),
('Especialista em Suprimentos', 'Gestão estratégica de suprimentos', 5),
('Analista de Logística', 'Análise das operações logísticas', 6),
('Assistente de Logística', 'Apoio às operações logísticas', 6),
('Coordenador de Logística', 'Coordenação das operações logísticas', 6),
('Supervisor de Transporte', 'Supervisão das operações de transporte', 6),
('Auxiliar de Logística', 'Auxílio nas atividades logísticas', 6),
('Supervisor de Produção', 'Supervisão das atividades produtivas', 7),
('Analista de Produção', 'Análise dos processos produtivos', 7),
('Operador de Produção', 'Execução de atividades de produção', 7),
('Coordenador de Produção', 'Coordenação das operações produtivas', 7),
('Auxiliar de Produção', 'Auxílio nas atividades produtivas', 7),
('Analista de Sistemas', 'Análise e desenvolvimento de sistemas', 8),
('Desenvolvedor de Software', 'Desenvolvimento e manutenção de sistemas', 8),
('Analista de Suporte', 'Atendimento e suporte aos usuários', 8),
('Administrador de Banco de Dados', 'Administração dos bancos de dados', 8),
('Coordenador de Tecnologia', 'Coordenação das atividades de tecnologia', 8),
('Analista de Marketing', 'Planejamento e análise de ações de marketing', 9),
('Assistente de Marketing', 'Apoio às ações de marketing', 9),
('Coordenador de Marketing', 'Coordenação das atividades de marketing', 9),
('Analista de Mídias Sociais', 'Gestão e análise das redes sociais', 9),
('Designer Gráfico', 'Criação de materiais gráficos e visuais', 9),
('Analista Comercial', 'Análise e acompanhamento das atividades comerciais', 10),
('Vendedor', 'Atuação na venda de produtos e serviços', 10),
('Consultor Comercial', 'Consultoria e negociação comercial', 10),
('Coordenador Comercial', 'Coordenação da equipe comercial', 10),
('Assistente Comercial', 'Apoio às atividades comerciais', 10);


-- =====================================================
-- INSERTS GRAUS DE ESCOLARIDADE
-- =====================================================

INSERT INTO graus_escolaridade
(nome_grau_escolaridade, descricao_grau_escolaridade)
VALUES
('Ensino Fundamental Incompleto', 'Ensino fundamental ainda não concluído'),
('Ensino Fundamental Completo', 'Ensino fundamental concluído'),
('Ensino Médio Incompleto', 'Ensino médio ainda não concluído'),
('Ensino Médio Completo', 'Ensino médio concluído'),
('Ensino Técnico', 'Formação de nível técnico'),
('Ensino Superior Incompleto', 'Graduação ainda não concluída'),
('Ensino Superior Completo', 'Graduação concluída'),
('Pós-Graduação', 'Formação posterior à graduação');


-- =====================================================
-- INSERTS ESTADOS CIVIS
-- =====================================================

INSERT INTO estados_civis
(nome_estado_civil)
VALUES
('Solteiro'),
('Casado'),
('Divorciado'),
('Separado'),
('Viúvo'),
('União Estável'),
('Não Informado'),
('Outro');


-- =====================================================
-- INSERTS CARGO_ATRIBUIÇÃO
-- =====================================================

INSERT INTO cargo_atribuicao
(id_cargo, id_atribuicao)
VALUES
(1, 1),
(1, 2),
(1, 7),
(1, 8),
(1, 9),
(2, 1),
(2, 3),
(2, 4),
(2, 6),
(2, 9),
(3, 1),
(3, 7),
(3, 8),
(3, 10),
(3, 9),
(4, 1),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 7),
(5, 8),
(5, 10),
(5, 9),
(6, 10),
(6, 1),
(6, 8),
(6, 9),
(6, 7),
(7, 1),
(7, 3),
(7, 6),
(7, 9),
(7, 10),
(8, 10),
(8, 7),
(8, 8),
(8, 9),
(8, 1),
(9, 9),
(9, 10),
(9, 7),
(9, 8),
(9, 1),
(10, 10),
(10, 9),
(10, 8),
(10, 7),
(10, 1);


-- =====================================================
-- INSERTS FUNCIONÁRIOS
-- =====================================================

INSERT INTO funcionarios
(nome_funcionario, email_funcionario, telefone_funcionario,
cpf_funcionario, status_funcionario, id_estado_civil,
id_situacao, id_endereco, id_cargo, id_grau_escolaridade)
VALUES
('Ana Carolina Martins', 'ana.martins@empresa.com.br', '(48) 99101-1001', '529.384.710-01', TRUE, 1, 1, 1, 1, 7),
('Bruno Henrique Souza', 'bruno.souza@empresa.com.br', '(48) 99202-1002', '183.726.450-02', TRUE, 2, 1, 2, 2, 4),
('Carolina Mendes Rocha', 'carolina.rocha@empresa.com.br', '(48) 99303-1003', '746.291.830-03', TRUE, 1, 1, 3, 3, 8),
('Daniel Augusto Lima', 'daniel.lima@empresa.com.br', '(48) 99404-1004', '315.847.620-04', TRUE, 2, 1, 4, 4, 7),
('Eduardo Pereira Costa', 'eduardo.costa@empresa.com.br', '(48) 99505-1005', '628.153.970-05', TRUE, 6, 1, 5, 5, 6),
('Fernanda Alves Ribeiro', 'fernanda.ribeiro@empresa.com.br', '(47) 99106-1006', '294.675.810-06', TRUE, 1, 1, 6, 6, 7),
('Gabriel Martins Oliveira', 'gabriel.oliveira@empresa.com.br', '(47) 99207-1007', '851.430.260-07', TRUE, 2, 1, 7, 7, 4),
('Helena Cristina Santos', 'helena.santos@empresa.com.br', '(47) 99308-1008', '407.218.690-08', TRUE, 3, 1, 8, 8, 8),
('Igor Rodrigues Almeida', 'igor.almeida@empresa.com.br', '(47) 99409-1009', '732.564.180-09', TRUE, 1, 1, 9, 9, 7),
('Juliana Ferreira Nunes', 'juliana.nunes@empresa.com.br', '(47) 99510-1010', '165.893.420-10', TRUE, 2, 1, 10, 10, 7),
('Karla Beatriz Moreira', 'karla.moreira@empresa.com.br', '(47) 99611-1011', '583.741.290-11', TRUE, 6, 1, 11, 11, 8),
('Lucas Gabriel Freitas', 'lucas.freitas@empresa.com.br', '(47) 99712-1012', '219.638.750-12', TRUE, 1, 1, 12, 12, 7),
('Mariana Borges Cardoso', 'mariana.cardoso@empresa.com.br', '(47) 99813-1013', '674.205.930-13', TRUE, 2, 1, 13, 13, 4),
('Nicolas Eduardo Ramos', 'nicolas.ramos@empresa.com.br', '(47) 99914-1014', '341.879.520-14', TRUE, 1, 1, 14, 14, 8),
('Olivia Martins Teixeira', 'olivia.teixeira@empresa.com.br', '(47) 99115-1015', '795.316.840-15', TRUE, 3, 1, 15, 15, 7),
('Paulo Ricardo Gomes', 'paulo.gomes@empresa.com.br', '(47) 99216-1016', '428.750.610-16', TRUE, 2, 1, 16, 16, 7),
('Renata Cristina Lopes', 'renata.lopes@empresa.com.br', '(47) 99317-1017', '156.492.870-17', TRUE, 1, 1, 17, 17, 4),
('Samuel Antônio Dias', 'samuel.dias@empresa.com.br', '(47) 99418-1018', '863.217.540-18', TRUE, 2, 1, 17, 18, 7),
('Tatiane Souza Pinto', 'tatiane.pinto@empresa.com.br', '(47) 99519-1019', '275.634.980-19', TRUE, 6, 1, 18, 19, 8),
('Vinicius Rafael Castro', 'vinicius.castro@empresa.com.br', '(47) 99620-1020', '619.843.250-20', TRUE, 1, 1, 19, 20, 7),
('Amanda Vitória Silva', 'amanda.silva@empresa.com.br', '(47) 99721-1021', '384.561.720-21', TRUE, 1, 1, 20, 21, 7),
('Caio Henrique Batista', 'caio.batista@empresa.com.br', '(47) 99822-1022', '927.314.680-22', TRUE, 2, 1, 21, 22, 4),
('Débora Cristina Vieira', 'debora.vieira@empresa.com.br', '(47) 99923-1023', '518.762.430-23', TRUE, 3, 1, 22, 23, 6),
('Felipe Augusto Moura', 'felipe.moura@empresa.com.br', '(47) 99124-1024', '243.895.170-24', TRUE, 1, 1, 23, 24, 7),
('Gabriela Fernandes Reis', 'gabriela.reis@empresa.com.br', '(47) 99225-1025', '671.428.950-25', TRUE, 2, 1, 24, 25, 8),
('Henrique Matheus Barros', 'henrique.barros@empresa.com.br', '(47) 99326-1026', '835.216.740-26', TRUE, 6, 1, 25, 26, 7),
('Isabela Cristina Duarte', 'isabela.duarte@empresa.com.br', '(47) 99427-1027', '492.683.510-27', TRUE, 1, 1, 26, 27, 7),
('João Pedro Correia', 'joao.correia@empresa.com.br', '(47) 99528-1028', '157.940.860-28', TRUE, 2, 1, 26, 28, 4),
('Larissa Almeida Campos', 'larissa.campos@empresa.com.br', '(47) 99629-1029', '706.351.290-29', TRUE, 1, 1, 27, 29, 7),
('Marcelo Vinicius Farias', 'marcelo.farias@empresa.com.br', '(47) 99730-1030', '328.574.610-30', TRUE, 2, 1, 28, 30, 6),
('Natália Regina Lopes', 'natalia.lopes@empresa.com.br', '(47) 99831-1031', '564.217.830-31', TRUE, 1, 1, 29, 31, 7),
('Otávio Henrique Mendes', 'otavio.mendes@empresa.com.br', '(47) 99932-1032', '891.463.250-32', TRUE, 2, 1, 30, 32, 7),
('Patrícia Gomes da Silva', 'patricia.silva@empresa.com.br', '(47) 99133-1033', '236.785.940-33', TRUE, 3, 1, 31, 33, 4),
('Rafael Augusto Santos', 'rafael.santos@empresa.com.br', '(47) 99234-1034', '715.329.680-34', TRUE, 1, 1, 32, 34, 7),
('Sabrina Costa Ferreira', 'sabrina.ferreira@empresa.com.br', '(47) 99335-1035', '459.812.370-35', TRUE, 6, 1, 33, 35, 8),
('Thiago Rodrigues Melo', 'thiago.melo@empresa.com.br', '(47) 99436-1036', '682.147.530-36', TRUE, 2, 1, 34, 36, 7),
('Valéria Cristina Nascimento', 'valeria.nascimento@empresa.com.br', '(47) 99537-1037', '317.694.820-37', TRUE, 1, 1, 35, 37, 7),
('William Eduardo Martins', 'william.martins@empresa.com.br', '(47) 99638-1038', '843.251.760-38', TRUE, 2, 1, 36, 38, 8),
('Aline Gabriela Costa', 'aline.costa@empresa.com.br', '(47) 99739-1039', '521.876.430-39', TRUE, 1, 1, 37, 39, 7),
('Bernardo Luiz Carvalho', 'bernardo.carvalho@empresa.com.br', '(47) 99840-1040', '169.435.780-40', TRUE, 2, 1, 38, 40, 4),
('Cláudia Regina Martins', 'claudia.martins@empresa.com.br', '(41) 99941-1041', '734.218.650-41', TRUE, 3, 1, 41, 41, 7),
('Diego Henrique Souza', 'diego.souza@empresa.com.br', '(41) 99142-1042', '285.673.910-42', TRUE, 1, 1, 42, 42, 7),
('Elaine Cristina Rocha', 'elaine.rocha@empresa.com.br', '(41) 99243-1043', '916.324.570-43', TRUE, 2, 1, 43, 43, 8),
('Fábio Alexandre Lima', 'fabio.lima@empresa.com.br', '(41) 99344-1044', '453.791.280-44', TRUE, 6, 1, 44, 44, 7),
('Gisele Fernanda Ramos', 'gisele.ramos@empresa.com.br', '(41) 99445-1045', '627.158.430-45', TRUE, 1, 1, 45, 45, 7),
('Hugo Rafael Oliveira', 'hugo.oliveira@empresa.com.br', '(41) 99546-1046', '348.625.970-46', TRUE, 2, 1, 46, 46, 4),
('Ingrid Beatriz Santos', 'ingrid.santos@empresa.com.br', '(41) 99647-1047', '752.419.680-47', TRUE, 1, 1, 47, 47, 7),
('Jorge Luiz Pereira', 'jorge.pereira@empresa.com.br', '(41) 99748-1048', '194.836.520-48', TRUE, 2, 1, 48, 48, 7),
('Letícia Maria Alves', 'leticia.alves@empresa.com.br', '(41) 99849-1049', '865.271.340-49', TRUE, 1, 1, 49, 49, 8),
('Matheus Gabriel Ferreira', 'matheus.ferreira@empresa.com.br', '(41) 99950-1050', '536.948.710-50', TRUE, 6, 1, 50, 50, 7);


-- =====================================================
-- INSERTS BENEFÍCIOS
-- =====================================================

INSERT INTO beneficios
(nome_beneficio, descricao_beneficio, valor_padrao_beneficio)
VALUES
('Vale Transporte', 'Auxílio para deslocamento do funcionário', 220.00),
('Vale Alimentação', 'Auxílio alimentação mensal', 550.00),
('Vale Refeição', 'Benefício destinado às refeições durante o expediente', 480.00),
('Plano de Saúde', 'Assistência médica empresarial', 680.00),
('Plano Odontológico', 'Assistência odontológica empresarial', 95.00),
('Seguro de Vida', 'Seguro de vida corporativo', 45.00),
('Auxílio Creche', 'Auxílio destinado a despesas com creche', 350.00),
('Auxílio Educação', 'Auxílio para despesas educacionais', 250.00),
('Gympass', 'Benefício para academias e atividades físicas', 120.00),
('Auxílio Home Office', 'Auxílio para despesas relacionadas ao trabalho remoto', 150.00);


-- =====================================================
-- INSERTS CONTRATOS
-- =====================================================

INSERT INTO contratos
(id_funcionario, tipo_contrato, data_admissao_contrato,
data_demissao_contrato, salario_contrato)
VALUES
(1, 'CLT', '2020-02-10', NULL, 5200.00),
(2, 'CLT', '2021-03-15', NULL, 3850.00),
(3, 'CLT', '2019-07-01', NULL, 6800.00),
(4, 'CLT', '2022-01-17', NULL, 4200.00),
(5, 'CLT', '2023-05-08', NULL, 3500.00),
(6, 'CLT', '2020-09-14', NULL, 5900.00),
(7, 'CLT', '2022-06-20', NULL, 3200.00),
(8, 'CLT', '2018-11-05', NULL, 7200.00),
(9, 'CLT', '2021-08-23', NULL, 4800.00),
(10, 'CLT', '2023-02-13', NULL, 4500.00),
(11, 'CLT', '2019-04-22', NULL, 6100.00),
(12, 'CLT', '2020-10-19', NULL, 4700.00),
(13, 'CLT', '2022-03-07', NULL, 3400.00),
(14, 'CLT', '2018-06-11', NULL, 7600.00),
(15, 'CLT', '2021-12-06', NULL, 5100.00),
(16, 'CLT', '2020-01-20', NULL, 4400.00),
(17, 'CLT', '2022-08-15', NULL, 3000.00),
(18, 'CLT', '2023-01-09', NULL, 3900.00),
(19, 'CLT', '2019-09-02', NULL, 5300.00),
(20, 'CLT', '2021-05-17', NULL, 4600.00),
(21, 'CLT', '2020-07-13', NULL, 4900.00),
(22, 'CLT', '2022-02-21', NULL, 3300.00),
(23, 'CLT', '2021-10-04', NULL, 4100.00),
(24, 'CLT', '2019-03-18', NULL, 5700.00),
(25, 'CLT', '2023-04-10', NULL, 3600.00),
(26, 'CLT', '2020-05-25', NULL, 5500.00),
(27, 'CLT', '2021-06-14', NULL, 4300.00),
(28, 'CLT', '2018-08-27', NULL, 6700.00),
(29, 'CLT', '2022-09-19', NULL, 3500.00),
(30, 'CLT', '2020-11-09', NULL, 5800.00),
(31, 'CLT', '2021-01-11', NULL, 5100.00),
(32, 'CLT', '2022-05-16', NULL, 4500.00),
(33, 'CLT', '2019-10-21', NULL, 3700.00),
(34, 'CLT', '2020-03-30', NULL, 6200.00),
(35, 'CLT', '2023-06-05', NULL, 3400.00),
(36, 'CLT', '2018-12-03', NULL, 7100.00),
(37, 'CLT', '2021-07-26', NULL, 4800.00),
(38, 'CLT', '2022-10-10', NULL, 5200.00),
(39, 'CLT', '2020-04-06', NULL, 3900.00),
(40, 'CLT', '2019-05-27', NULL, 4600.00),
(41, 'CLT', '2021-02-08', NULL, 5000.00),
(42, 'CLT', '2022-07-18', NULL, 3600.00),
(43, 'CLT', '2018-09-17', NULL, 6400.00),
(44, 'CLT', '2020-06-22', NULL, 4700.00),
(45, 'CLT', '2023-03-13', NULL, 3500.00),
(46, 'CLT', '2019-11-04', NULL, 5900.00),
(47, 'CLT', '2021-04-12', NULL, 4300.00),
(48, 'CLT', '2022-11-21', NULL, 4100.00),
(49, 'CLT', '2020-08-03', NULL, 5200.00),
(50, 'CLT', '2023-07-17', NULL, 3700.00);


-- =====================================================
-- INSERTS CONTRATO_BENEFÍCIO
-- =====================================================

INSERT INTO contrato_beneficio
(id_contrato, id_beneficio, valor_beneficio)
VALUES
(1, 1, 220.00),
(2, 2, 550.00),
(3, 4, 680.00),
(4, 5, 95.00),
(5, 3, 480.00),
(6, 6, 45.00),
(7, 1, 220.00),
(8, 4, 680.00),
(9, 2, 550.00),
(10, 5, 95.00),
(11, 3, 480.00),
(12, 7, 350.00),
(13, 8, 250.00),
(14, 4, 680.00),
(15, 6, 45.00),
(16, 1, 220.00),
(17, 2, 550.00),
(18, 9, 120.00),
(19, 3, 480.00),
(20, 4, 680.00),
(21, 5, 95.00),
(22, 1, 220.00),
(23, 2, 550.00),
(24, 6, 45.00),
(25, 7, 350.00),
(26, 4, 680.00),
(27, 5, 95.00),
(28, 3, 480.00),
(29, 8, 250.00),
(30, 9, 120.00),
(31, 1, 220.00),
(32, 2, 550.00),
(33, 4, 680.00),
(34, 6, 45.00),
(35, 5, 95.00),
(36, 3, 480.00),
(37, 7, 350.00),
(38, 4, 680.00),
(39, 8, 250.00),
(40, 9, 120.00),
(41, 1, 220.00),
(42, 2, 550.00),
(43, 4, 680.00),
(44, 6, 45.00),
(45, 5, 95.00),
(46, 3, 480.00),
(47, 7, 350.00),
(48, 4, 680.00),
(49, 8, 250.00),
(50, 9, 120.00);


-- =====================================================
-- INSERTS HISTÓRICO DE CARGOS
-- =====================================================

INSERT INTO historico_cargos
(id_funcionario, id_cargo, data_inicio_cargo, data_fim_cargo)
VALUES
(1, 2, '2018-02-01', '2020-02-09'),
(2, 4, '2019-03-01', '2021-03-14'),
(3, 2, '2017-06-01', '2019-06-30'),
(4, 5, '2020-01-10', '2022-01-16'),
(5, 4, '2021-05-03', '2023-05-07'),
(6, 7, '2018-09-01', '2020-09-13'),
(7, 9, '2020-06-01', '2022-06-19'),
(8, 7, '2016-11-01', '2018-11-04'),
(9, 10, '2019-08-01', '2021-08-22'),
(10, 8, '2021-02-01', '2023-02-12'),
(11, 12, '2017-04-01', '2019-04-21'),
(12, 13, '2018-10-01', '2020-10-18'),
(13, 15, '2020-03-01', '2022-03-06'),
(14, 13, '2016-06-01', '2018-06-10'),
(15, 14, '2019-12-01', '2021-12-05'),
(16, 17, '2018-01-01', '2020-01-19'),
(17, 18, '2020-08-01', '2022-08-14'),
(18, 20, '2021-01-01', '2023-01-08'),
(19, 18, '2017-09-01', '2019-09-01'),
(20, 17, '2019-05-01', '2021-05-16'),
(21, 22, '2018-07-01', '2020-07-12'),
(22, 24, '2020-02-01', '2022-02-20'),
(23, 25, '2019-10-01', '2021-10-03'),
(24, 23, '2017-03-01', '2019-03-17'),
(25, 21, '2021-04-01', '2023-04-09'),
(26, 27, '2018-05-01', '2020-05-24'),
(27, 29, '2019-06-01', '2021-06-13'),
(28, 30, '2016-08-01', '2018-08-26'),
(29, 28, '2020-09-01', '2022-09-18'),
(30, 26, '2018-11-01', '2020-11-08'),
(31, 32, '2019-01-01', '2021-01-10'),
(32, 34, '2020-05-01', '2022-05-15'),
(33, 35, '2017-10-01', '2019-10-20'),
(34, 31, '2018-03-01', '2020-03-29'),
(35, 33, '2021-06-01', '2023-06-04'),
(36, 37, '2017-12-01', '2018-12-02'),
(37, 39, '2019-07-01', '2021-07-25'),
(38, 40, '2020-10-01', '2022-10-09'),
(39, 36, '2018-04-01', '2020-04-05'),
(40, 38, '2017-05-01', '2019-05-26'),
(41, 42, '2019-02-01', '2021-02-07'),
(42, 44, '2020-07-01', '2022-07-17'),
(43, 45, '2016-09-01', '2018-09-16'),
(44, 41, '2018-06-01', '2020-06-21'),
(45, 43, '2021-03-01', '2023-03-12'),
(46, 47, '2018-11-01', '2019-11-03'),
(47, 49, '2019-04-01', '2021-04-11'),
(48, 50, '2020-11-01', '2022-11-20'),
(49, 46, '2018-08-01', '2020-08-02'),
(50, 48, '2021-07-01', '2023-07-16');


-- =====================================================
-- INSERTS FÉRIAS
-- =====================================================

INSERT INTO ferias
(id_funcionario, data_inicio_ferias, data_fim_ferias)
VALUES
(1, '2024-01-08', '2024-01-22'),
(2, '2024-02-05', '2024-02-19'),
(3, '2024-03-11', '2024-03-25'),
(4, '2024-04-01', '2024-04-15'),
(5, '2024-05-06', '2024-05-20'),
(6, '2024-06-03', '2024-06-17'),
(7, '2024-07-08', '2024-07-22'),
(8, '2024-08-05', '2024-08-19'),
(9, '2024-09-02', '2024-09-16'),
(10, '2024-10-07', '2024-10-21'),
(11, '2024-01-15', '2024-01-29'),
(12, '2024-02-12', '2024-02-26'),
(13, '2024-03-04', '2024-03-18'),
(14, '2024-04-08', '2024-04-22'),
(15, '2024-05-13', '2024-05-27'),
(16, '2024-06-10', '2024-06-24'),
(17, '2024-07-01', '2024-07-15'),
(18, '2024-08-12', '2024-08-26'),
(19, '2024-09-09', '2024-09-23'),
(20, '2024-10-14', '2024-10-28'),
(21, '2024-01-22', '2024-02-05'),
(22, '2024-02-19', '2024-03-04'),
(23, '2024-03-18', '2024-04-01'),
(24, '2024-04-15', '2024-04-29'),
(25, '2024-05-20', '2024-06-03'),
(26, '2024-06-17', '2024-07-01'),
(27, '2024-07-15', '2024-07-29'),
(28, '2024-08-19', '2024-09-02'),
(29, '2024-09-23', '2024-10-07'),
(30, '2024-10-21', '2024-11-04'),
(31, '2024-01-08', '2024-01-22'),
(32, '2024-02-05', '2024-02-19'),
(33, '2024-03-11', '2024-03-25'),
(34, '2024-04-01', '2024-04-15'),
(35, '2024-05-06', '2024-05-20'),
(36, '2024-06-03', '2024-06-17'),
(37, '2024-07-08', '2024-07-22'),
(38, '2024-08-05', '2024-08-19'),
(39, '2024-09-02', '2024-09-16'),
(40, '2024-10-07', '2024-10-21'),
(41, '2024-01-15', '2024-01-29'),
(42, '2024-02-12', '2024-02-26'),
(43, '2024-03-04', '2024-03-18'),
(44, '2024-04-08', '2024-04-22'),
(45, '2024-05-13', '2024-05-27'),
(46, '2024-06-10', '2024-06-24'),
(47, '2024-07-01', '2024-07-15'),
(48, '2024-08-12', '2024-08-26'),
(49, '2024-09-09', '2024-09-23'),
(50, '2024-10-14', '2024-10-28');


-- =====================================================
-- INSERTS SALÁRIOS
-- =====================================================

INSERT INTO salarios
(id_funcionario, valor_salario, data_inicio_salario, data_fim_salario)
VALUES
(1, 4500.00, '2020-02-10', '2022-02-09'),
(1, 5200.00, '2022-02-10', NULL),
(2, 3300.00, '2021-03-15', '2023-03-14'),
(2, 3850.00, '2023-03-15', NULL),
(3, 5900.00, '2019-07-01', '2022-06-30'),
(3, 6800.00, '2022-07-01', NULL),
(4, 3600.00, '2022-01-17', '2023-01-16'),
(4, 4200.00, '2023-01-17', NULL),
(5, 3000.00, '2023-05-08', '2024-05-07'),
(5, 3500.00, '2024-05-08', NULL),
(6, 5100.00, '2020-09-14', '2022-09-13'),
(6, 5900.00, '2022-09-14', NULL),
(7, 2800.00, '2022-06-20', '2023-06-19'),
(7, 3200.00, '2023-06-20', NULL),
(8, 6300.00, '2018-11-05', '2021-11-04'),
(8, 7200.00, '2021-11-05', NULL),
(9, 4200.00, '2021-08-23', '2023-08-22'),
(9, 4800.00, '2023-08-23', NULL),
(10, 3900.00, '2023-02-13', '2024-02-12'),
(10, 4500.00, '2024-02-13', NULL),
(11, 5300.00, '2019-04-22', '2022-04-21'),
(11, 6100.00, '2022-04-22', NULL),
(12, 4100.00, '2020-10-19', '2022-10-18'),
(12, 4700.00, '2022-10-19', NULL),
(13, 2900.00, '2022-03-07', '2024-03-06'),
(13, 3400.00, '2024-03-07', NULL),
(14, 6600.00, '2018-06-11', '2021-06-10'),
(14, 7600.00, '2021-06-11', NULL),
(15, 4500.00, '2021-12-06', '2023-12-05'),
(15, 5100.00, '2023-12-06', NULL),
(16, 3800.00, '2020-01-20', '2022-01-19'),
(16, 4400.00, '2022-01-20', NULL),
(17, 2600.00, '2022-08-15', '2024-08-14'),
(17, 3000.00, '2024-08-15', NULL),
(18, 3300.00, '2023-01-09', '2024-01-08'),
(18, 3900.00, '2024-01-09', NULL),
(19, 4600.00, '2019-09-02', '2022-09-01'),
(19, 5300.00, '2022-09-02', NULL),
(20, 4000.00, '2021-05-17', '2023-05-16'),
(20, 4600.00, '2023-05-17', NULL),
(21, 4300.00, '2020-07-13', '2022-07-12'),
(21, 4900.00, '2022-07-13', NULL),
(22, 2800.00, '2022-02-21', '2024-02-20'),
(22, 3300.00, '2024-02-21', NULL),
(23, 3500.00, '2021-10-04', '2023-10-03'),
(23, 4100.00, '2023-10-04', NULL),
(24, 5000.00, '2019-03-18', '2022-03-17'),
(24, 5700.00, '2022-03-18', NULL),
(25, 3100.00, '2023-04-10', '2024-04-09'),
(25, 3600.00, '2024-04-10', NULL),
(26, 4700.00, '2020-05-25', '2022-05-24'),
(26, 5500.00, '2022-05-25', NULL),
(27, 3700.00, '2021-06-14', '2023-06-13'),
(27, 4300.00, '2023-06-14', NULL),
(28, 5800.00, '2018-08-27', '2021-08-26'),
(28, 6700.00, '2021-08-27', NULL),
(29, 3000.00, '2022-09-19', '2023-09-18'),
(29, 3500.00, '2023-09-19', NULL),
(30, 5000.00, '2020-11-09', '2022-11-08'),
(30, 5800.00, '2022-11-09', NULL),
(31, 4400.00, '2021-01-11', '2023-01-10'),
(31, 5100.00, '2023-01-11', NULL),
(32, 3900.00, '2022-05-16', '2024-05-15'),
(32, 4500.00, '2024-05-16', NULL),
(33, 3200.00, '2019-10-21', '2022-10-20'),
(33, 3700.00, '2022-10-21', NULL),
(34, 5400.00, '2020-03-30', '2022-03-29'),
(34, 6200.00, '2022-03-30', NULL),
(35, 2900.00, '2023-06-05', '2024-06-04'),
(35, 3400.00, '2024-06-05', NULL),
(36, 6200.00, '2018-12-03', '2021-12-02'),
(36, 7100.00, '2021-12-03', NULL),
(37, 4200.00, '2021-07-26', '2023-07-25'),
(37, 4800.00, '2023-07-26', NULL),
(38, 4500.00, '2022-10-10', '2024-10-09'),
(38, 5200.00, '2024-10-10', NULL),
(39, 3300.00, '2020-04-06', '2022-04-05'),
(39, 3900.00, '2022-04-06', NULL),
(40, 4000.00, '2019-05-27', '2022-05-26'),
(40, 4600.00, '2022-05-27', NULL),
(41, 4300.00, '2021-02-08', '2023-02-07'),
(41, 5000.00, '2023-02-08', NULL),
(42, 3100.00, '2022-07-18', '2024-07-17'),
(42, 3600.00, '2024-07-18', NULL),
(43, 5500.00, '2018-09-17', '2021-09-16'),
(43, 6400.00, '2021-09-17', NULL),
(44, 4100.00, '2020-06-22', '2022-06-21'),
(44, 4700.00, '2022-06-22', NULL),
(45, 3000.00, '2023-03-13', '2024-03-12'),
(45, 3500.00, '2024-03-13', NULL),
(46, 5100.00, '2019-11-04', '2022-11-03'),
(46, 5900.00, '2022-11-04', NULL),
(47, 3700.00, '2021-04-12', '2023-04-11'),
(47, 4300.00, '2023-04-12', NULL),
(48, 3500.00, '2022-11-21', '2024-11-20'),
(48, 4100.00, '2024-11-21', NULL),
(49, 4500.00, '2020-08-03', '2022-08-02'),
(49, 5200.00, '2022-08-03', NULL),
(50, 3200.00, '2023-07-17', '2024-07-16'),
(50, 3700.00, '2024-07-17', NULL);


-- =====================================================
-- INSERTS DEPENDENTES
-- =====================================================

INSERT INTO dependentes
(nome_dependente, data_nascimento_dependente, cpf_dependente)
VALUES
('Lucas Martins Ferreira', '2014-05-12', '418.625.930-01'),
('Mariana Souza Oliveira', '2016-08-23', '527.341.860-02'),
('Pedro Mendes Rocha', '2012-03-17', '639.814.250-03'),
('Beatriz Lima Costa', '2018-11-05', '741.256.390-04'),
('Rafael Pereira Costa', '2015-07-19', '853.927.410-05'),
('Sofia Alves Ribeiro', '2017-02-14', '964.315.720-06'),
('Miguel Martins Oliveira', '2013-09-28', '175.638.940-07'),
('Clara Cristina Santos', '2019-04-11', '286.741.530-08'),
('Arthur Rodrigues Almeida', '2011-12-30', '397.852.610-09'),
('Laura Ferreira Nunes', '2016-06-18', '508.963.720-10'),
('Enzo Moreira Silva', '2014-01-25', '619.274.830-11'),
('Alice Freitas Gomes', '2018-08-07', '720.385.940-12'),
('Gabriel Cardoso Mendes', '2013-10-16', '831.496.250-13'),
('Manuela Ramos Teixeira', '2017-03-22', '942.517.360-14'),
('Davi Martins Lopes', '2015-12-09', '153.628.470-15'),
('Helena Gomes Pereira', '2019-05-27', '264.739.580-16'),
('João Pedro Dias', '2012-07-14', '375.841.690-17'),
('Valentina Souza Pinto', '2016-02-03', '486.952.710-18'),
('Theo Castro Silva', '2018-09-21', '597.163.820-19'),
('Isabela Nascimento Alves', '2014-11-13', '608.274.930-20'),
('Bernardo Vitória Silva', '2015-04-08', '719.385.640-21'),
('Lívia Batista Santos', '2017-10-19', '820.496.750-22'),
('Gustavo Vieira Mendes', '2013-06-26', '931.507.860-23'),
('Cecília Augusto Moura', '2019-01-15', '142.618.970-24'),
('Matheus Fernandes Reis', '2011-08-31', '253.729.180-25'),
('Lorena Barros Carvalho', '2016-05-20', '364.831.290-26'),
('Henrique Eduardo Duarte', '2014-09-12', '475.942.310-27'),
('Júlia Cristina Campos', '2018-12-04', '586.153.420-28'),
('Vicente Almeida Souza', '2013-02-27', '697.264.530-29'),
('Maria Eduarda Farias', '2017-07-06', '708.375.640-30'),
('Antônio Rafael Lopes', '2015-10-24', '819.486.750-31'),
('Valentina Rodrigues Melo', '2019-03-09', '920.597.860-32'),
('Lucca Costa Ferreira', '2012-12-17', '131.608.970-33'),
('Ana Clara Nascimento', '2016-04-28', '242.719.180-34'),
('Samuel Gomes Silva', '2014-08-15', '353.821.290-35'),
('Emanuelly Martins Costa', '2018-06-23', '464.932.310-36'),
('Nicolas Henrique Santos', '2013-11-02', '575.143.420-37'),
('Laura Beatriz Oliveira', '2017-01-18', '686.254.530-38'),
('Caio Augusto Pereira', '2015-05-11', '797.365.640-39'),
('Sophia Mendes Alves', '2019-09-29', '808.476.750-40'),
('Benjamin Martins Rocha', '2012-04-16', '919.587.860-41'),
('Lara Cristina Souza', '2016-10-07', '120.698.970-42'),
('Murilo Fernandes Costa', '2014-02-21', '231.719.180-43'),
('Elisa Gabriela Lima', '2018-07-13', '342.821.290-44'),
('Ravi Eduardo Ramos', '2015-01-30', '453.932.310-45'),
('Heloísa Martins Dias', '2017-05-18', '564.143.420-46'),
('Arthur Gabriel Oliveira', '2013-08-25', '675.254.530-47'),
('Maitê Cristina Alves', '2019-11-06', '786.365.640-48'),
('Leonardo Souza Ferreira', '2011-06-14', '897.476.750-49'),
('Isadora Mendes Pereira', '2016-03-27', '908.587.860-50');

INSERT INTO funcionario_dependente
(id_funcionario, id_dependente, grau_parentesco)
VALUES
(2, 1, 'Filho'),
(3, 2, 'Filha'),
(3, 3, 'Filho'),
(4, 4, 'Filha'),
(4, 5, 'Filho'),
(4, 6, 'Filha'),
(6, 7, 'Filho'),
(7, 8, 'Filha'),
(7, 9, 'Filho'),
(8, 10, 'Filha'),
(8, 11, 'Filho'),
(8, 12, 'Filha'),
(10, 13, 'Filho'),
(11, 14, 'Filha'),
(11, 15, 'Filho'),
(13, 16, 'Filha'),
(13, 17, 'Filho'),
(13, 18, 'Filha'),
(14, 19, 'Filho'),
(16, 20, 'Filha'),
(17, 21, 'Filho'),
(18, 22, 'Filha'),
(18, 23, 'Filho'),
(18, 24, 'Filha'),
(20, 25, 'Filho'),
(21, 26, 'Filha'),
(21, 27, 'Filho'),
(23, 28, 'Filha'),
(24, 29, 'Filho'),
(24, 30, 'Filha'),
(25, 31, 'Filho'),
(27, 32, 'Filha'),
(27, 33, 'Filho'),
(27, 34, 'Filha'),
(28, 35, 'Filho'),
(30, 36, 'Filha'),
(30, 37, 'Filho'),
(32, 38, 'Filha'),
(33, 39, 'Filho'),
(33, 40, 'Filha'),
(35, 41, 'Filho'),
(36, 42, 'Filha'),
(36, 43, 'Filho'),
(36, 44, 'Filha'),
(38, 45, 'Filho'),
(39, 46, 'Filha'),
(41, 47, 'Filho'),
(42, 48, 'Filha'),
(42, 49, 'Filho'),
(42, 50, 'Filha'),

-- Dependentes compartilhados entre funcionários
(43, 1, 'Filho'),
(44, 2, 'Filha'),
(45, 3, 'Filho'),
(45, 4, 'Filha'),
(47, 5, 'Filho'),
(47, 6, 'Filha'),
(48, 7, 'Filho'),
(50, 8, 'Filha'),
(50, 9, 'Filho'),
(45, 10, 'Filha'),
(47, 11, 'Filho'),
(47, 12, 'Filha'),
(48, 13, 'Filho'),
(50, 14, 'Filha'),
(50, 15, 'Filho');