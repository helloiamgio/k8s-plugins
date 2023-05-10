
docker node inspect grpd-${FARM}-pv00 --format "{{ .ManagerStatus.Reachability }}" & \
docker node inspect grpd-${FARM}-pv01 --format "{{ .ManagerStatus.Reachability }}" & \
docker node inspect grpd-${FARM}-pv02 --format "{{ .ManagerStatus.Reachability }}" && \
echo "Un nodo è spegnibile"


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/common.sh

# /var/lib/docker/swarm
tar cvzf $DESTDIR/swarm.${H}.${D}.tgz /var/lib/docker/swarm

