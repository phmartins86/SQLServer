--Mostra Database, datafile e path dos arquivos de Data
select db.name [Database]
      ,mf.name [Datafile]
	  --,CONVERT(VARCHAR,SUM(size)*8/1024)/*+' MB'*/ AS [Total disk space MB]
	  ,mf.size * 8/1024 [Size (MB)]
	  ,mf.physical_name [Path] 
from sys.master_files mf inner join 
     sys.databases db on db.database_id = mf.database_id
where mf.type_desc = 'ROWS'
group by db.name, mf.name, mf.physical_name, mf.size

----Mostra Database, datafile e path dos arquivos de Log
select db.name as 'Database'
      ,mf.name as Datafile
	  --,CONVERT(VARCHAR,SUM(size)*8/1024)/*+' MB'*/ AS [Total disk space MB]
	  ,mf.size * 8/1024 'Size (MB)'
	  ,mf.physical_name as 'Path' 
from sys.master_files mf inner join 
     sys.databases db on db.database_id = mf.database_id
where mf.type_desc = 'LOG'
group by db.name, mf.name, mf.physical_name, mf.size

	 --select * from sys.master_files