FROM alpine
MAINTAINER Alex Dos Santos 

RUN apk update && apk upgrade
RUN apk add nginx 
RUN mkdir -p /run/nginx
COPY ./srcs/* /srcs/

#ssl
RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt < srcs/certificate

#ssh
RUN apk add openssh 
RUN apk add openssh-server

COPY ./srcs/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./srcs/tmp-index.html /usr/share/nginx/html/index.html
COPY ./srcs/img/* /usr/share/nginx/html/
COPY ./srcs/JQuery /usr/share/nginx/html/JQuery
COPY ./srcs/bootstrap /usr/share/nginx/html/bootstrap
COPY ./srcs/docker.sh /docker.sh

EXPOSE 80 443 30022

CMD  ["sh", "/docker.sh"]

ENTRYPOINT ["nginx", "-g", "daemon off;"]
