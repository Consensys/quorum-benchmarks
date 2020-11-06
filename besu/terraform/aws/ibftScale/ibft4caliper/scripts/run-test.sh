!/usr/bin/env bash

echo "init network"

terraform init && terraform validate

terraform apply -var 'vpc_name=nightly-perf-test' -var 'default_ssh_key=perf-test' -var 'caliper_version=v0.3.2' -var 'caliper_instance_type=c5.2xlarge' -var 'node_instance_type=c5d.4xlarge' -var 'rpcnode_instance_type=c5d.4xlarge' -var 'bootnode_instance_type=c5d.4xlarge' -var 'besu_version=20.10.0' <<< "yes"

#echo "waiting for the network to start"

#sleep 60

#SOURCE="${BASH_SOURCE[0]}"
#while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
#  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
#  SOURCE="$(readlink "$SOURCE")"
#  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
#done
#SCRIPTDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

#source "$SCRIPTDIR/vars.sh"
#source "$SCRIPTDIR/logging.sh"

#log_info "Running benchmark on host $CALIPER_IP"

#if [[ "$CALIPER_IP" == "" ]]; then
#  log_error "Couldn't get hostname of caliper instance"
#  exit 1
#fi

#ssh \
#  -i "$SSH_KEYFILE" \
#  -o "UserKnownHostsFile=/dev/null" \
#  -o "StrictHostKeyChecking=no" \
#  -o "ForwardAgent=yes" \
#  -o "ConnectTimeout=600" \
#  ubuntu@$CALIPER_IP <<EOF
#cd caliperProject
#./benchmark-worker.sh config/benchmark-composite-rate.yaml &
#sleep 60
#./benchmark.sh config/benchmark-composite-rate.yaml
#EOF

#echo "waiting report creation"

#sleep 10

#echo "get report"
#./scripts/get_report.sh

#echo "destroy network"

#terraform destroy -var 'vpc_name=nightly-perf-test' <<< "yes"
