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

### Cleanup
apt-get autoremove
