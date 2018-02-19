#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

export DEBIAN_FRONTEND="noninteractive"
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password root'

# Last two packages are needed by PHPUnit
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql php-xdebug mariadb-server-10.0 npm composer unzip php-dom php-mbstring
# apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-pgsql php-xdebug postgresql npm composer unzip php-dom php-mbstring
ln -s /usr/bin/nodejs /usr/bin/node

systemctl enable apache2
systemctl enable mysql

# Probably useless
systemctl start apache2
systemctl start mysql

# Remove root password from db:
#mysql -uroot -proot -e "SET PASSWORD = PASSWORD('');"

echo "Doing stuff with Apache..."

cat << 'EOF' > "/etc/php/7.0/mods-available/xdebug.ini"
zend_extension = xdebug.so
xdebug.remote_enable = on
xdebug.remote_connect_back = on
xdebug.idekey = "vagrant"
EOF
cat << 'EOF' > "/etc/apache2/conf-available/allow-htacess.conf"
<Directory /var/www/html/>
	AllowOverride All
</Directory>
EOF
a2enconf "allow-htacess"
a2enmod rewrite
phpenmod xdebug
rm "$DOCUMENT_ROOT/index.html"
systemctl restart apache2

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
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
systemctl restart mysql

echo "Importing database..."
mysql -uroot -proot -e "CREATE DATABASE tarallo DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database.sql"
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database-data.sql"

echo "Same, but for test database..."
mysql -uroot -proot -e "CREATE DATABASE tarallo_test DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database.sql"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database-data.sql"

# TODO: new sample data
#echo "Importing sample data..."
#mysql -uroot -proot < "/data/sample-data.sql"

echo "Configuring database..."
cat << 'EOF' > "$DOCUMENT_ROOT/server/db.php"
<?php
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_DSN', 'mysql:dbname=tarallo;host=localhost;charset=utf8mb4');
EOF

echo "Installing dependencies (composer)..."
pushd "$DOCUMENT_ROOT/server"
composer install
popd > /dev/null 2>&1

echo "Installing dependencies (npm)..."
npm i -g grunt
pushd "$DOCUMENT_ROOT/tarallo"
npm i
grunt
echo "Running grunt watch inside of screen... (which doesn't work BECAUSE REASONS so it's pointless)"
screen -dm bash -c "grunt watch; exec sh"
popd > /dev/null 2>&1

echo "T.A.R.A.L.L.O. should be up and running"
