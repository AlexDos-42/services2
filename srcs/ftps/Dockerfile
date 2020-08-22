FROM alpine:3.12.0

RUN apk update
RUN apk --no-cache add vsftpd
RUN touch /var/log/vsftpd.log

COPY srcs/ftps.sh /tmp/
RUN apk add pure-ftpd --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/
RUN apk add openssl
COPY srcs/pure-ftpd.pem /etc/ssl/private/

EXPOSE 21 21021 

ENTRYPOINT ["sh", "/tmp/ftps.sh"]