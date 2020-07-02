# docker-phpnginx
Docker image for apps with supervisord process management

Hi, this repo, extend the docker-phpfpm with supervisor to run php commands and others apps with supervisord

WORKDIR /var/www/app/

PHP Version: 7.3-fpm with unix sockets
Supervisor for process management

This image have a volumen expose for you permanent app data in the directory: /var/www/app/ -> VOLUME /var/www/app/

Expose the /var/www/app/
Expose the /etc/supervisor/conf.d/ to add new supervisor configs

You can extend this image like you desire. 
Please you can send me a message on my github channel: https://github.com/fakereto

