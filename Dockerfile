FROM alpine

WORKDIR /var/www

ENV XDEBUG_MODE=off
ENV XDEBUG_CONFIG=host.docker.internal

RUN apk --update add \
    php8 \
    php8-bcmath \
    php8-dom \
    php8-ctype \
    php8-curl \
    php8-fileinfo \
    php8-fpm \
    php8-gd \
    php8-iconv \
    php8-intl \
    php8-json \
    php8-mbstring \
    php8-pecl-mcrypt \
    php8-mysqlnd \
    php8-opcache \
    php8-openssl \
    php8-pcntl \
    php8-pdo \
    php8-pdo_pgsql \
    php8-pdo_mysql \
    php8-phar \
    php8-redis \
    php8-posix \
    php8-simplexml \
    php8-session \
    php8-soap \
    php8-sockets \
    php8-tokenizer \
    php8-xml \
    php8-xmlreader \
    php8-pecl-xdebug \
    php8-xmlwriter \
    php8-zip \
    composer \
    supervisor \
    && apk add --no-cache

COPY ./conf/php.ini /etc/php8/conf.d/50-settings.ini
COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf

COPY ./conf/supervisord.conf /etc/
COPY ./start.sh /start.sh
RUN chmod 755 /start.sh

#make dir for log
# RUN mkdir -p /var/log/supervisor
#make symlink for alias php8 to php
RUN ln -sfn /usr/bin/php8 /usr/bin/php

ADD ./conf/crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt && rm /crontab.txt

EXPOSE 9000

CMD ["/bin/sh", "/start.sh"]
