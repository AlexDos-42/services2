FROM alpine:3.12.0

RUN apk update && apk upgrade
RUN apk add influxdb
COPY srcs/influxdb.conf /etc/

VOLUME ["/var/lib/influxdb"]

EXPOSE 8086

CMD influxd run -config /etc/influxdb.conf
