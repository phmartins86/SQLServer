-->>verificar usuários e roles SQL Server

With user_roles (login_name, role_name, login_status, login_type)                                                       
AS                                                                                                                      
(SELECT                                                                                                                 
          CASE                                                                                                          
           WHEN SSPs2.name IS NULL THEN 'Public'                                                                        
           ELSE SSPs2.name                                                                                              
          END AS role_name,                                                                                             
          SSPs.name AS login_name,                                                                                      
          Case SSPs.is_disabled                                                                                         
           When 0 Then 'Habilitado'                                                                                     
           When 1 Then 'Desabilitado'                                                                                   
          End AS login_status,                                                                                          
          SSPs.type_desc AS login_type                                                                                  
FROM sys.server_principals SSPs LEFT JOIN sys.server_role_members SSRM ON SSPs.principal_id  = SSRM.member_principal_id 
LEFT JOIN sys.server_principals SSPs2 ON SSRM.role_principal_id = SSPs2.principal_id                                    
/*WHERE SSPs2.name IS NOT NULL                                                                                          
OR SSPs.type_desc <> 'CERTIFICATE_MAPPED_LOGIN'                                                                         
AND SSPs.type_desc <> 'SERVER_ROLE'                                                                                     
AND SSPs2.name IS NULL*/)                                                                                               
                                                                                                                        
select * from user_roles                                                                                                
where 1 = 1                                                                                                             
and login_name <> 'sysadmin'                                                                                          
and login_status = 'Habilitado'                                                                                         
and login_type <> 'SERVER_ROLE' order by 2;   
                                                                                                
select name from sys.syslogins where sysadmin = 1;                                                                      
                                                                                                                        
  
With Roles (Role, Login, [User])
As
(SELECT SDPs2.name AS Role,
               SDPs1.name AS  [User],
               SL.name AS Login
FROM sys.database_principals SDPs1
Inner JOIN sys.syslogins SL ON SDPs1.sid = SL.sid  
Inner JOIN sys.database_role_members SRM ON SRM.member_principal_id = SDPs1.principal_id
Inner JOIN sys.database_principals SDPs2 ON SRM.role_principal_id = SDPs2.principal_id 
AND SDPs2.type IN ('R')
WHERE SDPs1.type IN ('S','U','G'))

Select * from Roles ORDER BY Role, Login;

select * from sys.database_principals

CREATE TABLE ##Users ([sid] varbinary(100) NULL,[Login Name] varchar(100) NULL)
CREATE TABLE ##ACESSO ([uSER ID] VARCHAR(MAX), [sERVER LOGIN] VARCHAR(MAX), [DATABASE ROLE] VARCHAR(MAX), [DATABASE] VARCHAR(MAX))

declare @cmd1 nvarchar(500)
declare @cmd2 nvarchar(500)
set @cmd1 = '
INSERT INTO ##Users ([sid],[Login Name]) SELECT sid, loginname FROM master.dbo.syslogins

INSERT INTO ##ACESSO 
SELECT su.[name] ,  
u.[Login Name]  , 
 sug.name   , ''?''
 FROM [?].[dbo].[sysusers] su 
 LEFT OUTER JOIN ##Users u 
 ON su.sid = u.sid 
 LEFT OUTER JOIN ([?].[dbo].[sysmembers] sm  
 INNER JOIN [?].[dbo].[sysusers] sug 
 ON sm.groupuid = sug.uid) 
 ON su.uid = sm.memberuid  
 WHERE su.hasdbaccess = 1 
 AND su.[name] != ''dbo''
'
exec sp_MSforeachdb @command1=@cmd1
