## connecting using mysql cli
```sh
mysql -h 127.0.0.1 -P33306 -uroot -p'my_root_password'
mysql -h 127.0.0.1 -P33306 -uroot -p'my_root_password' -E --execute='show binary logs;' mysql
```

## initial database and tables
```sql
SHOW databases;
CREATE DATABASE my_database;
use my_database;
CREATE TABLE Persons (id int NOT NULL AUTO_INCREMENT, FirstName varchar(255), PRIMARY KEY (id));
SHOW tables;
INSERT INTO Persons (FirstName) VALUES ('arsalan');
SELECT * FROM Persons;
```

## Restore From Binary Logs
we first need to restore the most recent full backup,
We do this by using the `mysqlbinlog` utility to view the log data for the specific database,
and piping that output to the mysql utility for the database in question.
```sh
find / -type f -name mysql.cnf

mysqlbinlog --no-defaults -dmy_database /bitnami/mysql/data/mysql-bin.000002

mysqlbinlog --no-defaults -dmy_database ./backups/log_files/26-01-2022_14-44-46.mysql-bin | mysql -uroot -p my_database
```

## manual log purge
```sql
show binary logs;
FLUSH BINARY LOGS;
PURGE BINARY LOGS TO 'mysql-bin.000003';

show variables like 'expire_logs_days';
show variables like 'binlog_format';
show variables like 'server_id';
```
