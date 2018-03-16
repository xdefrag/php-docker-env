#!/bin/sh

set -e

printf "Creating dirs... "
mkdir -p storage storage/public storage/framework storage/framework/sessions storage/framework/cache storage/framework/views public/docs
printf "OK\n"

printf "Initing ENV... "
cp .env.testing .env
printf "OK\n"

printf "Composer install... \n"
composer install
printf "OK\n"

printf "Initing DB... "
rm -rf database/database.sqlite
touch database/database.sqlite
printf "OK\n"

printf "Migrations... \n"
php artisan migrate --force
printf "OK\n"

printf "Seeds... \n"
php artisan db:seed
printf "OK\n"

printf "Generating docs... \n"
chmod +x generate_docs.sh
./generate_docs.sh
printf "OK\n"

printf "Changing rights for good... "
chown -R www .
printf "OK\n"

printf "PHP-FPM STARTS"
php-fpm7 -F --force-stderr &

printf "NGINX STARTS"
nginx -g 'daemon off;'
