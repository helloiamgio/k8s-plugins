
echo



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh

D=$(date +"%Y%m%d-%H%M")

FARM_UP=$(echo $FARM | tr [a-z] [A-Z])
pushd /home/kadmin/${FARM_UP}-UCP-bundle-client
eval "$(<env.sh)"
popd


PATH=$PATH:/usr/local/bin/


pushd /FS_K8S_Backup/GIT/

git init

cd ${FARM_UP}

sh /FS_K8S_Backup/backup/k8s-backup.sh -n app-hub
git add .
git commit -am  $D
git tag $D

# git push origin $D

popd

