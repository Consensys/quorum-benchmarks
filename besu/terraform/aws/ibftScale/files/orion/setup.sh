#!/bin/bash

echo $@ > /tmp/args.txt

ORION_VERSION=$1
ORION_DOWNLOAD_URL=$2
ORION_BOOT_NODE_IP=$3
ORION_NODE_IP=$4
ORION_CLIENT_IP=$5
SCRIPTS_DIR="/home/ubuntu/orion"

sed -i "s/PARAM_ORION_VERSION/$ORION_VERSION/g" $SCRIPTS_DIR/orion.yml
sed -i 's#PARAM_ORION_DOWNLOAD_URL#'"$ORION_DOWNLOAD_URL"'#g' $SCRIPTS_DIR/orion.yml
sed -i "s/PARAM_ORION_BOOT_NODE_IP/$ORION_BOOT_NODE_IP/g" $SCRIPTS_DIR/orion.yml
sed -i "s/PARAM_ORION_NODE_IP/$ORION_NODE_IP/g" $SCRIPTS_DIR/orion.yml
sed -i "s/PARAM_ORION_CLIENT_IP/$ORION_CLIENT_IP/g" $SCRIPTS_DIR/orion.yml

mv $SCRIPTS_DIR/log4j /opt/
chown -R ubuntu:ubuntu /opt/log4j/
mkdir /data

cd $SCRIPTS_DIR
virtualenv --python=python3 $SCRIPTS_DIR/env
. $SCRIPTS_DIR/env/bin/activate
pip install wheel
pip install -r requirements.txt

# 2x becuase I keep seeing git timeouts when download the roles
ansible-galaxy install -r requirements.yml --force --ignore-errors
ansible-galaxy install -r requirements.yml --force --ignore-errors

# start in stopped state so paths and config are created
ansible-playbook -v orion.yml --extra-vars="orion_systemd_state=stopped"

# copy keys across & set anything else up
cp -r /home/ubuntu/orion/keys/* /etc/orion/
chown -R ubuntu:ubuntu /etc/orion/

# fire up the service
systemctl start orion.service
