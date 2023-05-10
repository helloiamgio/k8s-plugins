
pushd /home/kadmin/KB1-UCP-bundle-client
eval "$(<env.sh)"
popd


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh

echo "-->" $BASEDIR


