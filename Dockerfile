FROM alpine:3.16

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-mysqli \
  php81-opcache \
  php81-openssl \
  php81-phar \
  php81-session \
  php81-xml \
  php81-xmlreader \
  php81-pdo \
  php81-fileinfo \
  php81-tokenizer \
  php81-xmlwriter \
  php81-xmlreader \
  php81-pdo_mysql \
  supervisor

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php81 /usr/bin/php

# Configure nginx
COPY docker-config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY docker-config/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY docker-config/php.ini /etc/php81/conf.d/custom.ini

# Configure supervisord
COPY docker-config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
# # Switch to use root user from here on
USER root
# set www-data group (82 is the standard uid/gid for www-data in Alpine)

RUN set -x ; \

  addgroup -g 82 -S www-data ; \

  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1


# Add application

COPY laravel/ /var/www/html/

# Install composer packages 
RUN composer install
RUN chown -R www-data:www-data /var/www/html /run /var/lib/nginx /var/log/nginx

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8000/fpm-ping
