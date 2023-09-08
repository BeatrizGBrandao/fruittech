CREATE DATABASE fruittech;

USE fruittech;

-- Tabela informações agricultores

CREATE TABLE tbCliente (
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nomeCliente VARCHAR(40) NOT NULL,
    nomeFazenda VARCHAR(60) NOT NULL,
    CNPJ CHAR(14) UNIQUE,
    email VARCHAR(30),
    senha VARCHAR(20),
    logradouro VARCHAR(30),
    bairro VARCHAR(20),
    numlogradouro VARCHAR(5),
    complemento VARCHAR(15),
    CEP CHAR(9),
    cidade VARCHAR(40),
    UF CHAR(2)
);

-- Tabela informações das transportadoras

CREATE TABLE tbTransportadora (
	idTransportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40) NOT NULL,
    CNPJ CHAR(14) UNIQUE,
    email VARCHAR(30),
    senha VARCHAR(20),
    logradouro VARCHAR(30),
    bairro VARCHAR(20),
    numlogradouro VARCHAR(5),
    complemento VARCHAR(15),
    CEP CHAR(9),
    cidade VARCHAR(40),
    UF CHAR(2)
);

-- Tabela para os caminhões de cada agricultor/transportadora

CREATE TABLE tbCaminhoes (
	idCaminhao INT PRIMARY KEY AUTO_INCREMENT,
	idCliente INT,
    origem VARCHAR(14), -- Se pertence ao agricultor ou transportadora
	placa VARCHAR(10) UNIQUE,
	comprimento DECIMAL(5, 2),
    altura DECIMAL(4, 2),
	statusMonitoramento VARCHAR(7), -- Se o monitoramento está funcionando no caminhão, os sensores estão ativos?
	disponibilidade VARCHAR(12),
    FOREIGN KEY (idCliente) REFERENCES tbCliente (idCliente),
    CONSTRAINT chkStatusMonitoramento CHECK (statusMonitoramento IN ('Ativo', 'Inativo')),
    CONSTRAINT chkDisponibilidade CHECK (disponibilidade IN ('Disponível', 'Indisponível')),
    CONSTRAINT chkOrigem CHECK (origem IN ('Agricultor', 'Transportadora'))
);

-- Tabela informações das frutas/hortaliças

CREATE TABLE tbProduto (
	idProduto INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
	tipoProduto VARCHAR(9),
	nomeProduto VARCHAR(80),
	tempIdeal DECIMAL(5, 2),
	umidIdeal DECIMAL(5, 2),
	volumePlantio DECIMAL (10, 2),
	dataPlantio DATE,
	condicaoAtual VARCHAR(7),
	CONSTRAINT chkTipoProduto CHECK (tipoProduto  IN ('Fruta', 'Hortaliça')),
    CONSTRAINT chkCondicaoAtual CHECK (condicaoAtual IN ('Bom', 'Alerta', 'Crítico')),
    FOREIGN KEY (idCliente) REFERENCES tbCliente (idCliente)
);

-- Tabela para os alertas que serão gerados

CREATE TABLE tbAlertas (
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,   
	TipoAlerta VARCHAR(20),
	DescricaoAlerta TEXT,
	AcoesTomadas TEXT,
	Timestamp TIMESTAMP
);

-- Tabela Dados do Monitoramento para cada cliente /No caso, as tabelas anteriores são padrões. Estas, com 'cliente' no nome, são especificas para cada cliente

CREATE TABLE tbMonitoramentoClienteId1 (
	idMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
	idCliente INT,
	idCaminhao INT,
    idProduto INT,
    idAlerta INT,
	Timestamp TIMESTAMP,
	temperatura DECIMAL(5, 2),
	umidade DECIMAL(5, 2),
	localizacaoInicial VARCHAR(50), -- O monitoramento irá começar quando o caminhão partir de alguma localização - logradouro, cep
    localizacaoFinal VARCHAR(50), -- O destino final deste caminhão
	volumeCarga DECIMAL(10, 2),
    FOREIGN KEY (idCliente) REFERENCES tbCliente (idCliente),
    FOREIGN KEY (idCaminhao) REFERENCES tbCaminhoes (idCaminhao),
    FOREIGN KEY (idProduto) REFERENCES tbProduto (idProduto),
    FOREIGN KEY (idAlerta) REFERENCES tbAlertas (idAlerta)
);

