FROM alpine
MAINTAINER Alex Dos Santos 

RUN apk update 
RUN apk add nginx 
RUN apk add bash
RUN mkdir -p /run/nginx
COPY ./srcs/* /srcs/

#ssl
RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt < srcs/certificate

#ssh
RUN apk add --update openssh 
RUN apk add openssh-server

RUN rm /etc/nginx/nginx.conf
COPY ./srcs/nginx.conf /etc/nginx/nginx.conf

COPY ./srcs/tmp-index.html /usr/share/nginx/html/index.html
COPY ./srcs/img/* /usr/share/nginx/html/
COPY ./srcs/JQuery /usr/share/nginx/html/JQuery
COPY ./srcs/bootstrap /usr/share/nginx/html/bootstrap
COPY ./srcs/docker.sh /docker.sh

CMD  ["sh", "/docker.sh"]

EXPOSE 80 443 22

ENTRYPOINT ["nginx", "-g", "daemon off;"]
