#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh


# {"auth_token":"8c28a72d-6f42-4953-9b36-658ad26ebb25"}


AUTHTOKEN=$(curl --silent -k \
   -H "Content-Type: application/json" \
   --data  '{"username": "docker", "password": "HYcARr6sBzbyWW" }' https://$UCP_URL/auth/login  \
        |perl -ne 'if(m/auth_token\":\"(\S+?)"/){print qq/$1/}')


DEST_TMP=/FS_K8S_Backup/tmp

curl -sk -H "Authorization: Bearer $AUTHTOKEN" https://$UCP_URL/api/ucp/backup \
   -X POST \
   -H "Content-Type: application/json" \
   --data  '{"encrypted": true, "includeLogs": true, "fileName": "backup-UCP-'${D}'.tar", "logFileName": "backup-UCP-'${D}'.log", "hostPath": "'${DEST_TMP}'", "passphrase": "almeno12caratteri"}'


echo attendo termine esecuzione backup
sleep 120

echo copio
mv $DEST_TMP/backup-UCP-* $DESTDIR/

echo terminato
