#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

echo "Importing test database..."
mysql -uroot -proot -e "DROP DATABASE IF EXISTS tarallo_test"
mysql -uroot -proot -e "CREATE DATABASE tarallo_test DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database.sql"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database-data.sql"
