create database ex3view
use ex3view

create table cliente(
	codCliente int constraint pk_cliente primary key identity(1,1),
	prenome varchar(70),
	sobrenome varchar(70),
	telefone varchar(30),
	endereco varchar(100)
)

create table fita(
	codFita int constraint pk_fita primary key identity(1,1),
	rolo varchar(70) constraint opcao check(rolo in('Lançamento','Promocional','Edição Especial'))

)

create table aluga(
	codCliente int constraint fk_cliente foreign key references cliente(codCliente),
	codFita int constraint fk_fita foreign key references fita(codFita),
	dtRetirada date,
	dtDevolucao date,
	constraint conferir check(dtRetirada < dtDevolucao),
	constraint fk_aluga primary key(codCliente, codFita),
	valor money
)

create table filme(
	codFilme int constraint fk_filme primary key identity(1,1),
	titulo varchar(90) not null
)

alter table fita add codFilme int constraint fk_fil foreign key references filme(codFilme) 

create table ator(
	codAtor int constraint pk_ator primary key identity(1,1),
	nomeArtistico varchar(100) not null,
	nomePopular varchar(100),
	dt_nascimento date
)

create table estrela(
	codAtor int constraint fk_ator foreign key references ator(codAtor),
	codFilme int constraint fk_fi foreign key references filme(codFilme),
	constraint pk_estrela primary key(codAtor, codFilme)
)

create view vFilmes 
as
select F.titulo from filme as F inner join 
estrela as E on F.codFilme = E.codFilme inner join 
ator as A on E.codAtor = A.codAtor where month(A.dt_nascimento) in (3)

select * from filme

select * from vAlugados

create view vAlugados
as select F.titulo from filme as F inner join
fita as FI on F.codFilme = FI.codFilme inner join
aluga as A on A.codFita = FI.codFita inner join
cliente as C on A.codCliente = C.codCliente where year((A.dtRetirada) in (2015)


create view vCliFilmes
as select C.prenome, count(*) as qtd from cliente 
inner join aluga as A on C.codCliente = A.codCliente

--Listar os títulos dos filmes e os nomes dos atores que estrelaram tais filmes
create view vFilAtores
as select F.titulo from filme as F inner join
estrela as E on F.codFilme = E.codFilme inner join
ator as A on A.codAtor = E.codAtor

create view vNomeFilmes
as select avg(A.valor) as media from aluga as A
inner join fita as Fi on A.codFita = Fi.codFita
inner join filme as F on Fi.codFilme = F.codFilme
