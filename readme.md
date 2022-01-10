# Lardo

Docker image for laravel(lumen) application.
Include supervisor for run queue and php-fpm. Used Alpine linux.
<hr>
## docker-compose config example

```yml
services:
  php:
  image: idleo/lardo:latest
  volumes:
    - .:/var/www  
  networks:
    - <you-network>
``` 