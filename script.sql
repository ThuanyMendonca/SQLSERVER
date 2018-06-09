create database subBD
go
use subBD

-- Tabela Fabricante
create table Fabricante (
  CodFabricante int, 
  Nome varchar(50), 
  Cidade varchar(50), 
  UF varchar(2) 
)

-- Tabela Categoria
create table Categoria (
  CodCategoria int,
  DescCategoria varchar(30), 
  Ativo varchar(1)
)

-- Tabela Produto
create table Produto (
  CodProduto int,
  Descricao varchar(50), 
  Preco money,
  Estoque int
)

insert into fabricante values('P', 'Belo Horizonte', 'MG')
insert into fabricante values('Q', 'Curitiba', 'PR')
insert into fabricante values('R', 'São Paulo', 'SP')
insert into fabricante values('S', 'Rio Grande da Serra', 'SP')
insert into fabricante values('X', 'Ilheus', 'BA')
insert into fabricante values('Y', 'Betim', 'MG')
insert into fabricante values('Z', 'Palmas', 'TO')

insert into categoria values('Produtos para saúde', 'I')
insert into categoria values('Alimentos', 'A')
insert into categoria values('Agrotóxicos', 'I')
insert into categoria values('Medicamentos', 'A')
insert into categoria values('Cosméticos', 'A')

insert into produto values ('Prod A', 15.80, 2, 1, 0)
insert into produto values ('Prod B', 29.40, 3, 4, 2)
insert into produto values ('Prod C', 18.00, 4, 2, 14)
insert into produto values ('Prod D', 55.10, 5, 4, 6)
insert into produto values ('Prod E', 48.35, 4, 3, 8)
insert into produto values ('Prod F', 19.90, 1, 4, 11)
insert into produto values ('Prod G', 49.90, 4, 5, 0)
insert into produto values ('Prod H', 78.50, 3, 4, 4)
insert into produto values ('Prod I', 35.45, 5, 2, 0)
insert into produto values ('Prod J', 25.70, 4, 3, 7)
insert into produto values ('Prod K', 5.40, 6, 1, 15)
insert into produto values ('Prod L', 20.00, 6, 2, 0)
