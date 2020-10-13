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

log_info "Running benchmark worker on host $CALIPER_IP"

ssh \
  -i "$SSH_KEYFILE" \
  -o "UserKnownHostsFile=/dev/null" \
  -o "StrictHostKeyChecking=no" \
  -o "ForwardAgent=yes" \
  ubuntu@$CALIPER_IP <<EOF
cd caliperProject
./benchmark-worker.sh
EOF