-- INSERTS

INSERT INTO tbCliente (nomeCliente, nomeFazenda, CNPJ, email, senha, logradouro, bairro, numlogradouro, complemento, CEP, cidade, UF) VALUES
	('João da Silva', 'Fazenda da Alegria', '12345678901234', 'joao@email.com', 'senha123', 'Rua Principal', 'Bairro A', '101', 'Casa 1', '12345-678', 'Cidade A', 'BA'),
	('Maria Santos', 'Fazenda Feliz', '23456789012345', 'maria@email.com', 'senha456', 'Rua das Flores', 'Bairro B', '202', 'Apto 2', '23456-789', 'Cidade B', 'ES'),
	('Pedro Oliveira', 'Fazenda do Sol', '34567890123456', 'pedro@email.com', 'senha789', 'Avenida Central', 'Bairro C', '303', 'Casa 3', '34567-890', 'Cidade C', 'AM'),
	('Ana Rodrigues', 'Fazenda Esperança', '45678901234567', 'ana@email.com', 'senha123', 'Rua da Liberdade', 'Bairro D', '404', 'Casa 4', '45678-901', 'Cidade D', 'MG'),
	('Carlos Almeida', 'Fazenda União', '56789012345678', 'carlos@email.com', 'senha456', 'Avenida dos Sonhos', 'Bairro E', '505', 'Apartamento 5', '56789-012', 'Cidade E', 'SP'),
	('Sandra Lima', 'Fazenda Paz', '67890123456789', 'sandra@email.com', 'senha789', 'Rua das Estrelas', 'Bairro F', '606', 'Casa 6', '67890-123', 'Cidade F', 'SC'),
	('José Pereira', 'Fazenda Harmonia', '78901234567890', 'jose@email.com', 'senha123', 'Avenida da Harmonia', 'Bairro G', '707', 'Casa 7', '78901-234', 'Cidade G', 'SP'),
	('Fernanda Gomes', 'Fazenda Flores', '89012345678901', 'fernanda@email.com', 'senha456', 'Rua das Tulipas', 'Bairro H', '808', 'Casa 8', '89012-345', 'Cidade H', 'MS'),
	('Roberto Costa', 'Fazenda Vista Linda', '90123456789012', 'roberto@email.com', 'senha789', 'Avenida da Montanha', 'Bairro I', '909', 'Casa 9', '90123-456', 'Cidade I', 'RJ'),
	('Lúcia Ferreira', 'Fazenda da Serra', '01234567890123', 'lucia@email.com', 'senha123', 'Rua da Montanha', 'Bairro J', '1010', 'Casa 10', '01234-567', 'Cidade J', 'RJ');

