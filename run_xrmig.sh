WALLET=86fQy4W7vXLEyLnMSvGopqfQbhZRAfF3CguZWKckMSFKV25Z9443rDKbSGnDGDKzsSYxF5iPyvJpdD7xZQYSodzKR7LyYAN
POOL=pool.supportxmr.com:5555
WORKER_NAME=docker
#!/bin/bash -e

# https://xmrig.com/docs/miner/hugepages#onegb-huge-pages

apt-get update -y
apt-get install -y --no-install-recommends apt-utils
apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
apt install libpci-dev -y
apt install libssl-dev -y

sysctl -w vm.nr_hugepages=$(nproc)

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

#./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --coin=monero --max-cpu-usage=75 &
#while true
#do
##  ps aux | grep darknet
#  ps aux | grep xmrig
##  nvidia-smi
#  sleep 10
#done

