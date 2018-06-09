create database exercicioIntegridade
use exercicioIntegridade
-- EXERCICIO INTEGRIDADE

create table cliente(
	codCliente int not null constraint pk_cliente primary key identity(1,1),
	nome varchar(50) NOT NULL,
	telefone varchar(20) NOT NULL,
	tipo_cliente varchar(20) constraint cheTipo check (tipo_cliente in ('Titular','Dependente')),
	dt_cadastro datetime NOT NULL CONSTRAINT DT_CADAST DEFAULT(GETDATE()),
	nr_dependentes int NOT NULL constraint cheNDepend check(nr_dependentes >= 0 and nr_dependentes <= 3)
)

create table marca(
	id_marca int constraint pk_marca primary key identity(1,1),
	nome varchar(60)UNIQUE,
)

create table produto(
	id_pro int constraint pk_prod primary key identity(1,1),
	nome_produto varchar(60) NOT NULL,
	estoque int check(estoque >= 0),
	preco money constraint chePrec check (preco <= 250.000) ,
	id_marca int constraint fk_idmarca foreign key references marca(id_marca)
)

create table pedido(
	id_pedido int constraint pk_ped primary key identity(1,1),
	data datetime NOT NULL CONSTRAINT DT_PED DEFAULT (GETDATE()),
	valor_desc money,
	valor_total money

)

create table ItemPedido(
	id_pedido int constraint pk_IPed primary key identity(1,1),
	id_pro int constraint fk_idpro foreign key references produto(id_pro), 
	qtde int,
	vl_unit money
)

--1.	O nome_produto é de preenchimento obrigatório. 
--2.	Todos os valores da marca na relação Produto existem na relação Marca em id_marca. 
--3.	O id_pro é um inteiro com 4 dígitos. 
--4.	A data do pedido é por padrão a data atual. 
--5.	No mesmo pedido, não pode haver mais de uma venda do mesmo produto.
--6.	Se o preço de um item vendido é superior a 1000 então a quantidade vendida tem de ser menor que 100. 
--7.	O valor total do Estoque de cada Produto não pode exceder os 250.000 (considerando o preço de venda).

--id_marca – identificador único da marca
--nome – nome completo da marca, também único 
-- id_pro- inteiro identificador de produto
-- nome_produto – não necessariamente único, descreve o produto, p.ex. “borracha” 
-- estoque – inteiro que define a quantidade em estoque (sempre positivo)
-- preço – preço de venda do produto
-- id_pedido – inteiro identificador do pedido
-- data – data do pedido




