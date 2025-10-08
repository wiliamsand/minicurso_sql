# 📊 Minicurso SQL na Prática: Fundamentos Essenciais

Material utilizado para ministrar o minicurso **SQL na Prática: fundamentos essenciais**, apresentado na **8ª Semana Acadêmica da Ciência da Computação IFRS - Ibirubá**.

## 📋 Sobre o Minicurso

Este repositório contém todos os materiais práticos utilizados no minicurso de SQL, focando nos fundamentos essenciais da linguagem SQL com PostgreSQL. O curso foi estruturado para proporcionar uma experiência prática e progressiva, desde consultas básicas até desafios avançados.

## 🎯 Objetivos

- Compreender os fundamentos da linguagem SQL
- Praticar consultas básicas, intermediárias e avançadas
- Trabalhar com JOINs, agregações e subconsultas
- Resolver problemas reais com base de dados
- Desenvolver habilidades analíticas com SQL

## 📁 Estrutura do Repositório

```
minicurso_sql/
├── criacao_base.sql     # Script de criação do banco de dados
├── consultas.sql        # Consultas práticas e desafios
├── sql_cheatsheet.jpg   # Guia de referência rápida SQL
└── README.md           # Documentação do projeto
```

## 🗄️ Base de Dados: LojaTech

O minicurso utiliza uma base de dados fictícia chamada **LojaTech**, que simula o sistema de uma loja de tecnologia. A base contém as seguintes tabelas:

### 📊 Estrutura das Tabelas

- **`clientes`** - Informações dos clientes (id, nome, email, telefone, cidade, estado)
- **`categorias`** - Categorias de produtos (Computadores, Periféricos, Monitores, Redes, Armazenamento)
- **`produtos`** - Catálogo de produtos com preços e estoque
- **`vendas`** - Registro das vendas realizadas
- **`itens_venda`** - Detalhes dos itens vendidos em cada venda
- **`fornecedores`** - Dados dos fornecedores
- **`estoque_fornecedor`** - Relação entre fornecedores e produtos com custos

## 🚀 Como Usar

### 1. Criação da Base de Dados

Execute o arquivo `criacao_base.sql` para criar todas as tabelas e inserir os dados de exemplo:

### 2. Executar as Consultas

O arquivo `consultas.sql` está organizado em seções progressivas:

## 📚 Conteúdo Programático

### 🟢 **Consultas Básicas**
- SELECT básico
- Filtros com WHERE
- Ordenação com ORDER BY
- Busca por padrões com LIKE/ILIKE

**Exemplos:**
```sql
-- Listar produtos com preço acima de R$ 500
SELECT nome, preco FROM produtos WHERE preco > 500;

-- Buscar produtos cujo nome contém "SSD"
SELECT nome, preco FROM produtos WHERE nome ILIKE '%SSD%';
```

### 🟡 **Consultas Intermediárias**
- JOINs (INNER, LEFT)
- Funções de agregação (COUNT, SUM, AVG)
- Agrupamento com GROUP BY
- Análise de vendas por cliente

**Exemplos:**
```sql
-- Calcular o preço médio dos produtos de cada categoria
SELECT c.nome AS categoria, ROUND(AVG(p.preco), 2) AS preco_medio
FROM categorias c
JOIN produtos p ON c.id = p.categoria_id
GROUP BY c.nome;
```

### 🔵 **Consultas Avançadas**
- Subconsultas
- Funções de data e formatação
- Análise de lucro e rentabilidade
- Rankings e TOP N
- Consultas analíticas complexas

**Exemplos:**
```sql
-- Calcular o lucro bruto estimado de cada produto
SELECT 
    p.nome,
    p.preco AS preco_venda,
    ROUND(AVG(ef.preco_custo), 2) AS custo_medio,
    ROUND(p.preco - AVG(ef.preco_custo), 2) AS lucro_unitario
FROM produtos p
JOIN estoque_fornecedor ef ON p.id = ef.produto_id
GROUP BY p.nome, p.preco
ORDER BY lucro_unitario DESC;
```

### 🏆 **Mini Desafio Final**
- Cliente que mais gastou na loja
- Produto mais vendido em quantidade
- Cálculo de lucro total
- Top 5 produtos mais caros
- Vendas acima da média

## 🔧 Ferramentas e Tecnologias

- **PostgreSQL** - Sistema de gerenciamento de banco de dados
- **SQL** - Linguagem de consulta estruturada
- **pgAdmin** ou **psql** - Interfaces para execução das consultas

## 📈 Métricas e KPIs Abordados

O minicurso ensina a calcular importantes métricas de negócio:

- **Vendas por cliente** - Identificar melhores clientes
- **Produtos mais vendidos** - Análise de performance de produtos
- **Análise de categorias** - Movimentação por categoria
- **Cálculo de lucro** - Margem de contribuição por produto
- **Análise temporal** - Vendas por período
- **Clientes inativos** - Identificação de clientes sem compras

## 📖 Material de Apoio

- **sql_cheatsheet.jpg** - Guia de referência rápida com comandos SQL essenciais
- Documentação das consultas com comentários explicativos
- Exemplos progressivos do básico ao avançado

## 🎓 Público-Alvo

- Estudantes de Ciência da Computação
- Iniciantes em SQL e bancos de dados
- Profissionais que desejam aprimorar conhecimentos em SQL
- Analistas de dados em formação

## 💡 Dicas de Estudo

1. **Execute as consultas** na ordem apresentada
2. **Analise os resultados** e compare com os dados originais
3. **Modifique as consultas** para explorar diferentes cenários
4. **Use o cheatsheet** como referência rápida
5. **Pratique** criando suas próprias consultas

## 🤝 Contribuições

Sugestões de melhorias, novos exercícios ou correções são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

## 📝 Licença

Este material foi desenvolvido para fins educacionais e pode ser utilizado livremente para aprendizado e ensino.

---

**Desenvolvido para a 8ª Semana Acadêmica da Ciência da Computação IFRS - Ibirubá**

🔗 **Mantenha-se conectado e continue aprendendo SQL!**