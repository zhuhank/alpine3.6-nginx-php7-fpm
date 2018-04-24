#!/bin/sh
supervisord -c /etc/supervisord.conf \
&& crond \
&& nginx \
&& php-fpm7 \
&& top
