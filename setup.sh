#!/bin/sh

if [ "$1" = "instal" ]
then
	echo "Instal Minikube"
	rm -rf ~/.minikube
	mkdir -p /sgoinfre/goinfre/Perso/alesanto/.minikube
	ln -sf /sgoinfre/goinfre/Perso/alesanto/.minikube ~/.minikube

#	if minikube &> /dev/null
#	then
#		brew upgrade minikube
#	else
#		brew install minikube
#	fi
#	exit
fi


if [ "$1" = "clear" ]
then
	echo "Delete containers"
	docker system prune -a
	kubectl delete -k srcs
	exit
fi

if [ "$1" = "golang" ]
then
	sudo apt remove golang-docker-credential-helpers
	exit
fi

if [ "$1" = "start" ] 
then
#	open -g -a Docker
#	echo "Start Docker-Machine"
	echo "Start minikube"
	minikube start --cpus=3 --disk-size=30000mb --memory=3000mb --extra-config=apiserver.service-node-port-range=1-35000 --bootstrapper=kubeadm
	minikube addons enable dashboard
	minikube addons enable ingress
	minikube addons enable metrics-server
	exit
fi

echo "UPDATE data_source SET url = 'http://influxdb:8086';" | sqlite3 srcs/grafana/grafana.db

eval $(minikube docker-env)
export MINIKUBE_IP=$MINIKUBE_IP
echo "Minicube ip : $MINIKUBE_IP"

echo "Replace IP in config-file :"
cp srcs/wordpress/srcs/wp-config.php srcs/wordpress/srcs/tmp-wp-config.php
sed -i "s/IP/$MINIKUBE_IP/g" srcs/wordpress/srcs/tmp-wp-config.php
cp srcs/mysql/srcs/wordpress.sql.copy srcs/mysql/srcs/wordpress.sql
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/mysql/srcs/wordpress.sql
cp srcs/nginx/srcs/index.html srcs/nginx/srcs/tmp-index.html
sed -i "s/IP/$MINIKUBE_IP/g" srcs/nginx/srcs/tmp-index.html
cp srcs/myftps.yaml.copy srcs/myftps.yaml
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/myftps.yaml

docker build -t myftps srcs/ftps
docker build -t mynginx srcs/nginx
docker build -t mygrafana srcs/grafana
docker build -t mymysql srcs/mysql
docker build -t mywordpress srcs/wordpress
docker build -t myphpmyadmin srcs/phpmyadmin
docker build -t myinfluxdb srcs/influxdb
docker build -t mytelegraf srcs/telegraf/

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f srcs/metallb.yaml

kubectl apply -k ./srcs/


# kubectl exec -t nginx-75b7bfdb6b-p5vhv -i -t -- bash -il
# minikube dashboard
# minikube stop
# minikube delete
# minikube service list
