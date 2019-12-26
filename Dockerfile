FROM php:7.2-apache

ENV JOOMLA_INSTALLATION_DISABLE_LOCALHOST_CHECK=1

RUN a2enmod rewrite

RUN apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev zip unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install zip
 
COPY ./src /var/www/html
VOLUME /var/www/html

CMD ["apache2-foreground"]