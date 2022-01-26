FROM alpine

WORKDIR /var/www

# Set config for xdebug
ENV XDEBUG_MODE=off
ENV XDEBUG_CONFIG=host.docker.internal

# Install php and supervisor
RUN apk --no-cache add \
    php8 \
    php8-common \
    php8-fpm \
    php8-pdo \
    php8-opcache \
    php8-zip \
    php8-phar \
    php8-iconv \
    php8-cli \
    php8-curl \
    php8-openssl \
    php8-mbstring \
    php8-tokenizer \
    php8-fileinfo \
    php8-json \
    php8-xml \
    php8-xmlwriter \
    php8-simplexml \
    php8-dom \
    php8-pdo_mysql \
    php8-pdo_pgsql \
    php8-pdo_sqlite \
    php8-tokenizer \
    php8-pecl-redis \
    php8-pecl-xdebug \
    supervisor

# PHP config
COPY ./conf/php.ini /etc/php8/conf.d/50-settings.ini
COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
#make symlink for alias php8 to php
RUN ln -sfn /usr/bin/php8 /usr/bin/php

# Make rquired dirs
RUN mkdir /var/log/php-fpm && mkdir /var/log/supervisor && mkdir /etc/supervisor.d/ \
    && mkdir /var/log/xdebug

# Configure supervisor
COPY ./conf/supervisord.conf /etc/supervisor/supervisord.conf

# Configure cron
COPY ./conf/crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt && rm /crontab.txt

# Tell docker that all future commands should run as the appuser user
EXPOSE 9000
ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf" ]
