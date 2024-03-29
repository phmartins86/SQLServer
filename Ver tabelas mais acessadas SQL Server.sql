--ver tabelas mais acessadas SQL Server

SELECT DB_NAME(A.DATABASE_ID) AS DB, B.NAME AS TB,
             SUM(A.USER_SEEKS + 
                      A.USER_SCANS + 
                      A.USER_LOOKUPS) AS TOTAL_ACESSOS
 FROM SYS.DM_DB_INDEX_USAGE_STATS A
        INNER JOIN SYS.TABLES B
                      ON B.OBJECT_ID = A.OBJECT_ID
WHERE DATABASE_ID = DB_ID('SIDTUR')
GROUP BY DATABASE_ID, B.NAME
ORDER BY SUM(A.USER_SEEKS + A.USER_SCANS + A.USER_LOOKUPS) DESC