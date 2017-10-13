#!/bin/bash

set -e

URL="http://localhost:8080/tarallo/"
DOCUMENT_ROOT="/var/www/html"

export DEBIAN_FRONTEND="noninteractive"
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password root'

# Last two packages are needed by PHPUnit
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql mariadb-server-10.0 npm composer unzip php-dom php-mbstring
ln -s /usr/bin/nodejs /usr/bin/node

systemctl enable apache2
systemctl enable mysql

# Probably useless
systemctl start apache2
systemctl start mysql

# Remove root password from db:
#mysql -uroot -proot -e "SET PASSWORD = PASSWORD('');"

echo "Doing stuff with Apache..."
systemctl restart apache2
rm "$DOCUMENT_ROOT/index.html"

# Always useful to have
echo "Installing Adminer..."
wget -O "$DOCUMENT_ROOT/adminer.php" https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-mysql-en.php
chown www-data:www-data "$DOCUMENT_ROOT/adminer.php"

ln -s /tarallo-backend $DOCUMENT_ROOT/server
ln -s /tarallo-frontend $DOCUMENT_ROOT/tarallo

echo "Allowing connections from Adminer (root/root)..."
mysql -uroot -proot -e "USE mysql; UPDATE user SET plugin='' WHERE User='root'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'root' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "Importing database..."
mysql -uroot -proot -e "CREATE DATABASE tarallo DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database.sql"

echo "Importing test database..."
mysql -uroot -proot -e "CREATE DATABASE tarallo_test DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database.sql"

echo "Importing sample data..."
mysql -uroot -proot < "/data/sample-data.sql"

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

echo "T.A.R.A.L.L.O. should be up at $URL"
