create database exercicio_sp2
use exercicio_sp2

-- TABELAS
create table contribuintes(
	codContribuinte int primary key identity(1,1),
	email varchar(60),
	dtNasc datetime,
	nome varchar(100)
)

create table tributos(
	codTributos int primary key identity(1,1),
	descricao varchar(80)
)

create table pagamentos(
	codPag int primary key identity(1,1),
	dtPagto datetime,
	valor money,
	juros money,
	multa money,
	dtVencto datetime,
	codContribuinte int foreign key references contribuintes(codContribuinte),
	codTributos int foreign key references tributos(codTributos) 
)
-- PROCEDURES

-- INSERE
create procedure insereContribuintes
@email varchar(60),
@dtNasc datetime,
@nome varchar(100)

as
begin
	insert into contribuintes values(@email, @dtNasc, @nome)
end

exec insereContribuintes 'teste@teste','10/02/1990', 'Teste'

create procedure insereTributos
@descricao varchar(80)
as
begin
	insert into tributos values(@descricao)
end

exec insereTributos 'Descricao'

create procedure inserePagamentos
@dtPagto datetime,
@valor money, 
@juros money, 
@multa money,
@dtVencto datetime,
@codContribuinte int,
@codTributos int
as
begin 
	insert into pagamentos values(@dtPagto, @valor, @juros, @multa,@dtVencto,@codContribuinte,@codTributos)
end

exec inserePagamentos '21/05/2018', 50,2,4,'30/05/2018',1,1

-- UPDATE
select * from pagamentos
create procedure editaPagamentos
@codPag int,
@dtPagto datetime,
@valor money, 
@juros money, 
@multa money,
@dtVencto datetime,
@codContribuinte int,
@codTributos int
as
begin
	update pagamentos set 
	dtPagto = @dtPagto, 
	valor = @valor, 
	juros = @juros, 
	multa = @multa,
	dtVencto = @dtVencto,
	codContribuinte = @codContribuinte,
	codTributos = @codTributos
	where codPag = @codPag
end

exec editaPagamentos 1,'20/05/2018', 70,3,5,'29/06/2018',1,1
select * from pagamentos

-- c) Liquidação de um pagamento. Ela deverá receber como parâmetros o Valor da Multa e dos Juros, além da data de pagamento
create procedure liquidaPagamanento
@codPag int,
@valor money,
@multa money,
@juros money,
@dtPagto datetime
as
begin
	update pagamentos set valor = @valor, multa = @multa, juros = @juros, dtPagto = @dtPagto where codPag = @codPag
end

exec liquidaPagamanento 1,100,20,30,'25/05/2018'

-- d)	Dado um código de contribuinte, mostre o total dos pagamentos liquidados e o total dos pagamentos em aberto para ele.
create procedure totais_variaveis
@cod int
as
begin
	declare @totalPag money,
	declare @totalAb money

	select @totalPag = sum(valor) from pagamentos
	where isnull(dtPagto, '') <> '' and codContribuinte = @cod

	select @totalAb = sum(valor) from pagamentos
	where isnull(dtPagto, '') = ''
	and codContribuinte = @cod

	select @totalPag as totalpag, @totalAb as totAberto
end







