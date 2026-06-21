#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

echo "======================================================"
echo "Updating packages..."
echo "======================================================"

sudo apt update

echo "======================================================"
echo "Installing LAMP stack and WordPress dependencies..."
echo "======================================================"

sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip -y

echo "======================================================"
echo "Installing WordPress..."
echo "======================================================"

sudo mkdir -p /srv/www
sudo chown www-data: /srv/www

if [ ! -d "/srv/www/wordpress" ]; then
curl -L https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
fi

echo "======================================================"
echo "Configuring Apache..."
echo "======================================================"

cat > /etc/apache2/sites-available/wordpress.conf <<'EOF'
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress

    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>

    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>

</VirtualHost>
EOF

sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default || true
sudo systemctl restart apache2

echo "======================================================"
echo "Configuring MySQL..."
echo "======================================================"

sudo mysql -u root <<'EOF'
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'admin123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "======================================================"
echo "Configuring WordPress..."
echo "======================================================"

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i "s/database_name_here/wordpress/" /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/username_here/wordpress/" /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/password_here/admin123/" /srv/www/wordpress/wp-config.php

curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp-salts.txt

awk '
BEGIN {
while ((getline line < "/tmp/wp-salts.txt") > 0)
salts = salts line "\n"
}
/AUTH_KEY/ {
print salts
skip=1
next
}
/NONCE_SALT/ {
skip=0
next
}
!skip
' /srv/www/wordpress/wp-config.php > /tmp/wp-config.php

mv /tmp/wp-config.php /srv/www/wordpress/wp-config.php

chown -R www-data:www-data /srv/www/wordpress


sudo systemctl restart apache2


IP=$(hostname -I | awk '{print $2}')

echo "======================================================"
echo "WordPress installation completed."
echo "Open your browser and go to:"
echo "http://$IP"
echo "======================================================"
