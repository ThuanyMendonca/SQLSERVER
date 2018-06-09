create database exIntegridade
use exIntegridade
-- EXERCICIO INTEGRIDADE

create table cliente(
	codCliente int not null constraint pk_cliente primary key identity(1,1),
	nome varchar(50) NOT NULL,
	telefone varchar(20) NOT NULL,
	tipo_cliente varchar(20) constraint cheTipo check (tipo_cliente in ('Titular','Dependente')),
	dt_cadastro datetime NOT NULL CONSTRAINT DT_CADAST DEFAULT(GETDATE()),
	nr_dependentes int NOT NULL constraint cheNDepend check(nr_dependentes >= 0 and nr_dependentes <= 3)
)
insert into cliente values
	('Thuany','27384934','Titular',getdate(),3)

-- alter table cliente add constraint chk_cliente check(tipo_cliente in ('Titular', 'Dependente'))
-- alter table cliente add constraint df_data default(getdate()) for dt_cadastro
select * from cliente
create table marca(
	id_marca int constraint pk_marca primary key identity(1,1),
	nome varchar(60)UNIQUE
)

insert into marca values
	('Nike'),
	('Adidas')

create table produto(
	id_pro int constraint pk_prod primary key identity(1000,1) constraint ch_IDProd check (id_pro <= 9999),
	nome_produto varchar(60) NOT NULL,
	estoque int check(estoque >= 0),
	preco money,
	constraint chePrec check ((estoque * preco) <= 250000),
	id_marca int constraint fk_idmarca foreign key references marca(id_marca)
)

-- Para excluir a tabela, precisa excluir a constraint primeiro
alter table produto drop constraint chePrec
drop table produto


insert into produto values 
	('Tenis', 100, 30, 2)

create table pedido(
	id_pedido int constraint pk_ped primary key identity(1,1),
	data datetime CONSTRAINT DT_PED DEFAULT (GETDATE()),
	valor_desc money,
	valor_total money
)

insert into pedido values
	(GETDATE(), 10, 100)

select * from pedido

create table ItemPedido(
	id_pedido int constraint fk_itemPed foreign key references pedido(id_pedido),
	id_pro int constraint fk_item_Pro foreign key references produto(id_pro),
	qtde int,
	vl_unit money,
	constraint pk_itemped primary key(id_pedido, id_pro),       -- Chave composta
	constraint checPrecoQtde check((vl_unit > 1000 and qtde < 100) or (vl_unit <= 1000))
)

insert into ItemPedido values
	(1,1,100,40)

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




