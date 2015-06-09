#!/bin/sh -e

### Setup various packages.
apt-get update
apt-get install -y --no-install-recommends \
    ca-certificates \
    git


### Setup postgres database
apt-get install -y --no-install-recommends postgresql
service postgresql start

POSTGRES_CONFIG_DIR=`echo "SHOW config_file;" | sudo -u postgres psql -A -t | xargs dirname`
cp postgres/pg_hba.conf $POSTGRES_CONFIG_DIR

# Add extra config options to the standard postgresql.conf.
cat postgres/extra.conf >> $POSTGRES_CONFIG_DIR/postgresql.conf

service postgresql restart

# Run as superuser: install db, user etc.
sudo -u postgres psql < postgres/postgres_superuser.sql

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
