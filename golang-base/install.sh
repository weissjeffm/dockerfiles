#!/bin/sh

### Setup various packages.
apt-get update
apt-get install -y --no-install-recommends software-properties-common
add-apt-repository ppa:monetas/opentxs
apt-get update
apt-get install -y --no-install-recommends \
    libzmq3-dev \
    pkg-config


### Setup postgres database
apt-get install -y --no-install-recommends postgresql
service postgresql start

# The default pg_hba.conf forbids postgres users to connect via password.
# Override it with a file that fixes that ("local all all md5" instead of "local all all peer").
POSTGRES_CONFIG_DIR=`echo "SHOW config_file;" | sudo -u postgres psql -A -t | xargs dirname`
cp postgres/pg_hba.conf $POSTGRES_CONFIG_DIR
service postgresql restart

# Run as superuser: install db, user etc.
sudo -u postgres psql < postgres/postgres_superuser.sql
# Run as the newly created notary testuser:
# install db schema etc.
sudo -u postgres PGPASSWORD=notary_test_pwd psql notary_test notary_test_user < postgres/postgres_notary.sql


### Setup Influx and Grafana dependencies
apt-get -y --no-install-recommends install \
    supervisor \
    nginx-light \
    nodejs \
    curl

cd /opt

curl -s -o grafana-1.9.1.tar.gz http://grafanarel.s3.amazonaws.com/grafana-1.9.1.tar.gz && \
curl -s -o influxdb_0.8.8_amd64.deb http://s3.amazonaws.com/influxdb/influxdb_0.8.8_amd64.deb && \
mkdir grafana && \
tar -xzf grafana-1.9.1.tar.gz --directory grafana --strip-components=1 && \
dpkg -i influxdb_0.8.8_amd64.deb && \
echo "influxdb soft nofile unlimited" >> /etc/security/limits.conf && \
echo "influxdb hard nofile unlimited" >> /etc/security/limits.conf

### Cleanup
apt-get autoremove
