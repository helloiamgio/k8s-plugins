
echo

D=$(date +"%Y%m%d-%H%M")

pushd /home/kadmin/KB1-UCP-bundle-client
eval "$(<env.sh)"
popd


PATH=$PATH:/usr/local/bin/

pushd /FS_K8S_Backup/GIT

git init

# git cloen ...

sh /FS_K8S_Backup/backup/k8s-backup.sh -n app-hub
git add .
git commit -am  $D
git tag $D

# git push origin $D

popd

