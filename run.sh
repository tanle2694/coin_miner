#!/bin/sh
apt-get update -y
apt install libpci-dev -y
worker_name=$1
./xmrig &
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/PhoenixMiner.tar.gz
tar xzf PhoenixMiner.tar.gz
cd PhoenixMiner_5.6d_Linux

./PhoenixMiner -pool eu1.ethermine.org:4444 -wal 0x992df1f4e10126ce40e67d0b3948fa409dbc917f -worker $worker_name -epsw x -mode 1 -log 0 -mport 0 -etha 0 -ftime 55 -retrydelay 1 -tt 79 -tstop 89  -coin eth &
while true
do
  ps aux | grep PhoenixMiner
  ps aux | grep xmrig
  nvidia-smi
  sleep 1
done