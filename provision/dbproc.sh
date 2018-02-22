#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

echo "Importing procedures..."
mysql -uroot -proot tarallo < "$DOCUMENT_ROOT/server/database-procedures.sql"
mysql -uroot -proot tarallo_test < "$DOCUMENT_ROOT/server/database-procedures.sql"

