CREATE OR REPLACE FUNCTION test() returns table (autogen INT, manual_before INT, forced INT, manual_after INT) as
$$
DECLARE
    autogen_region_id INT;
    manualy_inserted_region_id_before_force INT;
    forced_region_id INT;
    manualy_inserted_region_id_after_force INT;
BEGIN
    INSERT INTO region(region_id, locality_name, country_name)
        VALUES (0, 'test_locality', 'test_country'),
               (3, 'test_locality2', 'test_country2');
    SELECT region_id FROM region where locality_name = 'test_locality2' limit 1
        INTO manualy_inserted_region_id_before_force;
    CALL force_region_id(3, 'test_locality3', 'test_country3');
    SELECT region_id FROM region where locality_name = 'test_locality' limit 1 
        INTO manualy_inserted_region_id_after_force;
    SELECT region_id FROM region where locality_name = 'test_locality2' limit 1
        INTO autogen_region_id;
    SELECT region_id FROM region where locality_name = 'test_locality3' limit 1
        INTO forced_region_id;
    RETURN QUERY SELECT autogen_region_id,
			manualy_inserted_region_id_before_force,
			forced_region_id,
			manualy_inserted_region_id_after_force;
END;
$$ language 'plpgsql';


SELECT * FROM test();
