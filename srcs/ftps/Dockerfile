FROM alpine:3.12.0

RUN apk update
RUN apk --no-cache add vsftpd
RUN apk add bash 
RUN touch /var/log/vsftpd.log

COPY srcs/ftps.sh /bin/ftps.sh
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21 21021 
VOLUME /ftp/ftp

RUN chmod 775 /bin/ftps.sh

ENTRYPOINT ["sh", "/bin/ftps.sh"]