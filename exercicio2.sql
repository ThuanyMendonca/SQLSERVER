create database exercicio2
use exercicio2

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
	-- constraint em nivel de tabela, pois tem 2 campos
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

--10.	Vincule 3 funcionários para cada um dos projetos cadastrados
insert into registra_participacao(CodFunc, codProj) values (1,2)

alter table projetos add 
codFunc int constraint fk_ProjFunc foreign key references funcionarios(codFunc)

select * from projetos
update projetos set codFunc = 2 where codProj = 100
update projetos set codFunc = 1 where codProj = 101
update projetos set codFunc = 3 where codProj = 102

alter table funcionarios add 
salario money constraint fsalario check(salario > 500) 

insert into funcionarios values
	('Maria', '12341627345','102931625', 'F', 'Contratado', 36,1, 500)

alter table funcionarios 
drop constraint fsalario

alter table funcionarios drop column salario

-- 15.	Crie um campo para cidade do funcionário com valor padrão sendo 'Franca'
alter table funcionarios add cidade varchar(80) constraint fcidade Default('Franca')

alter table funcionarios 
drop constraint fcidade

alter table funcionarios drop column cidade


select * from funcionarios
-- 16.	Cadastre um novo funcionário sem preencher a cidade para testar sua constraint
insert into funcionarios(nomeFunc, cpf, rg, sexo, categoria, idade, codDep) values 
	('Ion', '17283974054', '1929384954', 'M', 'Auxiliar', 38, 2)

-- 17.	Crie novamente o campo para salario com suas restrições
alter table funcionarios add 
salario money constraint fsalario check(salario > 500)

-- 18.	Crie um novo projeto e vincule 5 funcionários a este projeto
alter table funcionarios add codProj int constraint fk_ProjFuncionario foreign key references projetos(codProj) 
update funcionarios set codProj = 102 where codFunc = 1
update funcionarios set codProj = 102 where codFunc = 2
update funcionarios set codProj = 102 where codFunc = 3
update funcionarios set codProj = 102 where codFunc = 4
update funcionarios set codProj = 102 where codFunc = 5

select * from funcionarios

-- 19.	Verifique se existe algum funcionário sem departamento, se houver, vincule os funcionários a algum departamento
update funcionarios set codDep = 3
update departamento set codFunc = 1 where codDep = 1
update departamento set codFunc = 3 where codDep = 2
update departamento set codFunc = 2 where codDep = 3

-- 20.	Desative a Constraint que foi criada para o campo salário e insira um novo funcionário sem preencher o salario
ALTER TABLE funcionarios NOCHECK CONSTRAINT fsalario

insert into funcionarios values 
 ('Teste', '29302912394','2736271829','F', 'Auxiliar', 21, 2, 'Franca', 101)

-- 21.	Ative novamente esta constraint do campo salario e faça o teste cadastrando um novo funcionário com salário = 0.
ALTER TABLE funcionarios CHECK CONSTRAINT fsalario
insert into funcionarios values 
 ('Teste2', '45600982394','9083271829','F', 'Auxiliar', 21, 2, 'Franca', 0,101)

-- 22.	Crie uma restrição para todos os campos Descrição de todas as tabelas que possuem um campo descrição. Esta restrição deverá inserir um valor padrão para este campo.
alter table projeto add constraint DF_descricao default ('XXX') for descricao


-- 23.	Exclua as tabelas que você criou.

