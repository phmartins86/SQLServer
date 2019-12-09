/*Script desenvolvido para levantamento do ambiente de banco de dados do MTUR*/

--Faz a contagem de todas as databases da instancia
select count(database_id) TotalDB 
from 
	(select distinct database_id 
	from sys.master_files) as teste
go
--Faz a contagem de todas as databases online
select count(database_id) 'Online' 
from 
	(select distinct database_id 
	from sys.master_files 
	where state_desc = 'ONLINE') as teste
go
--Faz a contagem de todas as databases offline
select count(database_id) 'Offline' from 
	(select distinct database_id 
	from sys.master_files 
	where state_desc = 'OFFLINE') as teste
go
--Traz a soma do tamanho de todas as bases da instância
select sum(SizeMB) TotalMB
from (
    select db_name(database_id) as DatabaseName,
           Name as Logical_Name,
           Physical_Name,
           (size * 8) / 1024 SizeMB
    from sys.master_files) as TEMP
go
--Traz todos os logins da instancia
select count(name) as TotalLogins from syslogins
go
--Traz todos os logins não sysadmin da instancia
SELECT count(name) as NonSysadmin FROM syslogins where sysadmin = 0 --order by name
go
--Traz todos os logins sysadmin da instancia
SELECT count(name) as SysAdmin FROM syslogins where sysadmin = 1 --order by name