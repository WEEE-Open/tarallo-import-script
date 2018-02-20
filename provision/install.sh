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
