#!/bin/sh

# Start cron
crond
# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf