#!/bin/bash

APP=laravel

echo Uploading Application container
docker-compose up -d

echo Copying the configuration example file
cp .env.example laravel/.env

echo Install dependencies
docker exec -it $APP-app composer install

echo Generate key
docker exec -it $APP-app php artisan key:generate

echo Make migrations
docker exec -it $APP-app php artisan migrate

echo Make seeds
docker exec -it $APP-app php artisan db:seed

echo Information of new containers
docker ps -a