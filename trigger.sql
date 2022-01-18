CREATE SEQUENCE id_seq START WITH 1 INCREMENT 1;

CREATE OR REPLACE FUNCTION f_autogen_region_id() RETURNS TRIGGER AS
$$
DECLARE
	next_val INT;
BEGIN
	SELECT nextval('id_seq') into next_val;
	IF NEW.region_id >= next_val THEN
		PERFORM setval('id_seq', new.product_id+1);
	ELSIF NEW.product_id = 0 THEN
		NEW.product_id = next_val;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER autogen_region_id
	BEFORE INSERT ON region
	FOR EACH ROW
	EXECUTE PROCEDURE f_autogen_region_id();
	
	



