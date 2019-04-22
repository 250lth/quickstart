#!/bin/bash
user=$EUID
if [ "${user}" != "0" ]; then
  echo
  echo "$0 must be run as root - you are running as $EUID"
  echo
  exit 1
fi
echo
echo "About to destroy Rancher 2.x install"
echo "5s to cancel with ^c"
echo
sleep 5

containers=$(docker ps -aq)
if [ "${containers}x" != "x" ]
then
  docker rm -f $(docker ps -qa)
else
  echo "No running containers - ignoring docker rm"
fi

volumes=$(docker volume ls -q)
if [ "${volumes}x" != "x" ]
then
  docker volume rm $(docker volume ls -q)
else
  echo "No volumes - ignoring docker volume rm"
fi

cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /opt/rke"
for dir in $cleanupdirs; do
  echo "Removing $dir"
  rm -rf $dir
done