INSERT INTO tbTransportadora (nome, CNPJ, email, senha, logradouro, bairro, numlogradouro, complemento, CEP, cidade, UF) VALUES
    ('Logística Expressa LTDA', '12345678901234', 'logistica@email.com', 'senha123', 'Rua das Cargas 123', 'Centro', '1234', 'Sala 101', '12345-678', 'Cidade A', 'BA'),
    ('Transporte Rápido S/A', '98765432109876', 'transporterapido@email.com', 'senha456', 'Avenida dos Transportes 456', 'Bairro B', '5678', 'Andar 2', '98765-432', 'Cidade B', 'ES'),
    ('TransCargo BR', '56789012345678', 'transcargo@email.com', 'senha789', 'Rua dos Caminhões 789', 'Bairro C', '9012', 'Galpão 3', '56789-012', 'Cidade C', 'UF'),
    ('Logística Veloz', '11112222333344', 'veloz@email.com', 'senhaVeloz', 'Av. das Entregas 10', 'Centro', '0010', 'Sala 5', '54321-001', 'Cidade D', 'UF'),
    ('Transportadora Ágil', '55556666777788', 'agil@email.com', 'senhaAgil', 'Rua dos Transportes 55', 'Bairro E', '5555', 'Andar 1', '88888-555', 'Cidade E', 'UF'),
    ('RapidLog', '12344321123443', 'rapidlog@email.com', 'senhaRapid', 'Av. da Logística 20', 'Centro', '2020', 'Galpão 10', '43210-202', 'Cidade F', 'UF'),
    ('TransExpresso', '87654321876543', 'transexpresso@email.com', 'senhaExpresso', 'Rua da Entrega 32', 'Bairro G', '3232', 'Sala 7', '87654-323', 'Cidade G', 'UF'),
    ('Carga Segura', '99001111222233', 'cargasegura@email.com', 'senhaSegura', 'Av. das Cargas 45', 'Centro', '4545', 'Andar 3', '00112-454', 'Cidade H', 'UF'),
    ('TransRápida', '11223344556677', 'transrapida@email.com', 'senhaRapida', 'Rua da Velocidade 60', 'Bairro I', '6060', 'Galpão 5', '22334-606', 'Cidade I', 'UF'),
    ('LogTransport', '99887766554433', 'logtransport@email.com', 'senhaLog', 'Av. das Entregas 70', 'Centro', '7070', 'Sala 9', '11223-707', 'Cidade J', 'UF');
    
INSERT INTO tbCaminhoes (idCliente, origem, placa, comprimento, altura, statusMonitoramento, disponibilidade) VALUES
    (1, 'Agricultor', 'ABC1234', 5.70, 2.10, 'Ativo', 'Disponível'),
    (2, 'Transportadora', 'XYZ5678', 7.20, 2.50, 'Ativo', 'Disponível'),
    (3, 'Agricultor', 'DEF9012', 6.00, 2.00, 'Inativo', 'Indisponível'),
    (4, 'Transportadora', 'LMN3456', 8.00, 2.80, 'Ativo', 'Disponível'),
    (5, 'Agricultor', 'GHI7890', 6.50, 2.30, 'Ativo', 'Disponível'),
    (6, 'Transportadora', 'JKL2345', 7.80, 2.40, 'Ativo', 'Disponível'),
    (7, 'Agricultor', 'OPQ6789', 5.50, 1.90, 'Ativo', 'Disponível'),
    (8, 'Transportadora', 'RST0123', 4.50, 2.00, 'Inativo', 'Indisponível'),
    (9, 'Agricultor', 'UVW4567', 6.20, 2.20, 'Ativo', 'Disponível'),
    (10, 'Transportadora', 'YZA8901', 7.00, 2.60, 'Ativo', 'Disponível');
    
INSERT INTO tbProduto (idCliente, tipoProduto, nomeProduto, tempIdeal, umidIdeal, volumePlantio, dataPlantio, condicaoAtual) VALUES
    (1, 'Fruta', 'Maçã', 15.0, 80.0, 100.0, '2023-01-15', 'Bom'),
    (1, 'Hortaliça', 'Tomate', 20.0, 90.0, 50.0, '2023-02-10', 'Alerta'),
    (2, 'Fruta', 'Banana', 25.0, 85.0, 200.0, '2023-03-20', 'Bom'),
    (2, 'Hortaliça', 'Alface', 18.0, 95.0, 30.0, '2023-02-25', 'Crítico'),
    (3, 'Fruta', 'Uva', 15.0, 80.0, 80.0, '2023-01-05', 'Bom'),
    (3, 'Hortaliça', 'Cenoura', 20.0, 90.0, 40.0, '2023-04-12', 'Alerta'),
    (4, 'Fruta', 'Pêra', 18.0, 85.0, 120.0, '2023-03-10', 'Bom'),
    (4, 'Hortaliça', 'Brócolis', 20.0, 90.0, 35.0, '2023-02-28', 'Crítico'),
    (5, 'Fruta', 'Abacaxi', 20.0, 85.0, 150.0, '2023-04-03', 'Bom'),
    (5, 'Hortaliça', 'Espinafre', 18.0, 95.0, 25.0, '2023-03-15', 'Alerta');

