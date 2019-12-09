-->> Usuarios com acesso a database
With user_acesso ([uSER ID] , [sERVER LOGIN] , [DATABASE])
AS
(
SELECT [uSER ID] , [sERVER LOGIN] , [DATABASE]  FROM ##ACESSO
GROUP BY 
[uSER ID] , [sERVER LOGIN] , [DATABASE] 
)
select @@servername as [INSTÂNCIA], [DATABASE], count(1) AS [QTD USUARIOS] from  user_acesso GROUP BY [DATABASE] order by  [INSTÂNCIA]