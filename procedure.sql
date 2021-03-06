DROP PROCEDURE IF EXISTS force_region_id;

CREATE OR REPLACE PROCEDURE force_region_id(
	region_i INT,
	locality_n VARCHAR(100),
	country_n VARCHAR(100)
)
LANGUAGE 'plpgsql'
AS $$
DECLARE
	id_ INT;
	local_n VARCHAR(100);
	coun_n VARCHAR(100);
	next_val INT;
BEGIN
	IF EXISTS (SELECT region_id FROM region WHERE region_id = region_i) THEN
    	SELECT region_id, locality_name, country_name FROM region where region_id = region_i into id_, local_n, coun_n;
		SELECT nextval('id_seq') INTO next_val;
		INSERT INTO region (region_id, locality_name, country_name)
			VALUES (next_val, local_n, coun_n);
		UPDATE region 
		SET
			locality_name = locality_n,
			country_name = country_n
			WHERE region_id = region_i;
		UPDATE market
		SET
			region_id = next_val
			WHERE region_id = region_i;
    ELSE
		INSERT INTO region (region_id, locality_name, coutry_name)
			VALUES (region_i, locality_n, country_n);
	END IF;
END;
$$;
