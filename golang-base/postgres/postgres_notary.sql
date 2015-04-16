-- Setup ran by the notary_test user. Setup schema etc.

CREATE TABLE IF NOT EXISTS configuration (
       id text PRIMARY KEY,
       configuration text
);

INSERT INTO configuration (id, configuration) VALUES ('notary_configuration', '{"host":"127.0.0.1", "port":8123}');

CREATE TABLE IF NOT EXISTS key_value (key bytea PRIMARY KEY, value bytea);

-- Taken from example 40-2
-- http://www.postgresql.org/docs/9.4/static/plpgsql-control-structures.html#PLPGSQL-ERROR-TRAPPING.
DROP FUNCTION IF EXISTS merge(bytea,bytea);
CREATE OR REPLACE FUNCTION merge(k bytea, v bytea) RETURNS VOID AS
$$
BEGIN
    LOOP
        -- first try to update the key
        UPDATE key_value SET value = v WHERE key = k;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO key_value(key,value) VALUES (k, v);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- Do nothing, and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;
