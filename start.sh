#!/bin/sh

mkdir /var/log/php-fpm && mkdir /var/log/supervisor

# Start cron
crond
# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf