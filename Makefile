VAULT_ADDR=http://localhost:8200
VAULT_TOKEN=123

.EXPORT_ALL_VARIABLES:

startup:
	docker-compose up -d --build


# =========================================
# Configure vault to manage database access
# =========================================

vault: configure-admin-cred \
	configure-database-backend \
	configure-audit-device \
	configure-database-hosts \
	configure-database-roles \
	rotate-admin-cred

configure-admin-cred:
	docker-compose exec db mysql -u root -pdev -e "CREATE USER 'admin1'@'%' IDENTIFIED BY 'admin1';GRANT ALL PRIVILEGES ON *.* TO 'admin1'@'%' WITH GRANT OPTION;"

configure-database-backend: 
	vault secrets enable database

configure-audit-device:
	vault audit enable file file_path=stdout

configure-database-hosts:
	vault write database/config/mariadb-db-admin1 \
        	plugin_name=mysql-database-plugin \
		connection_url="{{username}}:{{password}}@tcp(db:3306)/" \
		root_rotation_statements="SET PASSWORD = PASSWORD('{{password}}')" \
		allowed_roles="*" \
		username="admin1" \
		password="admin1"

configure-database-roles:
	vault write database/roles/db1-ro-role \
		db_name=mariadb-db-admin1 \
		default_ttl="1h" \
		max_ttl="24h" \
	   	creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON db1.* TO '{{name}}'@'%';" 
	vault write database/roles/db2-ro-role \
		db_name=mariadb-db-admin1 \
		default_ttl="1h" \
		max_ttl="24h" \
	   	creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON db2.* TO '{{name}}'@'%';" 

rotate-admin-cred:
	vault write -force database/rotate-root/mariadb-db-admin1

#
# Retrieve creds
#
cred-db1:
	vault read database/creds/db1-ro-role -format=json | jq .data

cred-db2:
	vault read database/creds/db2-ro-role -format=json | jq .data

show-users:
	docker-compose exec db mysql -pdev -e "select user,host,password from mysql.user;"