INSERT INTO tbAlertas (TipoAlerta, DescricaoAlerta, AcoesTomadas, Timestamp) VALUES
    ('Temperatura Alta', 'A temperatura do caminhão está acima do limite recomendado.', 'Ajuste do sistema de refrigeração.', '2023-09-01 08:15:00'),
    ('Umidade Baixa', 'A umidade está abaixo do ideal para as frutas.', 'Aumento da umidificação.', '2023-09-02 14:30:00'),
    ('Temperatura Baixa', 'A temperatura está abaixo do ideal para as hortaliças.', 'Aquecimento do compartimento de carga.', '2023-09-02 18:45:00'),
    ('Temperatura Alta', 'A temperatura do caminhão está acima do limite recomendado.', 'Ajuste do sistema de refrigeração.', '2023-09-03 09:20:00'),
    ('Umidade Baixa', 'A umidade está abaixo do ideal para as frutas.', 'Aumento da umidificação.', '2023-09-03 13:55:00'),
    ('Temperatura Baixa', 'A temperatura está abaixo do ideal para as hortaliças.', 'Aquecimento do compartimento de carga.', '2023-09-04 17:10:00'),
    ('Umidade Baixa', 'A umidade está abaixo do ideal para as frutas.', 'Aumento da umidificação.', '2023-09-05 11:40:00'),
    ('Temperatura Baixa', 'A temperatura está abaixo do ideal para as hortaliças.', 'Aquecimento do compartimento de carga.', '2023-09-06 19:25:00'),
    ('Temperatura Alta', 'A temperatura do caminhão está acima do limite recomendado.', 'Ajuste do sistema de refrigeração.', '2023-09-07 07:50:00'),
    ('Umidade Baixa', 'A umidade está abaixo do ideal para as frutas.', 'Aumento da umidificação.', '2023-09-08 16:15:00');

INSERT INTO tbMonitoramentoClienteId1 (idCliente, idCaminhao, idProduto, idAlerta, Timestamp, temperatura, umidade, localizacaoInicial, localizacaoFinal, volumeCarga) VALUES
    (1, 1, 1, 1, '2023-09-01 08:30:00', 16.5, 75.0, 'Fazenda da Alegria', 'Cidade A', 95.0),
    (1, 1, 1, 2, '2023-09-01 10:45:00', 17.0, 78.0, 'Cidade A', 'Cidade B', 95.0),
    (1, 1, 1, 3, '2023-09-01 12:20:00', 18.0, 80.0, 'Cidade B', 'Cidade C', 95.0),
    (1, 1, 3, 4, '2023-09-02 09:00:00', 26.0, 88.0, 'Fazenda Feliz', 'Cidade B', 150.0),
    (1, 1, 3, 5, '2023-09-02 11:30:00', 24.5, 90.0, 'Cidade B', 'Cidade C', 150.0),
    (1, 1, 5, 6, '2023-09-03 10:15:00', 17.5, 75.0, 'Fazenda do Sol', 'Cidade C', 70.0),
    (1, 1, 5, 7, '2023-09-03 13:00:00', 16.0, 78.0, 'Cidade C', 'Cidade D', 70.0),
    (1, 1, 7, 8, '2023-09-04 11:45:00', 20.5, 85.0, 'Fazenda Esperança', 'Cidade D', 110.0),
    (1, 1, 7, 9, '2023-09-04 15:20:00', 19.0, 88.0, 'Cidade D', 'Cidade E', 110.0),
    (1, 1, 9, 10, '2023-09-05 09:30:00', 22.0, 80.0, 'Fazenda União', 'Cidade E', 130.0);

-- SELECTS 

SELECT * FROM tbCliente;

SELECT * FROM tbTransportadora;

SELECT * FROM tbCaminhoes;

SELECT * FROM tbProduto;

SELECT * FROM tbAlertas;

SELECT * FROM tbMonitoramentoClienteId1;