DROP TABLE IF EXISTS market CASCADE;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS product_price;
DROP SEQUENCE IF EXISTS region_id_seq;


CREATE TABLE region (
	region_id INT,
	locality_name VARCHAR(100),
	country_name VARCHAR(100),
	PRIMARY KEY(region_id)
);


CREATE TABLE market (
	market_id INT,
	market_name VARCHAR(100) NOT NULL,
	region_id INT,
	market_type VARCHAR(10),
	PRIMARY KEY(market_id),
	CONSTRAINT fk_region
		FOREIGN KEY(region_id)
			REFERENCES region(region_id)
			ON DELETE SET NULL
);


CREATE TABLE product (
	product_id INT,
	product_name VARCHAR(100),
	PRIMARY KEY(product_id)
);


CREATE TABLE product_price (
	product_id INT,
	market_id INT,
	year INT CHECK(year > 1991),
	month INT CHECK(month > 0 and month < 13),
	price NUMERIC(32, 2),
	currency VARCHAR(3),
	units VARCHAR(20),
	PRIMARY KEY(product_id, market_id, year, month),
	CONSTRAINT fk_market
		FOREIGN KEY(market_id)
			REFERENCES market(market_id)
			ON DELETE CASCADE,
	CONSTRAINT fk_product
		FOREIGN KEY(product_id)
			REFERENCES product(product_id)
			ON DELETE CASCADE

);


CREATE SEQUENCE region_id_seq 
	START WITH 1 
	INCREMENT BY 1;


CREATE OR REPLACE FUNCTION f_autogen_region_id() RETURNS TRIGGER AS
$$
DECLARE
	next_val INT;
BEGIN
	SELECT nextval('region_id_seq') into next_val;
	IF NEW.region_id >= next_val THEN
		PERFORM setval('region_id_seq', new.region_id+1);
	ELSIF NEW.region_id = 0 THEN
		NEW.region_id = next_val;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER autogen_region_id
	BEFORE INSERT ON region
	FOR EACH ROW
	EXECUTE PROCEDURE f_autogen_region_id();

-- trigger autogen_region_id check
INSERT INTO region (region_id, locality_name, country_name)
	VALUES (0, 'test_locality', 'test_country');
INSERT INTO region (region_id, locality_name, country_name)
	VALUES (0, 'test_locality', 'test_country');
SELECT * from region_id_seq;
INSERT INTO region (region_id, locality_name, country_name)
	VALUES (10, 'test_locality', 'test_country');
DELETE FROM region WHERE locality_name = 'test_locality' 
					 and country_name = 'test_country';
SELECT * from region_id_seq;

