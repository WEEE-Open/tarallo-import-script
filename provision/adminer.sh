#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

# Always useful to have
echo "Installing Adminer..."
wget -O "$DOCUMENT_ROOT/adminer.php" https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-mysql-en.php
# wget -O "$DOCUMENT_ROOT/adminer.php" https://github.com/vrana/adminer/releases/download/v4.6.1/adminer-4.6.1-en.php
chown www-data:www-data "$DOCUMENT_ROOT/adminer.php"

echo "Allowing connections from Adminer (root/root)..."
# sudo -u postgres createuser -s root
mysql -uroot -proot -e "USE mysql; UPDATE user SET plugin='' WHERE User='root'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'root' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Comment-out if not needed
echo "Allowing direct database connections from host to guest..."
sed -i '/bind-address/s/^#//g' /etc/mysql/mariadb.conf.d/50-server.cnf
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
systemctl restart mysql
