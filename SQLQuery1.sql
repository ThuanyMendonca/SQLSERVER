create database teste1
go
use teste
create table teste(
	id int not null primary key,
	campoA varchar(50) not null,
	campoB varchar(50) null
)

insert into teste values(1,'Um texto qualquer', 'Outro texto')
insert into teste values(2,null, 'Novo texto')
insert into teste values(3,'Terceiro texto', 'Nova tentativa')

Begin Transaction testeTran
	begin try
		insert into teste values(10,'Um texto qualquer', 'Outro texto')
		insert into teste values(20,null, 'Novo texto')
		insert into teste values(30,'Terceiro texto', 'Nova tentativa')
	end try
	begin catch
		select error_number() as numeroErro,
			error_line() as linhaComErro,
			ERROR_MESSAGE() as mensagemErro

			if @@TRANCOUNT > 0
				rollback transaction testeTran
	end catch
if @@trancount > 0 
	commit transaction testeTran

-- Contador de transações
print @@trancount 
	begin tran
		print @@trancount
		begin tran
			print @@trancount
	commit
	print @@trancount
commit
print @@trancount


