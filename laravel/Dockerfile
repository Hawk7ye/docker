# Base Image
FROM ubuntu:24.04

MAINTAINER maintainer@example.com

# ARG
ARG DEBIAN_FRONTEND=noninteractive

# Add scripts
COPY ./bin/entrypoint.sh /entrypoint.sh

# Setup
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  tzdata \
  software-properties-common \
  curl \
  apache2 \
  openssl \
  vim

# ENV
ENV TZ="Europe/Berlin"

# Add repo for PHP
RUN add-apt-repository ppa:ondrej/php && apt-get update

# Install PHP extensions
RUN apt-get install -y \
  php8.3 \
  php8.3-bcmath \
  php8.3-curl \
  php8.3-mbstring \
  php8.3-mysql \
  php8.3-tokenizer \
  php8.3-xml \
  php8.3-zip \
  php8.3-gd

# Apache2
RUN a2enmod headers rewrite deflate
COPY config/laravel.conf /etc/apache2/sites-available/laravel.conf
RUN a2dissite 000-default.conf && a2dissite default-ssl.conf && a2ensite laravel.conf

# Workdir
WORKDIR /var/www/html

# Get latest Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Ports
EXPOSE 80

# Healthcheck
HEALTHCHECK --interval=5s --timeout=3s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:80 || exit 1

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
