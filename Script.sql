--AULA 2
create database supermercado;

create table cliente (
id int not null,
nome varchar(50) not null,
cpf varchar(11) not null,
constraint pk_id_cliente primary key (id)
);
 
create table produto(
id int not null,
descricao varchar(100) not null,
cod_barras varchar(14),
valor decimal(16,2)
);
 
alter table produto add constraint pk_id_produto primary key (id)
 
alter table produto add column situacao boolean not null
 
alter table produto alter column descricao type varchar(200)
 
alter table produto drop column situacao
--drop table produto

--AULA 3
insert into produto(id, descrição,cod_barras, valor, situacao) 
values (1, 'café', '122424312', 10.20, 'true');

update produto set valor = 20 where ID = 2 or id = 3;

delete from produto where id = 1 or id = 4 or id = 6;

insert into produto (id, descricao, cod_barras, valor, situacao )
values (1, 'Arroz', '8721398123', 10.20, true);

insert into produto (id, descricao, cod_barras, valor, situacao )
values (2, 'Cafe', '8721398123', 10.20, true);

insert into produto (id, descricao, cod_barras, valor, situacao )
values (3, 'Macarrao', '8721398123', 10.20, true);

-- Aula 4
drop table if exists pedido;
drop table if exists cliente;

create table cliente (
    id INT primary key,
    nome VARCHAR(100) not null
);

create table pedido (
    id INT primary key,
    clienteId INT not null,
    total DECIMAL(10, 2),

    constraint fk_pedido_cliente
        foreign key (clienteId)
        references cliente(id)
);


INSERT INTO cliente (id, nome) VALUES
(1, 'Ana Souza'),
(2, 'Bruno Lima'),
(3, 'Carla Mendes');


INSERT INTO pedido (id, clienteId, total) VALUES
(101, 1, 250.00),
(102, 1, 89.90),
(103, 2, 120.50),
(104, 3, 560.00);

-- Aula 5 
drop table if exists pedidos;
drop table if exists produtos;
drop table if exists leads_potenciais;
drop table if exists clientes;

CREATE TABLE public.clientes (
	id int NOT NULL,
	nome varchar(50) NOT NULL,
	cidade varchar(50) NULL,
	CONSTRAINT clientes_pkey PRIMARY KEY (id)
);

CREATE TABLE public.leads_potenciais (
	id int NOT NULL,
	nome varchar(50) NULL,
	email varchar(50) NULL,
	CONSTRAINT leads_potenciais_pkey PRIMARY KEY (id)
);

CREATE TABLE public.produtos (
	id int NOT NULL,
	nomeproduto varchar(100) NOT NULL,
	precopadrao numeric(10, 2) NULL,
	CONSTRAINT produtos_pkey PRIMARY KEY (id)
);


CREATE TABLE public.pedidos (
	id int NOT NULL,
	clienteid int NULL,
	produtoid int NULL,
	quantidade int NULL,
	precovenda numeric(10, 2) NULL,
	CONSTRAINT pedidos_pkey PRIMARY KEY (id),
	CONSTRAINT fk_cliente_pedido FOREIGN KEY (clienteid) REFERENCES public.clientes(id),
	CONSTRAINT fk_produto_pedido FOREIGN KEY (produtoid) REFERENCES public.produtos(id)
);

INSERT INTO Produtos (Id, NomeProduto, PrecoPadrao) VALUES
(10, 'Notebook Pro', 4500.00),
(11, 'Rato Sem Fio', 120.00),
(12, 'Monitor 24"', 950.00),
(13, 'Teclado Mecânico', 350.00),
(14, 'Webcam HD', 250.00),
(15, 'Smartphone High', 2800.00),
(16, 'Placa de Vídeo', 6000.00);

INSERT INTO Clientes (Id, Nome, Cidade) VALUES
(1, 'Maria Silva', 'São Paulo'),
(2, 'João Pereira', 'Rio de Janeiro'),
(3, 'Ana Costa', 'Curitiba'),
(4, 'Ricardo Santos', 'Belo Horizonte'),
(5, 'Beatriz Oliveira', 'Porto Alegre'),
(6, 'Carlos Souza', 'Salvador'),
(7, 'Fernanda Lima', 'Recife'),
(8, 'Paulo Rocha', 'Brasília');

INSERT INTO Pedidos (Id, ClienteID, ProdutoID, Quantidade, PrecoVenda) VALUES
(101, 1, 10, 1, 4500.00), 
(102, 1, 11, 2, 110.00), 
(103, 2, 12, 1, 950.00),  
(104, 4, 13, 1, 350.00), 
(105, 5, 15, 1, 2800.00), 
(106, 1, 14, 1, 250.00),  
(107, 6, 14, 1, 250.00), 
(108, 2, 11, 1, 120.00), 
(109, 7, 10, 1, 4300.00);


