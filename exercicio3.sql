create database exercicio3
use exercicio3

create table fabricante (
	codFabr int constraint pk_codFab primary key identity(1,1),
	razaoSocial varchar(100) NOT NULL,
	cidade varchar(100) constraint cid default ('Franca'),
	uf char(2) constraint checUf check (uf in('SP', 'MG', 'RJ'))
)

create table categoria(
	codCat int constraint pk_cat primary key identity(100,1),
	descricao varchar(100),
	status varchar(100) constraint checStatus check (status in('Ativo', 'Inativo')),
)

create table produto(
	codProd int constraint pk_Prod primary key identity(1,1),
	descricao varchar(100) NOT NULL,
	codFabr int constraint fk_Fabr foreign key references fabricante(codFabr),
	estoque int constraint estq check(estoque >= 0),
	preco money constraint prec check(preco > 0),
	codCat int constraint fk_codCat foreign key references Categoria(codCat)
)

create view vProd 
as 
select P.codProd, P.descricao, P.preco, F.cidade, F.razaoSocial, C.descricao AS descri
from Produto as P
inner join Categoria as C 
ON P.codCat = C.codCat 
inner join fabricante as F
ON P.codFabr = F.codFabr

select * from vProd

--Selecionar de forma exclusiva as categorias que possuem produtos fornecidos para o estado de SP e que estão em categorias inativas.
create view vCatInativas
as
select C.descricao from categoria as C 
inner join Produto as P ON P.codCat = C.codCat inner join fabricante as F 
ON F.codFabr = P.codFabr where F.uf = 'SP' and C.status = 'Inativo'

-- Listar os nomes dos produtos, o preço total dos seus estoques
--(considerando o preço de venda) e o nome das categorias que eles pertencem. Somente de produtos fabricados em SP.
create view vProdEst
as
select P.descricao, (P.preco * P.estoque) as precoEstoque, F.uf , C.descricao as descri 
from produto as P
inner join categoria as C 
ON P.codCat = C.codCat 
inner join fabricante as F on P.codFabr = F.codFabr where F.uf = 'SP'

--Crie uma nova tabela para cadastro de Marcas com os campos CodMarca e 
--NomeMarca. O código deverá ser chave primária com numeração automática 
--a partir de 5000 e o Nome da marca precisará ser de preenchimento obrigatório

create table marcas(
	codMarca int constraint pk_codMarca primary key identity(5000,1),
	nomeMarca varchar(80) not null
)

-- Cada produto poderá ter apenas uma marca
alter table marcas add codProd int constraint fk_CodProd foreign key references produto(codProd)
select * from produto

insert into categoria values
	('Notebook', 'Ativo'),
	('Notebook', 'Inativo')

insert into fabricante values
	('Antiga Motorola','São Paulo', 'SP'),
	('Samsung Entreprise', 'São José dos Campos', 'SP')

insert into produto values
	('Notebook', 1, 2000, 2800,1)

--Cadastre 5 marcas
insert into marcas values
	('Lenovo',1),
	('Samsung',2),
	('Dell',3),
	('Acer',4),
	('Positivo',5)

--Crie uma view que liste a quantidade de produtos que existe por marca. Depois exiba o conteúdo desta view 
--colocando no início da lista, a marca que tem mais produtos.


