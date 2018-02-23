#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

echo "Importing database..."
mysql -uroot -proot -e "DROP DATABASE IF EXISTS tarallo"
mysql -uroot -proot -e "CREATE DATABASE tarallo DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database.sql"
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database-data.sql"

# TODO: new sample data
echo "Importing sample data..."
mysql -uroot -proot < "/data/sample-data.sql"

echo "Configuring server to use database..."
cat << 'EOF' > "$DOCUMENT_ROOT/server/db.php"
<?php
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_DSN', 'mysql:dbname=tarallo;host=localhost;charset=utf8mb4');
EOF

# Comment-out if not needed
echo "Allowing direct database connections from host to guest..."
sed -ie 's#bind-address\s*=\s*127\.0\.0\.1#bind-address=0.0.0.0#g' /etc/mysql/my.cnf
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
systemctl restart mysql
