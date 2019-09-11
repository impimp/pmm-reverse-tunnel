#!/usr/bin/bash -x

echo "Connecting to server ${HOST}, to expose ${HOSTS} on PMM Instance ${PMM} within time-range ${timerange}."
echo

sed -i "s#__PMM_URL__#${PMM}#g" /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx

nginx&

ssh -N -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i id_rsa -R 0.0.0.0:4242:localhost:80 ${HOST} -l root &

sleep 10;

while /bin/true; do
	tail -f /var/log/nginx/*;
done;
