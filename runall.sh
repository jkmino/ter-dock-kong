#!/bin/bash
keyroute=$1

terracom=$(whereis terraform|awk '{print $2}') 

$terracom apply -auto-approve

public_ip=$($terracom plan | grep "public_dns:"|awk '{print $2}'|tr -d "\"")

echo "Estableciendo conexion con instancia  IP "$public_ip

touch hosts
echo $public_ip > hosts

ssh-keygen -f $HOME/.ssh/known_hosts -R $public_ip

sleep 10

ansible-playbook docker_ans.yml -u ec2-user --private-key=$keyroute

ssh -oStrictHostKeyChecking=no -i $keyroute ec2-user@$public_ip 'docker stats'

