FROM alpine

RUN apk update
RUN apk add wget 
RUN mkdir /www
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
COPY srcs/instal.sh /instal.sh
RUN sh /instal.sh 
RUN mkdir -p /var/www/wordpress
COPY srcs/tmp-wp-config.php /www/wordpress/wp-config.php
COPY srcs/wordpress.sh /wordpress.sh
COPY srcs/03/* /www/wordpress/wp-content/uploads/2020/03/
EXPOSE 5050 

CMD ["sh", "/wordpress.sh"]
