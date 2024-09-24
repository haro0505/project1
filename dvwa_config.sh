#!/bin/bash
yum install -y httpd mariadb-server mariadb php php-mysql php-gd
systemctl start httpd mariadb
systemctl enable httpd mariadb
echo -e "\n\ntest1234\ntest1234\ny\ny\ny\ny\n" | /usr/bin/mysql_secure_installation
mysql -uroot -ptest1234 -e "create database dvwa; grant all on dvwa.* to 'dvwa'@'localhost' identified by '1234'; flush privileges;"
wget https://github.com/digininja/DVWA/archive/refs/heads/master.zip
unzip master.zip
mv DVWA-master/* /var/www/html/
mv DVWA-master/.htaccess /var/www/html/
cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php
sed -i "s/p@ssw0rd/1234/g" /var/www/html/config/config.inc.php
sed -i "s/DVWA\[ 'disable_authentication' \] = false/DVWA\[ 'disable_authentication' \] = true/g" /var/www/html/config/config.inc.php
sed -i "s/DVWA\[ 'default_security_level' \] = 'impossible'/DVWA\[ 'default_security_level' \] = 'low'/g" /var/www/html/config/config.inc.php
sed -i "s/allow_url_include = Off/allow_url_include = On/g" /etc/php.ini
chmod 777 /var/www/html/config
chmod 777 /var/www/html/hackable/uploads
chmod 666 /var/www/html/external/recaptcha/recaptchalib.php
systemctl restart httpd
