chmod 777 /etc/ssl/private/pure-ftpd.pem

mkdir -p /home/admin
adduser --home /home/admin/ -D "admin"
echo "admin:admin" | chpasswd

/usr/sbin/pure-ftpd -j -Y 2 -p 21021:21021 -P "172.17.0.2"
