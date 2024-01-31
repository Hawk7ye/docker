FROM ubuntu

# ARG
ARG DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  software-properties-common \
  apache2 \
  openssl

# Apache2
RUN a2enmod headers rewrite
COPY config/laravel.conf /etc/apache2/sites-available/laravel.conf
RUN a2dissite 000-default.conf && a2dissite default-ssl.conf && a2ensite laravel.conf

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

# Get latest Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" 
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
