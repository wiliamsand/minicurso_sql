
-- ==========================================================
-- CONSULTAS PRÁTICAS E DESAFIOS - Oficina SQL (PostgreSQL)
-- Banco: LojaTech
-- ==========================================================

SET search_path TO lojatech;

-- ==========================================================
-- 🟢 CONSULTAS BÁSICAS
-- ==========================================================

-- 1. Listar todos os clientes
SELECT * FROM clientes;

-- 2. Mostrar apenas nome e cidade dos clientes
SELECT nome, cidade FROM clientes;

-- 3. Listar produtos com preço acima de R$ 500
SELECT nome, preco FROM produtos
WHERE preco > 500;

-- 4. Ordenar produtos do mais caro para o mais barato
SELECT nome, preco FROM produtos
ORDER BY preco DESC;

-- 5. Buscar clientes do estado do RS
SELECT nome, cidade, estado FROM clientes
WHERE estado = 'RS';

-- 6. Buscar produtos cujo nome contém “SSD”
SELECT nome, preco FROM produtos
WHERE nome ILIKE '%SSD%';


-- ==========================================================
-- 🟡 CONSULTAS INTERMEDIÁRIAS
-- ==========================================================

-- 7. Contar quantos produtos existem por categoria
SELECT c.nome AS categoria, COUNT(p.id) AS total_produtos
FROM categorias c
LEFT JOIN produtos p ON c.id = p.categoria_id
GROUP BY c.nome;

-- 8. Calcular o preço médio dos produtos de cada categoria
SELECT c.nome AS categoria, ROUND(AVG(p.preco), 2) AS preco_medio
FROM categorias c
JOIN produtos p ON c.id = p.categoria_id
GROUP BY c.nome;

-- 9. Mostrar todas as vendas com o nome do cliente
SELECT v.id AS venda_id, c.nome AS cliente, v.data_venda, v.forma_pagamento, v.total_venda
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
ORDER BY v.data_venda;

-- 10. Ver o total vendido por cliente
SELECT c.nome AS cliente, SUM(v.total_venda) AS total_comprado
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.nome
ORDER BY total_comprado DESC;

-- 11. Mostrar os produtos vendidos e a quantidade total vendida
SELECT p.nome AS produto, SUM(iv.quantidade) AS total_vendido
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC;


-- ==========================================================
-- 🔵 CONSULTAS AVANÇADAS
-- ==========================================================

-- 12. Valor total movimentado por categoria de produto
SELECT c.nome AS categoria, SUM(iv.quantidade * iv.preco_unitario) AS total_vendas
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id
JOIN categorias c ON p.categoria_id = c.id
GROUP BY c.nome
ORDER BY total_vendas DESC;

-- 13. Produtos sem estoque
SELECT nome, estoque FROM produtos
WHERE estoque = 0;

-- 14. Clientes que nunca compraram
SELECT c.nome
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
WHERE v.id IS NULL;

-- 15. Listar fornecedores que fornecem produtos com custo acima de R$ 200
SELECT f.nome AS fornecedor, p.nome AS produto, ef.preco_custo
FROM estoque_fornecedor ef
JOIN fornecedores f ON ef.fornecedor_id = f.id
JOIN produtos p ON ef.produto_id = p.id
WHERE ef.preco_custo > 200;

-- 16. Calcular o lucro bruto estimado de cada produto (preço de venda - custo médio)
SELECT 
    p.nome,
    p.preco AS preco_venda,
    ROUND(AVG(ef.preco_custo), 2) AS custo_medio,
    ROUND(p.preco - AVG(ef.preco_custo), 2) AS lucro_unitario
FROM produtos p
JOIN estoque_fornecedor ef ON p.id = ef.produto_id
GROUP BY p.nome, p.preco
ORDER BY lucro_unitario DESC;

-- 17. Ranking dos 3 produtos mais vendidos
SELECT p.nome, SUM(iv.quantidade) AS qtd_vendida
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id
GROUP BY p.nome
ORDER BY qtd_vendida DESC
LIMIT 3;

-- 18. Valor total vendido por mês
SELECT 
    TO_CHAR(v.data_venda, 'YYYY-MM') AS mes,
    SUM(v.total_venda) AS total_vendas
FROM vendas v
GROUP BY mes
ORDER BY mes;


-- ==========================================================
-- 🏆 MINI DESAFIO FINAL
-- ==========================================================

-- 1️⃣ Cliente que mais gastou na loja
SELECT c.nome, SUM(v.total_venda) AS total_gasto
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.nome
ORDER BY total_gasto DESC
LIMIT 1;

-- 2️⃣ Produto mais vendido (em quantidade)
SELECT p.nome, SUM(iv.quantidade) AS total_vendido
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 1;

-- 3️⃣ Lucro total de todos os produtos vendidos
SELECT SUM((iv.preco_unitario - ef.preco_custo) * iv.quantidade) AS lucro_total
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id
JOIN estoque_fornecedor ef ON ef.produto_id = p.id;

-- 4️⃣ Top 5 produtos mais caros e suas categorias
SELECT p.nome, p.preco, c.nome AS categoria
FROM produtos p
JOIN categorias c ON p.categoria_id = c.id
ORDER BY p.preco DESC
LIMIT 5;

-- 5️⃣ Vendas com valor total acima da média geral
SELECT *
FROM vendas
WHERE total_venda > (SELECT AVG(total_venda) FROM vendas);
