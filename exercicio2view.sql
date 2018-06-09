create database ex2view
use ex2view

create table carro(
	codCarro int constraint pk_carro primary key identity(1,1),
	modelo varchar(70) not null,
	placa varchar(30),
	cor varchar(50),
	ano datetime
)

alter table carro add constraint chk_ano check(ano > 0)

create table seguro(
	codSeguro int constraint pk_seguro primary key identity(1,1),
	nroApolice int constraint n_apolice not null check(nroApolice > 1000),
	dtValidade date,
	codCarro int constraint fk_scarro foreign key references carro(codCarro)
)

create table roubo(
	codRoubo int constraint pk_codRoubo primary key identity(1,1),
	dtOcorrencia datetime constraint dt_ocor default(getDate()) for dtOcorrencia,
	local varchar(90),
	cidade varchar(90),
	codCarro int constraint fk_carro foreign key references carro(codCarro)
)

create table recuperacao(
	codRec int constraint pk_recuperacao primary key identity(1,1),
	dtRec date,
	responsavel varchar(100),
	obs varchar(100)
)


select * from carro
insert into carro values
	('Onix', '123456','Preto',2015),
	('Corsa', '123456','Preto',2013),
	('Civic', '123456','Preto',2017),
	('Celta', '123456','Preto',2012),
	('Uno', '123456','Preto',2014),
	('KA', '123456','Preto',2016),
	('Corolla', '123456','Preto',2017),
	('Pálio', '728394','Prata',2004)

select * from seguro

insert into seguro values
	(2000,getDate(),1),
	(1200,getDate(),2),
	(2300,getDate(),3),
	(2200,getDate(),4)

select * from roubo

insert into roubo values
	(getDate(), 'Avenida Brasil', 'Franca',1),
	(getDate(), 'Av. Paulista', 'São Paulo',2),
	(getDate(), 'Centro', 'Capetinga',3),
	(getDate(), 'Pres. Vargas', 'Franca',4),
	(getDate(), 'Santo Amaro', 'São Paulo',5)

select * from recuperacao

insert into recuperacao values
	('03/04/2018','Camila', 'Está OK'),
	('07/05/2016','Jaqueline', 'Manutenção'),
	('05/07/2017','Andrea', 'Perda total')

create view vCarroRoubado
as select C.modelo from carro as C 
inner join 
roubo as R on C.codCarro = R.codCarro 
left join seguro as S
on C.codCarro = S.codCarro 

drop view vCarroRoubado

select * from vCarroRoubado

alter table recuperacao add codCarro int constraint fk_rcarro
foreign key references carro(codCarro)


create view vCroubados
as select C.modelo from carro as C 
inner join roubo as R on C.codCarro = R.codCarro
inner join recuperacao as RC on C.codCarro = RC.codCarro

UPDATE recuperacao set codCarro = 1 WHERE  codRec = 1
UPDATE recuperacao set codCarro = 2 WHERE  codRec = 2
UPDATE recuperacao set codCarro = 3 WHERE  codRec = 3

select * from vCroubados


create view vRoubosRecuperados
as select C.modelo, Re.obs from carro as C
inner join roubo as R on C.codCarro = R.codCarro
inner join recuperacao as Re on R.codRoubo = Re.codRoubo
where R.cidade = 'Franca'


select ano, count(*) as qtd from carro 
group by ano 
having count(*) > 3