INSERT INTO Leads_Potenciais (Id, Nome, Email) VALUES
(1, 'Maria Silva', 'maria@email.com'),  
(2, 'João Pereira', 'joao@email.com'),   
(3, 'Roberto Alves', 'roberto@test.com'),  
(4, 'Sónia Mendes', 'sonia@test.com'),     
(5, 'Lucas Neto', 'lucas@test.com'),     
(6, 'Daniela Paz', 'daniela@test.com');    

SELECT C.Nome, P.NomeProduto, Ped.Quantidade
FROM Pedidos Ped
INNER JOIN Clientes C ON Ped.ClienteID = C.Id
INNER JOIN Produtos P ON Ped.ProdutoID = P.Id;

SELECT C.Nome, Ped.Id
FROM Clientes C
LEFT JOIN Pedidos Ped ON C.Id = Ped.ClienteID
WHERE Ped.Id IS NULL;

SELECT P.NomeProduto, P.Id, Ped.Id
FROM Pedidos Ped
RIGHT JOIN Produtos P ON Ped.ProdutoID = P.Id;

SELECT C.Nome, Ped.Id
FROM Clientes C
FULL OUTER JOIN Pedidos Ped ON C.id = Ped.ClienteID;

-- Aula 6

SELECT nome FROM clientes
UNION
SELECT nome FROM leads_potenciais;

SELECT nome FROM clientes
UNION ALL
SELECT nome FROM leads_potenciais;

SELECT nome FROM clientes
INTERSECT
SELECT nome FROM leads_potenciais


SELECT 
    UPPER(nome) AS Nome_Maiusculo,
    CONCAT(nome, ' - ', cidade) AS Etiqueta_Cliente
FROM clientes;

SELECT 
    nome,
    LOWER(LEFT(nome, 3)) AS Prefixo_Login,
    SUBSTRING(email, 1, 5) AS Inicio_Email
FROM leads_potenciais;

SELECT 
    id AS Pedido_ID,
    quantidade,
    precovenda,
    (quantidade * precovenda) AS Valor_Total_Linha
FROM pedidos;


SELECT 
    pR.nomeproduto,
    pr.precopadrao,
    p.precovenda,
    (pr.precopadrao - p.precovenda) AS Desconto_Aplicado
FROM pedidos p
JOIN produtos pr ON p.produtoid = pr.id;

SELECT 
    nome,
    COALESCE(cidade, 'Cidade não informada') AS Localizacao
FROM clientes;


SELECT 
    id AS Pedido_ID,
    precovenda,
    CASE 
        WHEN precovenda >= 4000 THEN 'Venda de Alto Valor'
        WHEN precovenda >= 1000 THEN 'Venda Média'
        ELSE 'Venda de Baixo Valor'
    END AS Classificacao_Venda
FROM pedidos;


SELECT 
    nome,
    LENGTH(LOWER(LEFT(nome, 5))) AS Tamanho_Processado
FROM clientes;

-- Aula 7

SELECT 
    COUNT(*) AS total_pedidos,
    SUM(quantidade) AS total_itens_vendidos,
    AVG(precovenda) AS media_preco_venda,
    MIN(precovenda) AS menor_venda,
    MAX(precovenda) AS maior_venda
FROM pedidos;

SELECT 
    c.nome, 
    SUM(p.quantidade * p.precovenda) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id = p.clienteid
GROUP BY c.nome
ORDER BY total_gasto DESC;

SELECT 
    pr.nomeproduto, 
    COUNT(pe.id) AS vezes_vendido,
    SUM(pe.quantidade) AS qtd_total_unidades,
    SUM(pe.quantidade * pe.precovenda) AS receita_total
FROM produtos pr
LEFT JOIN pedidos pe ON pr.id = pe.produtoid
GROUP BY pr.nomeproduto
ORDER BY qtd_total_unidades DESC;

SELECT 
    c.cidade, 
    COUNT(p.id) AS num_pedidos,
    SUM(p.quantidade * p.precovenda) AS faturamento_regional
FROM clientes c
JOIN pedidos p ON c.id = p.clienteid
GROUP BY c.cidade
ORDER BY faturamento_regional DESC;

SELECT 
    c.nome, 
    SUM(p.quantidade * p.precovenda) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id = p.clienteid
GROUP BY c.nome
HAVING SUM(p.quantidade * p.precovenda) > 1000
ORDER BY total_gasto DESC;
