/*Script desenvolvido para levantamento do ambiente de banco de dados do MTUR*/

--Exibe o nome e o tamanho total em MB de todas as databases (somente mdf)

select db_name(database_id) as DatabaseName,
           --Name as Logical_Name,
           --Physical_Name,
           sum(size * 8) / 1024 SizeMB
    from sys.master_files
	where type_desc = 'ROWS'
	group by database_id
	
	
SELECT CONVERT(DECIMAL(10,2),(SUM(size * 8.00) / 1024.00)) As UsedSpace	FROM master.sys.master_files
	
select sum(size * 8) /1024 /1024 as GB FROM sys.master_files