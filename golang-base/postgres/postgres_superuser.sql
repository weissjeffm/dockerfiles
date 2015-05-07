-- Setup that needs to be run by a superuser.
CREATE USER notary_test_user PASSWORD 'notary_test_pwd';
CREATE DATABASE notary_test_template;
ALTER DATABASE notary_test_template OWNER TO notary_test_user;
