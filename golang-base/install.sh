apt-get update
apt-get install -y --no-install-recommends software-properties-common
add-apt-repository ppa:monetas/opentxs
apt-get update
apt-get install -y --no-install-recommends \
    libzmq3-dev \
    pkg-config
apt-get autoremove
