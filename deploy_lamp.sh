#!/bin/bash

# Define variables
APP_REPO="https://github.com/laravel/laravel.git"
APP_DIR="/var/www/laravel"
DB_NAME="laravel_db"
DB_USER="laravel_user"
DB_PASSWORD="password"

# Update package lists
apt-get update

# Install Apache, MySQL, and PHP
apt-get install -y apache2 mysql-server php php-mysqli

# Create database
mysql -u root -p -e "CREATE DATABASE $DB_NAME"

# Create database user
mysql -u root -p -e "CREATE USER $DB_USER IDENTIFIED BY '$DB_PASSWORD'"

# Grant user privileges
mysql -u root -p -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@localhost"

# Enable modules
a2enmod rewrite

# Configure virtual host
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/laravel.conf
sed -i "s/DocumentRoot.*/DocumentRoot $APP_DIR/public/" /etc/apache2/sites-available/laravel.conf

# Enable virtual host and restart Apache
a2ensite laravel.conf
systemctl restart apache2

# Clone application from GitHub
git clone $APP_REPO $APP_DIR

# Set ownership of application directory
chown -R www-data:www-data $APP_DIR

# Composer install (if using Laravel)
cd $APP_DIR
composer install

# Grant permissions for storage directory (if using Laravel)
chmod -R 775 $APP_DIR/storage

# Restart Apache again (optional)
systemctl restart apache2
