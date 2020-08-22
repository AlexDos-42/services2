FROM alpine:3.12.0
MAINTAINER Alex Dos Santos 

RUN apk update && apk upgrade
RUN apk add nginx 
RUN mkdir -p /run/nginx
COPY ./srcs/* /srcs/

COPY /srcs/nginx.conf /etc/nginx/conf.d/default.conf

#ssh
RUN apk add openssh 

#ssl
RUN apk add openssl
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

COPY ./srcs/tmp-index.html /usr/share/nginx/html/index.html
COPY ./srcs/img/* /usr/share/nginx/html/
COPY ./srcs/JQuery /usr/share/nginx/html/JQuery
COPY ./srcs/bootstrap /usr/share/nginx/html/bootstrap
COPY ./srcs/docker.sh /docker.sh

EXPOSE 80 443 30022

ENTRYPOINT ["sh", "/docker.sh"]