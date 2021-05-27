#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"

while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source "$SCRIPTDIR/vars.sh"
source "$SCRIPTDIR/logging.sh"

log_info "Running benchmark on host $CALIPER_IP"



TPS_PARAM=${1:-"400"}

# create report folder
mkdir ./report


ssh \
  -o "UserKnownHostsFile=/dev/null" \
  -o "StrictHostKeyChecking=no" \
  -o "ForwardAgent=yes" \
  -o "ConnectTimeout=600" \
  ubuntu@$CALIPER_IP <<-EOF
killall node
cd caliperProject
./benchmark-worker.sh config/benchmark-register-temp-$TPS_PARAM.yaml &
sleep 40
./benchmark.sh config/benchmark-register-temp-$TPS_PARAM.yaml
EOF

sleep 10

scp \
  -o "UserKnownHostsFile=/dev/null" \
  -o "StrictHostKeyChecking=no" \
  -o "ForwardAgent=yes" \
  -o "ConnectTimeout=60" \
  ubuntu@$CALIPER_IP:/home/ubuntu/caliperProject/report.html ./report/report-$TPS_PARAM.html

I=0
for IP in $ALL_NODE_IPS; do

    scp \
      -o "UserKnownHostsFile=/dev/null" \
      -o "StrictHostKeyChecking=no" \
      -o "ForwardAgent=yes" \
      -o "ConnectTimeout=60" \
      ubuntu@$IP:/var/log/besu/besu.log ./report/log-$TPS_PARAM-${ALL_NODE_PREFIXES_ARR[$I]}.log

    I=$(( $I + 1 ))
done
