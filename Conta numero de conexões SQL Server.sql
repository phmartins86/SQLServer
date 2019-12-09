-- Conta numero de conexões SQL Server

SELECT DB_NAME(dbid) as DBName,
	   count(dbid) as NumberOfConnections,
	   hostname,
	   loginame
FROM sys.sysprocesses
WHERE dbid > 0 
GROUP BY dbid, hostname, loginame
ORDER BY dbname