#!/bin/bash -x

#LIST OF ARGUMENTS
# arg1 = secrets -> copy secret objects, other -> don't copy secrets

# CRON USAGE EXAMPLE
# 1 */6 * * * /home/kadmin/script/katafygio.sh secrets collaudo wso2 > /tmp/katafygio.log

export KUBECONFIG=/home/kadmin/cert-ucp/kube.yml

BCK_DIRECTORY=/home/kadmin/k8s-backup

if [ ! -d $BCK_DIRECTORY ]
then
	mkdir -p $BCK_DIRECTORY
fi	

cd $BCK_DIRECTORY
#git pull

echo "backup in progress..."

if [ $1 == "secrets" ]
then
    katafygio --no-git --dump-only --local-dir "$BCK_DIRECTORY/$(hostname)-$(date -I)"
else
    katafygio --no-git --dump-only --local-dir "$BCK_DIRECTORY/$(hostname)-$(date -I)" --exclude-kind secrets
fi;

cd "$BCK_DIRECTORY"
if [ ! -d "$BCK_DIRECTORY/$(hostname)-$(date -I)" ]
then
	echo "ERRORE NELLA CREAZIONE DIRECTORY" ; exit 1
else
	cd "$BCK_DIRECTORY"
	tar czvf $(hostname)-$(date -I).tar.gz $BCK_DIRECTORY/$(hostname)-$(date -I)
fi
