#!/bin/bash

echo $@ > /tmp/args.txt

GANACHE_VPC_NAME=$1
GANACHE_AWS_REGION=$2

sed -i "s/PARAM_VPC_NAME/$GANACHE_VPC_NAME/g" $HOME/caliperProject/config/networkconfig.json
sed -i "s/PARAM_AWS_REGION/$GANACHE_AWS_REGION/g" $HOME/caliperProject/config/networkconfig.json
