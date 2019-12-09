--Numero de conexões por database
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame


--Total de conexões ativas na instância
SELECT 
    COUNT(dbid) as TotalConnections
FROM
    sys.sysprocesses
WHERE 
    dbid > 0