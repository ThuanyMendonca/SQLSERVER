create database gravadora

use gravadora

select * from Bandas

CREATE TABLE Bandas (
id_banda int PRIMARY KEY identity(1,1),
Dt_criacao DATETIME,
nome_bandas VARCHAR(60)
)

CREATE TABLE Show (
valor money,
dt_show datetime,
local_show VARCHAR(60),
id_show int PRIMARY KEY identity(1,1),
id_banda int,
FOREIGN KEY(id_banda) REFERENCES Bandas (id_banda)
)

CREATE TABLE Disco (
id_disco int PRIMARY KEY identity(1,1),
titulo VARCHAR(70),
produtor VARCHAR(70),
ano int,
nome_estudio VARCHAR(60),
id_banda int,
FOREIGN KEY(id_banda) REFERENCES Bandas (id_banda)
)
select * from Disco

CREATE TABLE Cancao (
id_cancao int PRIMARY KEY identity(1,1),
nome_cancao VARCHAR(60),
letra VARCHAR(300),
data_composicao DATETIME
)

CREATE TABLE Musicos (
nome_artistico VARCHAR(10),
id_musicos int PRIMARY KEY identity(1,1),
nome_musico VARCHAR(70),
dt_nascimento DATETIME
)

CREATE TABLE Papel (
id_papel int PRIMARY KEY identity(1,1),
id_banda int,
id_musicos int,
FOREIGN KEY(id_banda) REFERENCES Bandas (id_banda),
FOREIGN KEY(id_musicos) REFERENCES Musicos (id_musicos)
)

CREATE TABLE Musicas (
id_musicas int PRIMARY KEY identity(1,1),
id_cancao int,
id_disco int,
FOREIGN KEY(id_cancao) REFERENCES Cancao (id_cancao),
FOREIGN KEY(id_disco) REFERENCES Disco (id_disco)
)
select * from Musicos

-- Cadastro 5 musicos
insert into Musicos values 
	('Morcego', 'Ozzy', '1970/03/09'),
	('Dickinson', 'Bruce', '1975/05/02'),
	('Maiden', 'Dave', '1965/09/07'),
	('Floyd', 'Pink', '1964/06/03'),
	('Jessie J', 'Jessica', '1957/01/02')

-- Cadastro 3 bandas
insert into Bandas values
	('1977/10/09','Black Sabath'),
	('1986/05/10','Iron Maiden'),
	('1979/10/08','Imagine Demons')
select * from Bandas

-- Cadastre 5 discos para diferentes bandas
insert into Disco values
	('Fear of the dark', 'Maiden', 1989, 'Sony', 5),
	('Aces High', 'Iron', 1990, 'ESC',4),
	('Anos 80', 'Cynd', 1992, 'PROD', 4),
	('Anos 90', 'Five', 1988, 'J5', 3),
	('Anos 80', 'Cynd', 1992, 'PROD', 3)

select * from Cancao
-- Cadastre 8 canções
insert into Cancao values
	('ABCD','AKJSHASJD', 2006/05/13),
	('ABCDE','ASMNSJD', 2003/06/09),
	('ABCDEF','ASKJHDJS', 2014/07/08),
	('ABCDEFG','SKDJSDJ', 2016/08/07),
	('ABCDEFGH','SAJHDSSD', 2005/09/06),
	('ABCDEFGHJ','SKJDD', 2003/02/04),
	('ABCDEFGHJK','SLKIERD', 2001/02/13),
	('ABC','ASLDASLSADMASD', 2007/02/03)

select * from Musicos
select * from disco

-- Vincule cada canção aos seus compositores (lembre-se que uma canção pode ser composta por mais de um músico
alter table musicas add id_musicos int
alter table musicas add foreign key (id_musicos) REFERENCES Musicos(id_musicos)



UPDATE Musicas set id_musicos = 1 WHERE  id_cancao = 5
UPDATE Musicas set id_musicos = 2 WHERE  id_cancao = 12
UPDATE Musicas set id_musicos = 2 WHERE  id_cancao = 6
UPDATE Musicas set id_musicos = 3 WHERE  id_cancao = 8
UPDATE Musicas set id_musicos = 4 WHERE  id_cancao = 9
UPDATE Musicas set id_musicos = 5 WHERE  id_cancao = 7
UPDATE Musicas set id_musicos = 1 WHERE  id_cancao = 10
UPDATE Musicas set id_musicos = 4 WHERE  id_cancao = 11

select * from musicos
-- 7.	Cadastre os papéis de cada músico nas bandas que eles participam.
insert into Papel values 
	(3,2),
	(4,1),
	(5,3)
-- 8.	Cadastre as músicas que fazem parte de cada disco já cadastrado.
select * from Disco
select * from Musicas
select * from cancao

insert into Musicas values 
	(5,3),
	(6,4),
	(7,5),
	(8,6),
	(9,7)

-- 9.	Cadastre 6 shows.
select * from Show
insert into show values 
	(10, 2018/05/02,'CDA',3),
	(20, 2018/02/04,'Som',3),
	(30, 2018/09/06,'Tes',4),
	(40, 2018/05/07,'Bauru',4),
	(50, 2018/02/08,'Franca',5),
	(160, 2018/03/09,'Poli',5)

insert into show values 
	(10, 2015/05/02,'Teste',3)

-- 10.	Liste o preço médio dos shows realizados no ano de 2015.
select AVG(valor) from Show where dt_show in(select dt_show from Show where Year(dt_show) = 1900)

--11.	Quantas canções existem no disco de código 1?


-- 12.	Qual o nome das bandas cujos discos foram produzidos pelo produtor “Fulano”?
select nome_bandas
from bandas
where 
id_banda IN (select id_banda from disco where produtor = 'Maiden')
--13.	Liste os nomes artísti
select P.id_papel [PAPEL], B.nome_bandas AS [BANDAS], M.nome_artistico AS [MUSICO] FROM Papel AS P 
INNER JOIN Musicos AS M ON P.id_musicos = M.id_musicos
INNER JOIN Bandas AS B ON B.id_banda  = B.id_banda 

-- 14.	Liste os títulos e os estúdios onde foram gravados os discos lançados após o ano 2000 e os nomes das canções que fazem parte de cada disco.
SELECT D.titulo, D.nome_estudio, ano  FROM Disco AS D
INNER JOIN CANCAO AS C On D.id_cancao = C.id_cancao where Ano > 2000

--15.	Liste os nomes de todas as bandas e os títulos dos discos que já gravaram (bandas que não gravaram discos também precisam ser listadas).
select B.nome_bandas, D.titulo from Bandas as B left join Disco AS D ON B.id_banda = D.id_banda

--16.	Quantas músicas existem nos discos lançados em 2015?
SELECT D.titulo, D.nome_estudio  FROM Disco AS D
INNER JOIN CANCAO AS C On D.id_cancao = C.id_Cancao where Ano > 2000

-- 17.	Liste os nomes dos músicos que compuseram a canção “Encontrar alguém”, juntamente com sua data de composição.
