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

if [[ "$CALIPER_IP" == "" ]]; then
  log_error "Couldn't get hostname of caliper instance"
  exit 1
fi

if [[ "$1" == "" ]]; then
  log_error "Must pass file path as second argument"
  exit 1
fi

eval $(ssh-agent)

I=0
for IP in $ALL_NODE_IPS; do

  log_info "Fetching file '$1' from '${ALL_NODE_PREFIXES_ARR[$I]}'"

  rsync -e \
    "ssh -i '$SSH_KEYFILE' -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o Compression=no" \
    --rsync-path="sudo rsync" \
    -av --progress \
    "ubuntu@$IP:$1" "${ALL_NODE_PREFIXES_ARR[$I]-$(basename "$1")"
  I=$(( $I + 1 ))
done