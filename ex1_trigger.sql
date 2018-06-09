create database ex1_trigger
go
use ex1_trigger

create table carro(
	idCarro int primary key identity(1,1),
	modelo varchar(30),
	ano int
)

create trigger trgAlerta
	on carro
	for insert
as
	print 'Um registo foi inserido'

select * from carro

insert into carro values
	('Gol', 1985),
	('Corsa', 2002),
	('Fiesta', 2010)

update carro set modelo = 'Palio' where idCarro = 4

create table cliente (
    codCli int primary key identity(1,1), 
    nome varchar(50), 
    vl_acumulado money
)
create table venda (
    codVenda int primary key identity(1,1),
    codCli int foreign key references cliente(codCli),
    dt_venda datetime,
    vl_total money, 
    vl_imposto money
)

insert into cliente 
      values ('JOAO',0),
             ('JOSE',0),
             ('ANA',0)


CREATE TRIGGER trgIns
  ON venda
  FOR INSERT
AS
  UPDATE cliente
  SET vl_acumulado = vl_acumulado + 
         (SELECT vl_total - vl_imposto FROM inserted)
  WHERE codCli = (SELECT codCli FROM inserted)

insert into venda values (1,'05/06/2018', 100,20)
insert into venda values (1,'05/06/2018', 200,40)

select * from cliente

drop trigger trgIns

alter trigger trgIns2
	on venda
	for insert
as
	declare @ClienteVenda int, @TotalVenda money
	select @ClienteVenda = codCli, 
	@TotalVenda = vl_total - vl_imposto 
	from inserted
update cliente set vl_acumulado = vl_acumulado + @TotalVenda where codCli = @ClienteVenda



insert into venda values (1,'06/06/2018',100,15)

select * from cliente


create trigger trgDel
	on venda
	for delete
as
	declare @ClienteVenda int, @TotalVenda money
	select @ClienteVenda = codCli, @TotalVenda = vl_total - vl_imposto from deleted
	update cliente set vl_acumulado = vl_acumulado - @TotalVenda where codCli = @ClienteVenda

delete from venda where codVenda = 7

select * from venda

create trigger trgAtualizaVlAcumulado
	on venda
	for update
as
	update cliente set vl_acumulado = vl_acumulado
		-(select vl_total - vl_imposto from deleted)
		+(select vl_total - vl_imposto from inserted)
		where codCli = (select codCli from deleted)
