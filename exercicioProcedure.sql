create database procedure_exercicio
use procedure_exercicio

create procedure sp_quadrado
@num int
as
begin
	print @num * @num
end

exec sp_quadrado 2

alter procedure sp_quadrado
@num int
as
begin
	print 'O quadrado de ' + 
	-- Cast -> conversão de tipo de dados
	cast(@num as varchar(10)) + 
	' é: ' +
	cast(@num * @num as varchar(10))
end


-- Imprimir 2 números em ordem crescente

create procedure sp_num
@numA int,
@numB int
as
begin
	if(@numA < @numB)
	begin
		print @numA
		print @numB
	end
	else
	begin
		print @numB
		print @numA
	end
end
exec sp_num 5,3

-- Exibir data/hora
create procedure sp_dt
as
begin
	select getdate()
end

exec sp_dt

create procedure sp_hora
as
begin
	print 'Hora: ' + 
	-- Converter para varchar e pegar a hora (108)
	convert(varchar(20), getdate(), 108)
end

exec sp_hora

use pexercicio1
-- Criar a tabela primeiro

create table departamento(
	id int primary key identity(1,1),
	depto varchar(20)
)

-- Inserindo dados usando procedures
create procedure sp_inseredepto
@depto varchar(40)
as
begin
	insert into departamento(depto) values(@depto)
end


exec sp_inseredepto 'Expedicao'
exec sp_inseredepto 'Compras'
exec sp_inseredepto 'Faturamento'

select * from departamento

create procedure sp_insereFunc
@nome varchar(60),
@depto int
as
begin
	insert into funcionario values (@nome, @depto)
end

exec sp_insereFunc 'Gomes',1
exec sp_insereFunc 'Souza',2
exec sp_insereFunc 'Cesar',3

use pexercicio1
select * from salario


create procedure insereFuncionario
@valor money,
@dtPagto datetime,
@idFun int
as
begin
	insert into salario values (@valor,@dtPagto, @idFun)
end

exec insereFuncionario 1000,'10/03/2018',1
exec insereFuncionario 1000,'22/04/2018',2
exec insereFuncionario 1000,'26/06/2018',3
exec insereFuncionario 1000,'22/05/2017',4

create procedure deletaSalario
@nome varchar(60),
@dtPagto datetime
as 
begin
	-- delete from salario where ((dtPagto = @dtPagto) and idFun = (select f.idFun from funcionario f
	-- inner join salario s on f.idFun = s.idFun where f.nome = @nome and s.dtPagto = @dtPagto)) 
	delete from salario where idFun = (select idFun from funcionario where nome = @nome) and dtPagto = @dtPagto

end

exec deletaSalario 'Gomes', '22/04/2018'

-- Outro jeito de fazer o delete
/*

	declare @id int
	select @id = idFun from funcionario where nome = @nome

	delete salario where idFun = @id and dtPagto = @dtPagto
*/

select * from funcionario
create procedure atualizaFuncionario
@idFun int,
@nome varchar(60),
@idDepto int
as
begin
	update funcionario set nome = @nome, idDepto = @idDepto where idFun = @idFun
end
drop procedure atualizaFuncionario
exec atualizaFuncionario 1, 'Maria', 2

--Crie stored procedure para excluir registro de funcionários recebendo como parâmetro o nome do funcionário
create procedure excluiFuncionario
@nome varchar(60)
as 
begin
	delete from funcionario where nome = @nome
end

exec excluiFuncionario 'Maria'





	



	





