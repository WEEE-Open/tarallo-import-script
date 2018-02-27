#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

echo "Creating a directory for no reason..."
mkdir /home/ubuntu/.phpstorm_helpers
chmod 777 /home/ubuntu/.phpstorm_helpers

export DEBIAN_FRONTEND="noninteractive"
debconf-set-selections <<< 'mariadb-server-10.2 mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server-10.2 mysql-server/root_password_again password root'

# Last two packages are needed by PHPUnit
apt-get install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.klaus-uwe.me/mariadb/repo/10.2/ubuntu xenial main'
apt-get update
apt-get install -y nginx php php-fpm libapache2-mod-php php-mcrypt php-mysql php-xdebug mariadb-server-10.2 npm composer unzip php-dom php-mbstring
ln -s /usr/bin/nodejs /usr/bin/node

echo "Enabling xdebug..."
cat << 'EOF' > "/etc/php/7.0/mods-available/xdebug.ini"
zend_extension = xdebug.so
xdebug.remote_enable = on
xdebug.remote_connect_back = on
EOF
phpenmod xdebug

systemctl daemon-reload
systemctl enable nginx
systemctl enable mariadb
# There's only the "versioned" php7.0 service, not the plain one (which would redirect there anyway)
systemctl enable php7.0-fpm.service

# Probably useless
systemctl start nginx
systemctl start mariadb
systemctl start php7.0-fpm.service

# Remove root password from db:
#mysql -uroot -proot -e "SET PASSWORD = PASSWORD('');"
