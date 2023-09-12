docker-compose up -d
docker exec -it laravel-app php artisan key:generate # Generate Application Key
docker exec -it laravel-app composer install # install composer
docker exec -it laravel-app chown -R www-data:www-data storage