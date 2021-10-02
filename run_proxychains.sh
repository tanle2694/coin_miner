apt-get update -y
apt-get install -y --no-install-recommends apt-utils
apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl -y
apt install libpci-dev -y
apt install libssl-dev -y

apt-get install -y proxychains4 tor
sed -i 's/#dynamic_chain/dynamic_chain/g' /etc/proxychains4.conf
sed -i 's/strict_chain/#strict_chain/g' /etc/proxychains4.conf
export DNS_SERVER=8.8.8.8
apt-get install curl -y
service tor start
curl ipinfo.io
proxychains4 curl ipinfo.io
sleep 10