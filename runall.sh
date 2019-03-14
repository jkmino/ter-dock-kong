#!/bin/bash
keyroute=$1

terracom=$(whereis terraform|awk '{print $2}') 
$terracom init
$terracom apply -auto-approve
#Se extrae el DNS publico de la instacia creada
public_ip=$($terracom plan | grep "public_dns:"|awk '{print $2}'|tr -d "\"")

echo "Estableciendo conexion con instancia  IP "$public_ip

#se agrega el DNS publico en el archivo inventory.ini para ansible
touch inventory.ini
echo $public_ip > inventory.ini

ssh-keygen -f $HOME/.ssh/known_hosts -R $public_ip

#esperamos 10 segundos para que todo este correctamente funcionando.
sleep 10

#ejecutamos el playbook con la configuracion de Docker-ce y los contenedores
ansible-playbook docker_ans.yml -u ec2-user --private-key=$keyroute

#validamos los contenedores corriendo
echo "##*****CONTENEDORES LEVANTADOS EN LA INSTANCIA"
ssh -oStrictHostKeyChecking=no -i $keyroute ec2-user@$public_ip 'docker ps'
echo "\n \n"
DNS=ec2-54-70-237-197.us-west-2.compute.amazonaws.com

echo "\n*******CREANDO SERVICIO EN KONG"
curl -i -X POST --url http://$public_ip:8001/services/ --data 'name=comicbooks-service' --data 'url=http://'$public_ip':8050/comicbooks'
echo "\n "
echo "\n*******CREANDO RUTA PARA EL SERVICIO KONG"
curl -i -X POST --url http://$public_ip:8001/services/comicbooks-service/routes --data 'hosts[]='$public_ip''
echo "\n"
echo "\n*******Probando servicio"
curl -i -X GET --url http://$public_ip:8000/ --header 'Host: '$public_ip''

echo "\n \npara conectarse a la api de kong usar: http://"$public_ip":8000"