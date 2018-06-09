-- Criando banco de dados
create database revisao
-- go para executar os dois comandos create e use (pq para executar, o banco precisa existir)
use revisao

-- Tem a possibilidade de fazer diferença entre letras maiusculas e minusculas
-- Criar chave primária no momento da criação da tablea primary key identity(1,1)
create table categoria (
	codCat int,
	descricao varchar(40),
	ativo char(1) --S ou N
)

-- Criando chave primária depois que a tabela foi criada (precisa colocar obrigatório com o NOT NULL)
alter table categoria alter column codCat int NOT NULL

-- Adicionando chave primária após deixar o campo not null
alter table categoria add primary key(codCat)

create table artista(
	codArt int,
	nome varchar(50),
	nomeArtistico varchar(60),
	dtNasc datetime,  -- pode gravar data e/ou hora
	pais varchar(80)
)
alter table artista alter column codArt int NOT NULL

alter table artista add primary key(codArt)

select * from categoria
select * from artista

-- diferença entre varchar (dinâmico, não ocupa tudo, apenas oq usar) e char (o espaço que tem é o espaço pré definido)

create table cd (
	codCd int primary key identity(1,1),
	titulo varchar(40),
	ano int,
	-- Chave estrangeira precisa ser o mesmo tipo de dado
	codCat int foreign key references categoria(codCat),
	codArt int foreign key references artista(codArt)
)

select * from cd

-- Cadastrar
insert into categoria values
	(1,'ROCK', 'S'),
	(2,'POP', 'S'),
	(3,'SERTANEJO', 'N'),
	(4,'FUNK', 'N')

insert into artista values 
	(1,'Sebastiao','Tiao','1922/15/10','Brasil'),
	(2,'Philipe colinas','Phill Colins','1955/20/02','Canadá'),
	(3,'Iron Maiden','Iron','1922/14/12','Inglaterra')

-- inserir registros cadastrando apenas alguns campos da tabela:
insert into artista (pais, nome, nomeArtistico, codArt) values
	('USA','Jessie','Jessie J',4)

-- Adicionar campo para guardar o preço do cd
alter table cd add preco int

-- Cadastre 6 cds ou mais
insert into cd values
	('VOLUME 1', 2010, 3, 2, 20),
	('VOLUME 2', 2011, 1, 2, 30),
	('VOLUME 3', 2012, 4, 2, 40),
	('VOLUME 4', 2013, 2, 2, 18)


select * from cd
select * from categoria
select * from artista

-- Atualize os preços de cada CD
update cd set preco = 20 where codCd in (2,3,110,45,18)

-- Cadastre um artista da Alemanha
insert into artista (codArt, nome, pais) values
	(5,'Hans', 'Alemanha')

-- Cadastre 3 CDs para este artista
select * from cd

insert into cd values 
	(1,'VOLUME 5', 2015, 3, 7,20),
	(2,'VOLUME 6', 2016, 4, 7,10),
	(3,'VOLUME 7', 2017, 2, 7,12)

-- Liste os cds das categorias ativas
select * from cd

-- Subselect
select * from cd where codCat in (select codCat from categoria where ativo = 'S')

-- Mude o preço dos CDs lançados de 1950 a 2002 para 10% a mais
update cd set preco = preco * 1.1 where ano between 1950 and 2002

-- Mostra um novo campo no select apenas
select preco, preco * 1.5 as NovoPreco from cd

-- Campos calculados não podem ser gravados, terceira forma normal

-- Liste os cds com preço acima da mádia

select * from cd where preco > (select avg(preco) from cd)

select * from categoria
-- exclua os CDs dos artistas do Brasil que estão em categorias inativas
delete cd where codArt in (select codArt from artista where pais = 'Brasil') and codCat in (select codCat from categoria where ativo = 'S')

-- Quantos Cds foram lançados em 2015 por artistas da Alemanha?
select count(*) from cd where ano = 2015 and codArt in (select codArt from artista where pais = 'Alemanha')