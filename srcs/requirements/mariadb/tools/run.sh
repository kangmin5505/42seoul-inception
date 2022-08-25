#! /bin/sh

if [ ! -d /run/mysqld ]; then
	mkdir -p /run/mysqld
	chown mysql:mysql /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
	sed -i "s/skip-networking/# skip-networking/g" /etc/my.cnf.d/mariadb-server.cnf
	mysqld --user=mysql --bootstrap <<-EOSQL
		FLUSH PRIVILEGES;
		USE mysql;
		DELETE FROM user WHERE user='';
		GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD' WITH GRANT OPTION;
		DROP DATABASE IF EXISTS test;
		CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8 COLLATE utf8_unicode_ci;
		CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
		GRANT ALL ON \`$DB_NAME\`.* to '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
		FLUSH PRIVILEGES;
	EOSQL
fi

exec mysqld_safe --user=mysql --datadir=/var/lib/mysql