FROM php:7.1-apache

ADD ./000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN apt-get -y update && apt-get install -y libmcrypt-dev  \
    && docker-php-ext-install mcrypt pdo_mysql mysqli
# Install GD
RUN apt-get install zip -y
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev 
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN a2enmod rewrite


COPY ./src /var/www/html

WORKDIR /var/www/html