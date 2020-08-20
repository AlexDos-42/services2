wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-english.tar.gz -O - | tar -xz -C /www
mv /www/phpMyAdmin-4.9.2-english/* /www/phpmyadmin
chown 755 -R /www/phpmyadmin 

mkdir /etc/phpmyadmin
