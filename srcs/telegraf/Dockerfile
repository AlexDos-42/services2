FROM alpine:3.12.0

RUN mkdir /etc/telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz 
RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz
RUN chmod 775 telegraf/*
RUN cp telegraf/telegraf /usr/bin/
RUN rm -rf *.tar.gz* telegraf/ 

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/telegraf.sh .

RUN chmod 775 telegraf.sh

EXPOSE 4999

ENTRYPOINT [ "./telegraf.sh" ]
