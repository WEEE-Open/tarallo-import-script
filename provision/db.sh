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

echo "Configuring database..."
cat << 'EOF' > "$DOCUMENT_ROOT/server/db.php"
<?php
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_DSN', 'mysql:dbname=tarallo;host=localhost;charset=utf8mb4');
EOF
