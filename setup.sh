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
	kubectl delete -f srcs
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
	minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-35000 --bootstrapper=kubeadm
	minikube addons enable dashboard
	minikube addons enable metrics-server
	exit
fi

eval $(minikube docker-env)
eval `minikube docker-env`

#export MINIKUBE_IP=`minikube ip`
export MINIKUBE_IP=172.17.0.2
echo "Minicube ip : $MINIKUBE_IP"

echo "Replace IP in config-file :"
cp srcs/wordpress/srcs/wp-config.php srcs/wordpress/srcs/tmp-wp-config.php
sed -i "s/IP/$MINIKUBE_IP/g" srcs/wordpress/srcs/tmp-wp-config.php
cp srcs/mysql/srcs/wordpress.sql.copy srcs/mysql/srcs/wordpress.sql
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/mysql/srcs/wordpress.sql
cp srcs/nginx/srcs/index.html srcs/nginx/srcs/tmp-index.html
sed -i "s/IP/$MINIKUBE_IP/g" srcs/nginx/srcs/tmp-index.html
cp srcs/nginx/srcs/nginx.conf.copy srcs/nginx/srcs/nginx.conf
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/nginx/srcs/nginx.conf
cp srcs/myftps.yaml.copy srcs/myftps.yaml
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/myftps.yaml
cp srcs/ftps/srcs/ftps.sh.copy srcs/ftps/srcs/ftps.sh
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/ftps/srcs/ftps.sh
cp srcs/telegraf/srcs/telegraf.conf.copy srcs/telegraf/srcs/telegraf.conf
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/telegraf/srcs/telegraf.conf
cp srcs/grafana/srcs/datasources.yaml.copy srcs/grafana/srcs/datasources.yaml
sed -i "s/MYIP/$MINIKUBE_IP/g" srcs/grafana/srcs/datasources.yaml

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

kubectl apply -f srcs/mynginx.yaml
kubectl apply -f srcs/myftps.yaml
kubectl apply -f srcs/mymysql.yaml
kubectl apply -f srcs/myphpmyadmin.yaml
kubectl apply -f srcs/mywordpress.yaml
kubectl apply -f srcs/myinfluxdb.yaml
kubectl apply -f srcs/mytelegraf.yaml
kubectl apply -f srcs/mygrafana.yaml


# kubectl exec -t nginx-75b7bfdb6b-p5vhv -i -t -- bash -il
# minikube dashboard
# minikube stop
# minikube delete
# minikube service list
