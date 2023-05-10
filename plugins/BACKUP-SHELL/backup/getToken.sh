#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh


# {"auth_token":"8c28a72d-6f42-4953-9b36-658ad26ebb25"}


AUTHTOKEN=$(curl --silent -k \
   -H "Content-Type: application/json" \
   --data  '{"username": "docker", "password": "HYcARr6sBzbyWW" }' https://$UCP_URL/auth/login  \
        |perl -ne 'if(m/auth_token\":\"(\S+?)"/){print qq/$1/}')
printf "Token: %s\n" $AUTHTOKEN
