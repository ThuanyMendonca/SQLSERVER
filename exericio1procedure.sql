-- Primeiro exercicio de Procedure
create database pexercicio1

use pexercicio1

create procedure sp_sayHello
as 
begin
	print 'Hello World'
end

-- Para executar a procedure:
exec sp_sayHello

create table departamento(
  idDepto int constraint pk_depto primary key identity(1,1),
  depto varchar(40) NOT NULL
)

create table funcionario(
  idFun int constraint pk_fun primary key identity(1,1),
  nome varchar(60) NOT NULL,
  idDepto int constraint fk_fun_depto foreign key references departamento(idDepto)
)

create table salario(
  idSalario int constraint pk_salario primary key identity(1,1),
  valor money constraint chkValor check(valor > 0),
  dtPagto datetime,
  idFun int constraint fk_sal_fun foreign key references funcionario(idFun)
)

insert into departamento values
	('LOGISTICA')

insert into funcionario values
	('AUGUSTO',1)

set dateformat dmy

insert into salario(dtPagto, valor, idFun) 
values
	('25/JAN/2014', 2050.49,1),
	('15/FEV/2014', 2534.00,1),
	('18/MAR/2014', 1998.40,1)

create procedure sp_selecionaDepartamentos
as
begin
	select * from Departamento
end

exec sp_selecionaDepartamentos

alter procedure sp_selecionaDepartamentos
@id int 
as 
begin
	select * from departamento
	where idDepto = @id
end

exec sp_selecionaDepartamentos 4

-- Com JOIN
alter procedure sp_selecionaDepartamentos
@id int 
as 
begin
	select
		F.nome as Empregado, D.depto as Setor
		from funcionario F inner join departamento D
		ON F.idDepto = D.idDepto
		where D.idDepto = @id
end

exec sp_selecionaDepartamentos 4


create procedure sp_sayHelloNome
@nome varchar(50),
@sexo varchar(1)

as
begin
	if @sexo = 'F'
		print 'Olá ' + @nome + ' seja bem-vinda'
	else 
		print 'Olá ' + @nome + ' seja bem-vindo'
end 

exec sp_sayHelloNome ' Fulano ', 'M'


