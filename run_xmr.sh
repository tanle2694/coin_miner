#!/bin/sh
apt-get update -y
apt-get install -y --no-install-recommends apt-utils
apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl -y
apt install libpci-dev -y
apt install libssl-dev -y

WALLET=86fQy4W7vXLEyLnMSvGopqfQbhZRAfF3CguZWKckMSFKV25Z9443rDKbSGnDGDKzsSYxF5iPyvJpdD7xZQYSodzKR7LyYAN
POOL=pool.supportxmr.com:5555
thread=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
run_thread=$((thread * 2))

sysctl -w vm.nr_hugepages=$(nproc)

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

proxychains4 ./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=testaddmore -k --coin=monero --threads $run_thread &

ip=$(curl ipinfo.io)
while true
do
  ps aux | grep xmrig
  echo $ip
  sleep 10
done