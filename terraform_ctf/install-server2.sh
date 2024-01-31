#!/bin/bash

set -e

dhclient
apt-get -y update
apt-get -y install gcc cloud-init git apache2 ufw
ufw default allow outgoing
ufw default deny incoming
ufw allow 80
ufw enable
mkdir /home/yoursite
mkdir /var/www/yoursite.com
mkdir /var/www/yoursite.com/public_html
chown -R $USER:$USER /var/www/yoursite.com/public_html
chmod -R 755 /var/www
git clone -b yoursite https://github.com/nthivin/ctf_winpeas.git /var/www/yoursite.com/public_html
touch /etc/apache2/sites-available/yoursite.com.conf
echo "<VirtualHost *:80>
    ServerAdmin admin@yoursite.com
    ServerName yoursite.com
    ServerAlias www.yoursite.com
    DocumentRoot /var/www/yoursite.com/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/yoursite.com.conf
cd /etc/apache2/sites-available
a2ensite yoursite.com
a2dissite 000-default.conf
systemctl reload apache2
systemctl enable apache2



