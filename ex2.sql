create database ex2
use ex2

create table funcionarios(
	codFunc int constraint pk_codFunc primary key identity(1,1),
	nomeFunc varchar(60) constraint n_func NOT NULL,
	cpf varchar(20) constraint cpf_func unique,
	rg varchar(20) constraint rg_func unique,
	sexo char(1) constraint cheSexo check(sexo in ('M', 'F')),
	categoria varchar(60) constraint categ check(categoria in ('Auxiliar', 'Supervisor', 'Terceirizado', 'Contratado', 'Coordenador')),
	idade int constraint idad check(idade between 16 and 65)
	-- codDep int constraint fk_codDep foreign key departamento(codDep)
)

create table departamento(
	codDep int not null constraint pk_codDep primary key identity(1,1),
	nomeDep varchar(60) constraint nome_dep not null,
	descDep varchar(60),
	codFunc int constraint fk_codFunc foreign key references funcionarios(codFunc) 	
)

alter table funcionarios add 
codDep int constraint fk_codDep foreign key references departamento(codDep) 
 
create table projetos(
	codProj int constraint pk_proj primary key identity(100,1),
	nomeProj varchar(70) constraint nom_proj not null,
	descProj varchar(100)
)

create table registra_participacao(
	codFunc int constraint fk_func foreign key references funcionarios(codFunc),
	codProj int constraint fk_codP foreign key references projetos(codProj),
	dt_inicio datetime constraint dt_inic default(getdate()),
	dt_fim datetime constraint dt_fim default(getdate()),
	constraint checData check(dt_inicio < dt_fim),
	constraint pk_funcproj primary key(codFunc, codProj)
)

select * from departamento
select * from funcionarios

insert into departamento(nomeDep, descDep) values
	('Contas a pagar','contas a pagar da empresa'),
	('Contas a receber','contas a receber da empresa'),
	('Faturamento', 'faturamento da empresa'),
	('Vendas','vendas da empresa'),
	('Compras', 'compras da empresa')

select * from projetos
insert into projetos values
	('Project Bartworski', 'Proteger o Chuck'),
	('Projeto 2', 'Segundo projeto'),
	('Projeto 3', 'Terceiro projeto'),
	('Projeto 4', 'Quarto projeto'),
	('Projeto 5', 'Quinto projeto')

select * from funcionarios

insert into funcionarios values
	('Chuck', '12343233445','102938473', 'M', 'Auxiliar', 36,1),
	('Joao', '17283940392','1928384638', 'M', 'Auxiliar', 29,2),
	('Jose', '91829304837','384749382', 'M', 'Supervisor', 22,3),
	('Abc', '28392812345','3843734874', 'M', 'Coordenador', 33,4),
	('Jasu', '12172637281','2837263728', 'M', 'Contratado', 45,5),
	('Mia', '92837236483','2938473927', 'M', 'Coordenador', 32,3),
	('Morc', '15827382930','2938277623', 'M', 'Contratado', 33,2),
	('Mai', '10928374637','3842536874', 'M', 'Auxiliar', 34,1),
	('Juhn', '12346527382','3890174874', 'M', 'Contratado', 39,4),
	('Leis', '83847362932','3182534874', 'M', 'Auxiliar', 40,2)