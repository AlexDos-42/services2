FROM alpine:latest

RUN apk update
RUN apk add influxdb
RUN apk add bash

EXPOSE 8086

CMD influxd run -config /etc/influxdb.conf
