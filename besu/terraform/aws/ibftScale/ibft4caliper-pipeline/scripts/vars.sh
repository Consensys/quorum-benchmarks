#!/usr/bin/env bash

#TODO fetch additional output vars from tfstate

if [[ "$SSH_KEYFILE" == "" ]]; then
  SSH_KEYFILE="$HOME/.ssh/pantheon-dev.pem"
fi

VPC_NAME=$(jq '.resources[] | select(.type == "aws_eip") | .instances[] | select(.attributes.vpc == true) | .attributes.tags.vpc' terraform.tfstate | sed 's/"//g')

AWS_REGION=$(jq '.resources[] | select(.type == "aws_eip") | .instances[] | select(.attributes.vpc == true) | .attributes.tags.Name' terraform.tfstate | sed 's/"//g' | sed "s/$VPC_NAME-//g")

CALIPER_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "caliper") | .instances[0].attributes.public_ip' terraform.tfstate | sed 's/"//g')"
MONITORING_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "monitoring") | .instances[0].attributes.public_ip' terraform.tfstate | sed 's/"//g')"

BOOTNODE_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "ibft_bootnode") | .instances[0].attributes.public_ip' terraform.tfstate | sed 's/"//g')"
RPCNODE_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "ibft_rpcnode") | .instances[0].attributes.public_ip' terraform.tfstate | sed 's/"//g')"
NODE0_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "ibft_nodes") | .instances[0].attributes.public_ip' terraform.tfstate | sed 's/"//g')"
NODE1_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "ibft_nodes") | .instances[1].attributes.public_ip' terraform.tfstate | sed 's/"//g')"
NODE2_IP="$(jq '.resources[] | select( .type == "aws_instance" and .name == "ibft_nodes") | .instances[2].attributes.public_ip' terraform.tfstate | sed 's/"//g')"

ALL_NODE_PREFIXES="bootnode rpcnode node-0 node-1 node-2" #annoying, but this must match the ordering of the IP list in ALL_NODE_IPs
ALL_NODE_IPS="$BOOTNODE_IP $RPCNODE_IP $NODE0_IP $NODE1_IP $NODE2_IP"
ALL_IPS="$ALL_NODE_IPS $CALIPER_IP $MONITORING_IP"

ALL_NODE_PREFIXES_ARR=($ALL_NODE_PREFIXES)

BESU_MAX_HEAP_SIZE="8G"
BESU_OPTS_JFR_ESCAPED="\\\\\"-Xmx$BESU_MAX_HEAP_SIZE\\\\\" \\\\\"-XX:StartFlightRecording=disk=true,delay=15s,dumponexit=true,filename=\\/tmp\\/recording.jfr,maxsize=1024m,maxage=1d,settings=profile,path-to-gc-roots=true\\\\\""
BESU_OPTS_NOJFR_ESCAPED="-Xmx$BESU_MAX_HEAP_SIZE"
