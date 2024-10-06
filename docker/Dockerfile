#/*
# * This file is part of kgiflwl/v2board-compose.
# *
# * kgiflwl/v2board-compose is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * kgiflwl/v2board-compose is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with kgiflwl/v2board-compose. If not, see <https://www.gnu.org/licenses/>.
# */

# Start with an official Alpine base image
FROM alpine:latest

# Install any necessary packages
RUN apk update && apk add --no-cache \
    supervisor \
    redis \
    caddy \
    bash \
    curl \
    git \
    php \
    php-zlib \
    php-xml \
    php-phar \
    php-intl \
    php-dom \
    php-xmlreader \
    php-ctype \
    php-session \
    php-mbstring \
    php-tokenizer \
    php-gd \
    php-redis \
    php-bcmath \
    php-iconv \
    php-pdo \
    php-posix \
    php-gettext \
    php-simplexml \
    php-sodium \
    php-sysvsem \
    php-fpm \
    php-mysqli \
    php-json \
    php-openssl \
    php-curl \
    php-sockets \
    php-zip \
    php-pdo_mysql \
    php-xmlwriter \
    php-opcache \
    php-gmp \
    php-pdo_sqlite \
    php-sqlite3 \
    php-pcntl \
    php-fileinfo \
    && ln -sf `ls -d /etc/php*` /etc/php \
    && ln -sf `ls /usr/sbin/php-fpm*` /usr/sbin/php-fpm

RUN mkdir -p \
    /www \
    /wwwlogs \
    /run/php \
    /run/caddy \
    /run/supervisor

# Copy application files from the local machine to the container
COPY docker/config/php-fpm.conf /etc/php/php-fpm.d/www.conf
COPY docker/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set up a working directory
WORKDIR /www

# Expose ports
EXPOSE 443/tcp 80/tcp

# Run command
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
