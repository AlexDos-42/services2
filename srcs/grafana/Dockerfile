FROM alpine:latest

RUN apk update 
RUN apk add bash
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz
RUN tar -zxvf grafana-6.6.0.linux-amd64.tar.gz

COPY srcs/defaults.ini ./grafana-6.6.0/conf/
COPY srcs/grafana.db ./grafana-6.6.0/data/
COPY srcs/setup.sh .

RUN chmod +x setup.sh

EXPOSE 3000

CMD ./setup.sh