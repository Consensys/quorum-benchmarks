#!/bin/bash

echo $@ > /tmp/args.txt

BESU_VPC_NAME=$1
BESU_AWS_REGION=$2

sed -i "s/PARAM_VPC_NAME/$BESU_VPC_NAME/g" $HOME/caliperProject/config/networkconfig.json
sed -i "s/PARAM_AWS_REGION/$BESU_AWS_REGION/g" $HOME/caliperProject/config/networkconfig.json
