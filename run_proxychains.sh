echo "run install"
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends apt-utils
sudo apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl -y
sudo apt install libpci-dev -y
sudo apt install libssl-dev -y

sudo apt-get install -y proxychains4 tor
sed -i 's/#dynamic_chain/dynamic_chain/g' /etc/proxychains4.conf
sed -i 's/strict_chain/#strict_chain/g' /etc/proxychains4.conf
export DNS_SERVER=8.8.8.8
sudo apt-get install curl -y
service tor start
curl ipinfo.io
proxychains4 curl ipinfo.io
sleep 10