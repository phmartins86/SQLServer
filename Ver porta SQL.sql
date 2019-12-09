--Ver porta SQL
select distinct local_tcp_port from sys.dm_exec_connections where local_tcp_port is not null