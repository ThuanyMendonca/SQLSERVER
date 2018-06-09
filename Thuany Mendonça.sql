create database bar
use bar

create table mesa(
	NroMesa int constraint pk_mesa primary key identity(1000,1) check(NroMesa < 1050),
	setor varchar(80) constraint setor_mesa check (setor in('Palco','Piso Superior','Balcão','Lounge')),
	capacidade int constraint capMesa check(capacidade <= 4),
	situacao varchar(50)
)

create table garcom(
	codGarcom int constraint pk_garcom primary key identity(1,1),
	nome varchar(100)constraint obrig not null,
	CalcularComissao char(2) constraint comissao check(CalcularComissao in('S','N')) default('N')
)

create table atendimento(
	codAtendimento int constraint pk_atendimento primary key identity(1,1),
	situacao varchar(50), 
	DtHrChegada datetime,
	NroPessoas int,
	NroMesa int constraint fk_mesa foreign key references mesa(NroMesa),
	codGarcom int constraint fk_garcom foreign key references garcom(codGarcom)
)

create table produto(
	codPro int constraint pk_produto primary key identity(1,1),
	descricao varchar(50) constraint obrigatorio not null
)

create table consumo(
	Qtde int,
	VlUnit money,
	codAtendimento int constraint fk_consAtendimento foreign key references atendimento(codAtendimento),
	codPro int constraint fk_consProduto foreign key references produto(codPro),
	constraint pk_chave primary key (codAtendimento,codPro)
)

create table pagamento(
	codPagamento int constraint pk_pagamento primary key identity(1,1),
	VlPago money constraint vl_pagamento not null check(VlPago > 0),
	codAtendimento int constraint fk_consAtend foreign key references atendimento(codAtendimento)
)

create table comida(
	codPro int constraint fk_comidaPro foreign key references produto(codPro),
	tipo varchar(50),
	preco money
)

create table bebida(
	codPro int constraint fk_comidaPro foreign key references produto(codPro),
	tipo_bebida varchar(50),
	preco_bebida money
)

alter table produto add tipo_comida varchar(100)
alter table produto add tipo_bebida varchar(100)
alter table produto add preco money

select * from produto

create view vComissoes
 as select G.CalcularComissao, G.nome, (P.VlPago * 0.03) as ComissaoPagamento from garcom
 as G inner join atendimento as A on G.codGarcom = A.codGarcom
 inner join pagamento as P on A.codAtendimento = P.codAtendimento
 where G.CalcularComissao = 'S'
 

 select * from vComissoes

create view vInfoAtendimento
as select M.NroMesa, M.capacidade, A.situacao, G.nome
from mesa as M inner join atendimento as A on M.NroMesa = A.NroMesa
inner join garcom as G on G.codGarcom = A.codGarcom
where A.situacao = 'Em atendimento'


select * from vInfoAtendimento

select COUNT(Qtde) from consumo

create view vListarProdutos 
as select P.descricao, sum(C.Qtde) as quantidade, A.DtHrChegada from produto
as P 
inner join consumo as C on P.codPro = C.codPro 
inner join atendimento as A 
on C.codAtendimento = A.codAtendimento 
where month(A.DtHrChegada) in (3) and year(A.DtHrChegada) = 2018
group by p.descricao 


create view vListarAtendimento 
as select A.NroPessoas, P.descricao, C.Qtde from atendimento
as A inner join consumo as C on A.codAtendimento = C.codAtendimento
inner join produto as P on C.codPro = P.codPro

select * from vListarAtendimento


