From alpine
MAINTAINER Alex Dos Santos <alesantostudent.42.fr>

RUN apk update
RUN apk add mariadb mariadb-client
RUN apk add --update mysql-client
RUN apk add bash
RUN apk add wget
RUN apk add curl

COPY ./srcs/ . 

RUN chmod 777 ./doboth.sh
RUN chmod 777 ./db.sh
RUN chmod 777 ./init.sh

EXPOSE 3306

CMD ["sh", "./doboth.sh"]
