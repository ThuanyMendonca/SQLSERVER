create database integridade
use integridade

create table professores(
	codProf int constraint pk_codProf primary key identity(1,1),
	nome varchar(60) NOT NULL,
	rg varchar(12) unique,   --RG não pode repetir
	sexo char(1) check(sexo in('M','F')),  -- Sexo não pode ser diferente de M ou F
	idade int check (idade between 21 and 80), --Idade deve ser entre 21 e 80
	cidade varchar(50) constraint DF_Professores_cidade DEFAULT('FRANCA'), 
	titulacao varchar(15) check(titulacao in('graduado', 'especialista', 'mestre', 'doutor')),  -- DEVE INSERIR UM VALOR CADASTRADO
	categoria varchar(15) check(categoria in('auxiliar', 'assistente', 'adjunto', 'titular')), -- DEVE INSERIR UM VALOR CADASTRADO
	salario money check(salario >= 500)  -- O SALARIO DEVE SER MAIOR OU IGUAL A 500
)
select * from professores

insert into Professores(nome,rg,sexo,idade,titulacao, categoria, salario) values
	('Maria','166378','F',15,'GRADUADO', 'AUXILIAR', 850)

alter table professores
add 
	constraint ch_titulacao_salario check
(
	(titulacao = 'graduado' and salario < 1000)
	or
	(titulacao <> 'graduado')
)

insert into professores (nome, rg, sexo, idade,titulacao, categoria, salario) values
	('Ana', '11111', 'F', 30, 'graduado', 'auxiliar', 1850)

-- Ativar ou desativar uma constraint executar a seguinte instrução
alter table [nome_tabela] check constraint [nome_constraint]

alter table [nome_tabela] nocheck constraint [nome_constraint]

-- Excluindo 


-- MOSTRAR O NOME DA CONSTRAINT
select * from sys.objects
where type_desc LIKE '%CONSTRAINT%'
	AND 
	OBJECT_NAME(parent_object_id)='Professores'
	order by create_date desc

-- ou use este comando
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME 
