#/bin/bash

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

CALIPER_SCRIPT_LOCATION=$HOME/projects/pegasys/caliper/packages/caliper-cli/caliper.js
#CALIPER_SCRIPT_LOCATION=$(which caliper)

#if [ ! -e "$CALIPER_SCRIPT_LOCATION" ]; then
  #CALIPER_SCRIPT_LOCATION="$SCRIPTDIR"/../caliper/packages/caliper-cli/caliper.js
#fi

node $CALIPER_SCRIPT_LOCATION launch master --caliper-benchconfig config/benchmark.yaml --caliper-networkconfig config/networkconfig.json --caliper-workspace "$SCRIPTDIR"
