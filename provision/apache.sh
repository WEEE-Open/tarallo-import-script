echo "Configuring Apache..."

cat << 'EOF' > "/etc/php/7.0/mods-available/xdebug.ini"
zend_extension = xdebug.so
xdebug.remote_enable = on
xdebug.remote_connect_back = on
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

cat << 'EOF' > "/etc/apache2/sites-available/tarallo-server.conf"
Listen 80
<VirtualHost *:80>
    DocumentRoot "/var/www/html/server"
</VirtualHost>
EOF

cat << 'EOF' > "/etc/apache2/sites-available/tarallo-admin.conf"
Listen 81
<VirtualHost *:81>
    DocumentRoot "/var/www/html/admin"
</VirtualHost>
EOF

a2dissite 000-default
a2ensite tarallo-server
a2ensite tarallo-admin

echo "Restarting Apache..."

systemctl restart apache2
