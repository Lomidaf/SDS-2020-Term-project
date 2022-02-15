#!/bin/bash
# Install MariaDB
cd ~
sudo apt update
sudo apt install mariadb-server -y
sudo /etc/init.d/mysql start

# Create user with remote connection
sudo mysql << EOF
CREATE USER '${database_user}'@'localhost' IDENTIFIED BY '${database_pass}';
CREATE DATABASE IF NOT EXISTS ${database_name} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES ON ${database_name}.* TO '${database_user}'@'localhost';
FLUSH PRIVILEGES;
CREATE USER '${database_user}'@'10.0.%.%' IDENTIFIED BY '${database_pass}';
GRANT ALL PRIVILEGES ON ${database_name}.* TO '${database_user}'@'10.0.%.%';
FLUSH PRIVILEGES;
quit;
EOF

# Config allow remote connection
sudo touch /etc/mysql/my.cnf
sudo chmod 777 /etc/mysql/my.cnf
cat <<- EOF > /etc/mysql/my.cnf
[mysqld]
skip-networking=0
skip-bind-address
EOF
sudo chmod 644 /etc/mysql/my.cnf
sudo systemctl restart mariadb

