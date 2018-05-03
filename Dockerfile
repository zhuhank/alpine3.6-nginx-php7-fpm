FROM alpine:3.6

MAINTAINER Shudong Zhu <shudong@eefocus.com>
ENV PHP_VERSION=7.1.16 PHP_MEMCACHED_EXT_VERSION=3.0.8 PHP_REDIS_EXT_VERSION=4.0.0

# dependencies required for running "phpize"
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c
		
RUN echo "https://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories  \
	&&echo "https://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories  \
    && apk update \
	&& apk add --no-cache --virtual .persistent-deps ca-certificates curl tar xz  \
	&& apk add --no-cache  php7 php7-fpm nginx php7-session php7-bz2 php7-calendar  php7-zlib php7-zip php7-xml php7-sockets php7-soap php7-posix php7-phar php7-pdo_mysql php7-openssl php7-opcache php7-mysqlnd php7-mcrypt php7-mysqli php7-mbstring \
	php7-json php7-iconv php7-gd php7-gettext php7-tokenizer php7-xmlwriter php7-xmlreader php7-ctype php7-bcmath php7-dom php7-exif php7-curl php7-redis php7-xdebug php7-memcached php7-fileinfo php7-apcu supervisor dcron  tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
	&& rm -rf /tmp/pear/* \
	&& rm -rf /var/cache/apk/* \
	#&& rm -rf /etc/nginx/conf.d/* \
	&& mkdir -p /run/nginx \ 
	&& mkdir -p /var/log/supervisor \ 
	&& mkdir /etc/supervisor.d 
    
	
	
COPY start.sh /start.sh
COPY supervisor_nginx_php-fpm.ini /etc/supervisor.d
EXPOSE 80 
EXPOSE 443	 
ENTRYPOINT ["sh","/start.sh"]
