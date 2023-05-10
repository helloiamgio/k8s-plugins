
# /var/lib/docker/swarm
H=$(hostname)
D=$(date +"%Y%m%d")
FARM=$(hostname | perl -ne 'if(m/\w{4}-(kb\d)-\w{2}\d{2}/) { print qq/$1\n/ }')

if [ -z ${FARM+x} ]
then 
	echo "farm is unset" 

	exit
else 
	echo "farm is set to '$FARM'"; 

fi

BASEDIR=/FS_K8S_Backup
DESTDIR=${BASEDIR}/bck/${FARM}/$D/

UCP_URL=multichannel-ucp-${FARM}.gribankprd.dmz
UCP_ADMIN=docker
UCP_PASSWORD=HYcARr6sBzbyWW


mkdir -p $DESTDIR

