#!/usr/bin/env bash

echo "Get current package references"
sudo apt-get update

echo "Install dependencies we need later on"
sudo apt-get install -y git

echo "Install MySQL with remote access enabled and create the 'silverstripe' database"
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
mysql --user='root' --password='root' --execute="CREATE DATABASE IF NOT EXISTS silverstripe DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;"
mysql --user='root' --password='root' --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
sudo service mysql restart

echo "Install nginx and PHP"
sudo apt-get install -y nginx php5-fpm php5-mysql php5-cli php5-gd
sudo sed -i 's/;catch_workers_output/catch_workers_output/g' /etc/php5/fpm/pool.d/www.conf # Log PHP errors in the general log
sudo sed -i 's/;date.timezone =/date.timezone = Europe\/Vienna/g' /etc/php5/fpm/php.ini # Set a default timezone
sudo chmod 755 /var/log/php5-fpm.log # Messed up permissions, should be readable without sudo
sudo chmod 755 /var/log/nginx/ # Messed up permissions, should be readable without sudo

echo "Enable PHP inside the nginx config"
sudo cp /vagrant/nginx/custom /etc/nginx/sites-available/default
sudo mkdir -p /var/www/
sudo service nginx restart

echo "Get Composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo composer self-update

echo "Install SilverStripe and provide a base config"
composer create-project silverstripe/installer /var/www/silverstripe-nginx
sudo chown -R www-data:www-data /var/www/silverstripe-nginx/assets/
cp /vagrant/silverstripe/_ss_environment.php /var/www/
cp /vagrant/silverstripe/_config.php /var/www/silverstripe-nginx/mysite/

echo "Initialize the installation"
wget -q http://127.0.0.1:80

printf "\n\nAll done..."
echo "You can reach the website at http://127.0.0.1:8888 — http://127.0.0.1:8888/admin credentials are admin/admin"
echo "And you can access MySQL at 127.0.0.1:8889 —  root credentials are root/root"
