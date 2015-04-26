#!/bin/bash
sudo date
CONTAINER=$(sudo docker run --cpuset=2,3 --cpu-shares=4 --detach=true --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro bitcoind /usr/lib/systemd/systemd)
IP=$(sudo docker inspect $CONTAINER | grep '\"IPAddress\": ' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
echo ${CONTAINER}
echo "to enter docker container run: 
        ssh bitcoin@$IP"
