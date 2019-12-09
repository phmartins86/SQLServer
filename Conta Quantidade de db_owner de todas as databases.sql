--Conta Quantidade de db_owner de todas as databases

IF EXISTS (SELECT * FROM TEMPDB.dbo.sysobjects WHERE NAME IN ('##Admin')) 
BEGIN
 DROP TABLE ##Admin
END
GO

CREATE TABLE ##Admin (
[database_name] varchar(100) NULL,
[role] varchar(100) NULL,
[member] varchar(100) NULL
)

insert into ##Admin
exec sp_msForEachDb ' 
use [?] 
select db_name() as [database_name], r.[name] as [role], p.[name] as [member] from  
    sys.database_role_members m 
join 
    sys.database_principals r on m.role_principal_id = r.principal_id 
join 
    sys.database_principals p on m.member_principal_id = p.principal_id 
'

select ISNULL(COUNT(*), '0') as Admins, database_name from ##Admin
where role = 'db_owner'
group by database_name
order by database_name

--Conta Quantidade de não db_owner de todas as databases

IF EXISTS (SELECT * FROM TEMPDB.dbo.sysobjects WHERE NAME IN ('##NonAdmin')) 
BEGIN
 DROP TABLE ##NonAdmin
END
GO

CREATE TABLE ##NonAdmin (
[database_name] varchar(100) NULL,
[role] varchar(100) NULL,
[member] varchar(100) NULL
)

insert into ##NonAdmin
exec sp_msForEachDb ' 
use [?] 
select db_name() as [database_name], r.[name] as [role], p.[name] as [member] from  
    sys.database_role_members m 
join 
    sys.database_principals r on m.role_principal_id = r.principal_id 
join 
    sys.database_principals p on m.member_principal_id = p.principal_id 
'

select count(*) as NonAdmins, database_name from ##NonAdmin
where role <> 'db_owner'
group by database_name
order by database_name

select COUNT(*) as total, database_name from ##NonAdmin
--where role <> 'db_owner'
group by database_name
order by database_name