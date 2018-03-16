FROM alpine:latest

MAINTAINER Stanislaw Mnizhek <xdefrag@devjs.ru>

RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache gcc libc-dev make libtool \
    php7 php7-opcache php7-fpm php7-json php7-phar php7-iconv php7-openssl \
    php7-zlib php7-mbstring php7-simplexml php7-tokenizer php7-xmlwriter \
    php7-dom php7-xml php7-xsl php7-fileinfo php7-pdo php7-pdo_sqlite php7-pdo_pgsql \
    php7-zip php7-session php7-ctype php7-gd php7-bcmath php7-amqp php7-curl php7-xdebug \
    sqlite curl curl-dev nginx

RUN rm /usr/bin/iconv && \
    curl -SL http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz | tar -xz -C . && \
    cd libiconv-1.14 && \
    ./configure --prefix=/usr/local && \
    curl -SL https://raw.githubusercontent.com/mxe/mxe/7e231efd245996b886b501dad780761205ecf376/src/libiconv-1-fixes.patch | patch -p1 -u  && \
    make && \
    make install && \
    libtool --finish /usr/local/lib && \
    cd .. && \
    rm -rf libiconv-1.14

ENV LD_PRELOAD /usr/local/lib/preloadable_libiconv.so

RUN apk del --purge gcc libc-dev make libtool

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i -e 's/nobody/www/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i -e 's/;clear_env = no/clear_env = no/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i -e 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i -e 's/;zend/zend/g' /etc/php7/conf.d/xdebug.ini

RUN echo "xdebug.remote_enable=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9001" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_host=127.0.0.1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.profiler_enable=0" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.profiler_enable_trigger=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.profiler_output_dir=/var/arts" >> /etc/php7/conf.d/xdebug.ini

RUN addgroup -g 1000 www && \
    adduser -D -u 1000 -G www www

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/api-data /var/arts

RUN chown -R www /var/lib/nginx && \
    chown -R www /var/www && \
    chown -R www /var/arts

WORKDIR /var/www/api-data

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9000
