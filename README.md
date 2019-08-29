# vault-database-demo

This demo focuses on how Vault can be used to manage database credentials. It ignores user access controls and how users authenticate against vault. 

## Quick Start

The following commands will use Docker Compose to launch an instance of Vault and MariaDB locally

```
make
make vault
```

Vault is running in development mode and can be accessed as follows:

```
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=123
```

Use the vault command-line to obtain database credential limited to accessing the db1 database:

```
$ vault read database/creds/db1-ro-role
Key                Value
---                -----
lease_id           database/creds/db1-ro-role/X30AkLQUo9aveiBxNFOQxMIh
lease_duration     1h
lease_renewable    true
password           A1a-eZsYkFms8cDf5xKI
username           v-token-db1-ro-rol-JIlAIGMkLMVSR
```

Another alternative is to use the REST API directly

```
$ curl -s --header "X-Vault-Token: 123" --request GET http://localhost:8200/v1/database/creds/db1-ro-role | jq .data
{
  "password": "A1a-dV0ZMxYILQgn0xAB",
  "username": "v-token-db1-ro-rol-o53YBuBY7cs4D"
}
```

One can see the new credentials appearing in the list of database users

```
$ make show-users
docker-compose exec db mysql -pdev -e "select user,host,password from mysql.user;"
+----------------------------------+-----------+-------------------------------------------+
| user                             | host      | password                                  |
+----------------------------------+-----------+-------------------------------------------+
| root                             | localhost | *27AEDA0D3A56422C3F1D20DAFF0C8109058134F3 |
| admin1                           | %         | *B2282E876FB4C74491626254639DF1EC65F54C88 |
| root                             | %         | *27AEDA0D3A56422C3F1D20DAFF0C8109058134F3 |
| v-token-db1-ro-rol-JIlAIGMkLMVSR | %         | *F7CC1C6A3C571BE44E8410CE5E721EAC881E49F0 |
| v-token-db1-ro-rol-o53YBuBY7cs4D | %         | *21A75809690A6159AEEC47E485ACAE93803E43A2 |
+----------------------------------+-----------+-------------------------------------------+
```

Verification that the generated credential can be used:

```
$ mysql -h 0.0.0.0 -u v-token-db1-ro-rol-JIlAIGMkLMVSR -pA1a-eZsYkFms8cDf5xKI 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 13
Server version: 10.3.12-MariaDB-1:10.3.12+maria~bionic mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| db1                |
| information_schema |
+--------------------+
2 rows in set (0.00 sec)

MariaDB [(none)]> use db1
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [db1]> show tables;
+-------------------+
| Tables_in_db1     |
+-------------------+
| dummy_table_one   |
| dummy_table_three |
| dummy_table_two   |
+-------------------+
3 rows in set (0.00 sec)
```

Finally all operations against vault are audit logged:

```
docker-compose logs vault
```
