
-- ==========================================================
-- BANCO DE DADOS: LojaTech (PostgreSQL)
-- ==========================================================

-- Criação do esquema
DROP SCHEMA IF EXISTS lojatech CASCADE;
CREATE SCHEMA lojatech;
SET search_path TO lojatech;

-- ==========================================================
-- TABELA: clientes
-- ==========================================================
CREATE TABLE clientes (
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    telefone        VARCHAR(20),
    cidade          VARCHAR(50),
    estado          CHAR(2),
    data_cadastro   DATE DEFAULT CURRENT_DATE
);

INSERT INTO clientes (nome, email, telefone, cidade, estado, data_cadastro) VALUES
('Ana Souza', 'ana.souza@email.com', '51999990001', 'Porto Alegre', 'RS', '2024-10-01'),
('Bruno Lima', 'bruno.lima@email.com', '51999990002', 'Canoas', 'RS', '2024-10-02'),
('Carla Menezes', 'carla.menezes@email.com', '51999990003', 'Florianópolis', 'SC', '2024-10-05'),
('Daniel Silva', 'daniel.silva@email.com', '51999990004', 'Curitiba', 'PR', '2024-10-07'),
('Eduarda Costa', 'eduarda.costa@email.com', '51999990005', 'São Paulo', 'SP', '2024-10-10');

-- ==========================================================
-- TABELA: categorias
-- ==========================================================
CREATE TABLE categorias (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(50) NOT NULL,
    descricao   VARCHAR(150)
);

INSERT INTO categorias (nome, descricao) VALUES
('Computadores', 'Desktops, notebooks e componentes'),
('Periféricos', 'Teclados, mouses, headsets e acessórios'),
('Monitores', 'Monitores LED e ultrawide'),
('Redes', 'Roteadores, switches e cabos de rede'),
('Armazenamento', 'HDs, SSDs e pendrives');

-- ==========================================================
-- TABELA: produtos
-- ==========================================================
CREATE TABLE produtos (
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    categoria_id    INT REFERENCES categorias(id),
    preco           NUMERIC(10,2) NOT NULL,
    estoque         INT DEFAULT 0,
    fabricante      VARCHAR(50),
    garantia_meses  INT DEFAULT 12,
    ativo           BOOLEAN DEFAULT TRUE
);

INSERT INTO produtos (nome, categoria_id, preco, estoque, fabricante, garantia_meses) VALUES
('Notebook Lenovo IdeaPad 3', 1, 3499.90, 20, 'Lenovo', 12),
('Mouse Logitech M170', 2, 79.90, 150, 'Logitech', 24),
('Teclado Mecânico Redragon Kumara', 2, 249.90, 80, 'Redragon', 12),
('Monitor LG Ultrawide 29"', 3, 1299.00, 15, 'LG', 24),
('SSD Kingston 480GB', 5, 229.90, 60, 'Kingston', 36),
('HD Seagate 1TB', 5, 299.90, 40, 'Seagate', 24),
('Roteador TP-Link Archer C6', 4, 259.90, 30, 'TP-Link', 24);

-- ==========================================================
-- TABELA: vendas
-- ==========================================================
CREATE TABLE vendas (
    id              SERIAL PRIMARY KEY,
    cliente_id      INT NOT NULL REFERENCES clientes(id),
    data_venda      DATE DEFAULT CURRENT_DATE,
    forma_pagamento VARCHAR(20),
    total_venda     NUMERIC(10,2)
);

INSERT INTO vendas (cliente_id, data_venda, forma_pagamento, total_venda) VALUES
(1, '2024-10-05', 'Cartão', 3779.80),
(2, '2024-10-06', 'Pix', 299.90),
(3, '2024-10-07', 'Dinheiro', 1529.00),
(4, '2024-10-08', 'Cartão', 229.90),
(1, '2024-10-10', 'Pix', 1899.80);

-- ==========================================================
-- TABELA: itens_venda
-- ==========================================================
CREATE TABLE itens_venda (
    id              SERIAL PRIMARY KEY,
    venda_id        INT NOT NULL REFERENCES vendas(id),
    produto_id      INT NOT NULL REFERENCES produtos(id),
    quantidade      INT NOT NULL,
    preco_unitario  NUMERIC(10,2) NOT NULL
);

INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 3499.90),
(1, 2, 2, 79.90),
(2, 3, 1, 249.90),
(2, 2, 1, 79.90),
(3, 4, 1, 1299.00),
(3, 2, 1, 79.90),
(3, 5, 1, 150.10),
(4, 5, 1, 229.90),
(5, 1, 1, 3499.90),
(5, 5, 2, 229.90);

-- ==========================================================
-- TABELA: fornecedores
-- ==========================================================
CREATE TABLE fornecedores (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    cnpj        VARCHAR(18),
    cidade      VARCHAR(50),
    estado      CHAR(2),
    telefone    VARCHAR(20)
);

INSERT INTO fornecedores (nome, cnpj, cidade, estado, telefone) VALUES
('Tech Distribuidora Ltda', '12.345.678/0001-99', 'São Paulo', 'SP', '1133334444'),
('Giga Imports', '98.765.432/0001-11', 'Curitiba', 'PR', '4132221111'),
('CompStore', '45.678.123/0001-22', 'Porto Alegre', 'RS', '5133345566');

-- ==========================================================
-- TABELA: estoque_fornecedor
-- ==========================================================
CREATE TABLE estoque_fornecedor (
    id              SERIAL PRIMARY KEY,
    fornecedor_id   INT REFERENCES fornecedores(id),
    produto_id      INT REFERENCES produtos(id),
    preco_custo     NUMERIC(10,2),
    prazo_entrega   INT
);

INSERT INTO estoque_fornecedor (fornecedor_id, produto_id, preco_custo, prazo_entrega) VALUES
(1, 1, 2999.90, 10),
(1, 2, 55.00, 5),
(2, 4, 1029.00, 8),
(3, 3, 199.90, 7),
(3, 6, 250.00, 12);

-- ==========================================================
-- CONSULTAS DEMONSTRATIVAS
-- ==========================================================
-- Exemplo: Total de vendas por cliente
-- SELECT c.nome, SUM(v.total_venda) AS total
-- FROM vendas v JOIN clientes c ON v.cliente_id = c.id
-- GROUP BY c.nome ORDER BY total DESC;
