#!/bin/bash
docker system prune -f -a
general/delete-all-containers.sh
general/prune-all.sh
general/create-mynet-network.sh
<<<<<<< HEAD
for i in mariadb apache redis; do
=======
for i in mariadb apache haproxy; do
>>>>>>> 0bc7b35 ({})
        cd docker-$i
        bin/build.sh
        bin/start.sh
        cd ..
done
ssh-keygen  -R '[localhost]:8022'
ssh-keyscan -p 8022 localhost >> ~/.ssh/known_hosts
