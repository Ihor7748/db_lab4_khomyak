-- Add information about new market and location simultaneously while generatin location_id
CREATE OR REPLACE PROCEDURE add_market_generating_location(
    locality_n VARCHAR,
    country_n VARCHAR,
    market_i INT,
    market_n VARCHAR,
    market_t VARCHAR,
)
LANGUAGE 'plpgsql'
AS $$
DECLARE
	max_id int := (SELECT MAX(location_id) FROM location);
BEGIN
    INSERT INTO location (location_id, locality_name, country_name)
        VALUES (max_id+1, locality_n, country_n);
    INSERT INTO market (market_id, market_name, location_id, market_type)
        VALUES (market_i, market_n, max_id+1, market_t) ;
END;
$$;
