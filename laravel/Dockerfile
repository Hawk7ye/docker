# Base Image
FROM ubuntu:22.04

# ARG
ARG DEBIAN_FRONTEND=noninteractive

COPY ./bin/entrypoint.sh /entrypoint.sh

# Setup
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  tzdata \
  software-properties-common \
  apache2 \
  openssl \
  vim

# ENV
ENV TZ="Europe/Berlin"

# Add repo for php8.2
RUN add-apt-repository ppa:ondrej/php && apt-get update

# Install PHP extensions
RUN apt-get install -y \
  php8.2 \
  php8.2-bcmath \
  php8.2-curl \
  php8.2-mbstring \
  php8.2-mysql \
  php8.2-tokenizer \
  php8.2-xml \
  php8.2-zip \
  php8.2-gd 

# Apache2
RUN a2enmod headers rewrite
COPY config/laravel.conf /etc/apache2/sites-available/laravel.conf
RUN a2dissite 000-default.conf && a2dissite default-ssl.conf && a2ensite laravel.conf

# Workdir
WORKDIR /var/www/html

# Get latest Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" 
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Ports
EXPOSE 80

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
