-- Setup that needs to be run by a superuser.
-- See postgres_notary.sql for the setup of the schema etc.
CREATE DATABASE notary_test;
CREATE USER notary_test_user PASSWORD 'notary_test_pwd';
GRANT ALL PRIVILEGES ON DATABASE notary_test TO notary_test_user;

