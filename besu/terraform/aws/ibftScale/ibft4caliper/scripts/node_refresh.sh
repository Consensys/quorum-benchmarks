#!/usr/bin/env bash

# resolve the directory that contains this script we have to jump through a few
# hoops for this because the usual one-liners for this don't work if the script
# is a symlink
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source "$SCRIPTDIR/vars.sh"
source "$SCRIPTDIR/logging.sh"

eval $(ssh-agent)

#TODO - read node count from tfstate

terraform taint aws_instance.ibft_bootnode
terraform taint aws_instance.ibft_rpcnode
terraform taint aws_instance.ibft_nodes[2]
terraform taint aws_instance.ibft_nodes[1]
terraform taint aws_instance.ibft_nodes[0]

terraform apply -auto-approve

