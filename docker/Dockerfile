FROM php:8.0-fpm

RUN apt-get update && apt-get install -y \
        git \
        libzip-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libonig-dev \
    && docker-php-ext-install -j$(nproc) iconv intl mbstring pdo_mysql opcache zip \
    && pecl install xdebug-3.0.2 \
    && docker-php-ext-enable xdebug

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y ppa:nginx/stable \
    && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

RUN rm /etc/nginx/sites-enabled/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./docker/php-fpm/php.ini /usr/local/etc/php/php.ini

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/conf.d/* /etc/nginx/conf.d/

COPY ./ /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

EXPOSE 80

COPY ./docker/run.sh /usr/local/bin
RUN ["chmod", "+x", "/usr/local/bin/run.sh"]

CMD ["/usr/local/bin/run.sh"]
