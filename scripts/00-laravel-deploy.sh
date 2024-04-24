#!/usr/bin/env bash
echo "Running composer"
composer global require hirak/prestissimo
composer install --optimize-autoloader --no-dev --working-dir=/var/www/html
npm install && npm run build --prefix /var/www/html

php artisan optimize
php artisan optimize:clear

#echo "generating application key..."
#php artisan key:generate --show

echo "Caching config..."
php artisan config:cache

echo "Caching views..."
php artisan event:cache

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
php artisan migrate --force
