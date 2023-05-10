#

HOSTNAME=$(hostname)

DTR=$(docker container ps -f name=dtr-registry -q)
echo $DTR
if [ -z ${DTR} ]
then
	echo "Questo script può essere eseguito solo dove è presente DTR"
	exit 1
fi 

echo "DTR presente (${DTR})...  eseguo"

DTR_VERSION=$(docker container inspect $(docker container ps -f name=dtr-registry -q) | grep -m1 -Po '(?<=DTR_VERSION=)\d.\d.\d')
REPLICA_ID=$(docker inspect -f '{{.Name}}' $(docker ps -q -f name=dtr-rethink) |cut -f 3 -d '-')


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh


# read -p 'ucp-url (The UCP URL including domain and port): ' UCP_URL; \
# read -p 'ucp-username (The UCP administrator username): ' UCP_ADMIN; \
# read -sp 'ucp password: ' UCP_PASSWORD; \

docker run --log-driver none -i --rm \
  --env UCP_PASSWORD=$UCP_PASSWORD \
  docker/dtr:$DTR_VERSION backup \
	--debug \
  --ucp-username $UCP_ADMIN \
  --ucp-url $UCP_URL \
  --ucp-ca "$(curl -k https://${UCP_URL}/ca)" \
  --existing-replica-id $REPLICA_ID > \
  $DESTDIR/dtr-metadata-${DTR_VERSION}-backup-$(date +%Y%m%d-%H_%M_%S).tar


