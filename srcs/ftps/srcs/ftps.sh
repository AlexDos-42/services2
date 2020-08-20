#!/bin/sh

grep '/ftp/' /etc/passwd | cut -d':' -f1 | xargs -n1 deluser

if [ -z "$USERS" ]; then
  USERS="alsanto|admin"
fi

for i in $USERS ; do
    NAME=$(echo $i | cut -d'|' -f1)
    PASS=$(echo $i | cut -d'|' -f2)
  FOLDER=$(echo $i | cut -d'|' -f3)
     UID=$(echo $i | cut -d'|' -f4)

  if [ -z "$FOLDER" ]; then
    FOLDER="/ftp/$NAME"
  fi

  if [ ! -z "$UID" ]; then
    UID_OPT="-u $UID"
  fi

  echo -e "$PASS\n$PASS" | adduser -h $FOLDER -s /sbin/nologin $UID_OPT $NAME
  mkdir -p $FOLDER
  chown $NAME:$NAME $FOLDER
  unset NAME PASS FOLDER UID
done


if [ -z "$MIN_PORT" ]; then
  MIN_PORT=21021
fi

if [ -z "$MAX_PORT" ]; then
  MAX_PORT=21021
fi

if [ ! -z "$ADDRESS" ]; then
  ADDR_OPT="-opasv_address=$ADDRESS"
fi

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
#vsFTPd does not support loggin to stdout, use tail instead
exec tail -F /var/log/vsftpd.log
