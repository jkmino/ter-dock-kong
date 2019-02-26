#!/bin/bash
terracom=$(whereis terraform|awk '{print $2}') 

public_ip=$($terracom plan | grep "public_ip:"|awk '{print $2}'|tr -d "\"")

echo "Estableciendo conexion con instancia  IP="$public_ip

