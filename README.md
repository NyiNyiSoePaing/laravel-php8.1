##

### Project Structure

#### The following is a structure I’ve been using for my Laravel + Docker projects.
```bash
├── docker-compose.yml
├── docker-config
│   ├── fpm-pool.conf
│   ├── nginx.conf
│   ├── php.ini
│   └── supervisord.conf
├── Dockerfile
├── laravel
└── README.md
```

### Requirements
- docker
- docker-compose

####  Before we get started, make sure you have Docker and Docker-Compose installed.

#### I have done all the work for you, just clone this repository and follow the steps mentioned below:

### Usage

```bash
git clone  https://github.com/NyiNyiSoePaing/laravle-php8.1.git

# Add your entire project files to the "web" folder,

cp -r {PROJECT_FILES} laravel

# Edit env file for laravel 
vi laravel/.env
```
> DB_DATABASE=demo 
> 
> DB_USERNAME=demo
>
> DB_PASSWORD=demo
>
> DB_HOST=database 
* *Note*  -  *DB_HOST is database service name from docker-compose.yml*


### Build and Run docker containers
```bash
bash run.sh
```
### ( or ) Manual Build and Run docker containers 
```bash
docker-compose up -d
# or 
docker-compose up --build --force-recreate -d #(recreate container)


docker exec -it laravel-app php artisan key:generate # Generate Application Key
docker exec -it laravel-app composer install # install composer
docker exec -it laravel-app chown -R www-data:www-data storage
```
*Containers created and their ports are as follows:*


> laravel-app - 'http://ip:80'

> 
> phpmyadmin - 'http://ip:8888'

## Others useful commmands
```bash
# Show running container

docker-compose ps
# or 
docker ps

# For shell login to container
docker exec -it container-name ash
# Example - docker exec -it laravel-app ash

# to stop docker
docker-compose stop/start
docker-compose down #(delete all runningcontainers,network & volumes)
```

*Feedback is appreciated.!
If you have any questions,don’t hesitate to reach out to me*
