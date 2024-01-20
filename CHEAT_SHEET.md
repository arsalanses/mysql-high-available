```sql
SHOW databases;
CREATE DATABASE testDB;
use testDB;
CREATE TABLE Persons (id int NOT NULL AUTO_INCREMENT, FirstName varchar(255), PRIMARY KEY (id));
SHOW tables;
INSERT INTO Persons (FirstName) VALUES ('arsalan');
SELECT * FROM Persons;
```

```sh
find / -type f -name mysql.cnf
mysqlbinlog --no-defaults /bitnami/mysql/data/mysql-bin.000001
mysqlbinlog --no-defaults -dturnipjuice /bitnami/mysql/data/mysql-bin.000002
```

```sql
show binary logs;
FLUSH BINARY LOGS;
PURGE BINARY LOGS TO 'mysql-bin.000003';

show variables like 'server_id';
show variables like 'expire_logs_days';
show variables like 'binlog_format';
```

```sh
mysql -u$DB_USER -p$DB_PASSWORD -E --execute='show binary logs;' mysql
```
