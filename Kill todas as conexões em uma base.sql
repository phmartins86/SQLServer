-- Kill todas as conexões em uma base

USE	MASTER
GO
 
DECLARE	@Spid INT
DECLARE	@ExecSQL VARCHAR(255)
 
DECLARE	KillCursor CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR
SELECT	DISTINCT SPID
FROM	MASTER..SysProcesses
WHERE	DBID = DB_ID('master')
 
OPEN	KillCursor
 
-- Grab the first SPID
FETCH	NEXT
FROM	KillCursor
INTO	@Spid
 
WHILE	@@FETCH_STATUS = 0
	BEGIN
		SET		@ExecSQL = 'KILL ' + CAST(@Spid AS VARCHAR(50))
 
		EXEC	(@ExecSQL)
 
		-- Pull the next SPID
        FETCH	NEXT 
		FROM	KillCursor 
		INTO	@Spid  
	END
 
CLOSE	KillCursor
 
DEALLOCATE	KillCursor