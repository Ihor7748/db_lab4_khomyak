DROP TABLE IF EXISTS market CASCADE;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS product_price;
DROP SEQUENCE IF EXISTS id_seq;


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
	product_name VARCHAR(100),
	PRIMARY KEY(product_name)
);


CREATE TABLE product_price (
	product_name VARCHAR(100),
	market_id INT,
	year INT CHECK(year > 1991),
	month INT CHECK(month > 0 AND month < 13),
	price NUMERIC(32, 2),
	currency VARCHAR(3),
	units VARCHAR(20),
	PRIMARY KEY(product_name, market_id, year, month),
	CONSTRAINT fk_market
		FOREIGN KEY(market_id)
			REFERENCES market(market_id)
			ON DELETE CASCADE,
	CONSTRAINT fk_product
		FOREIGN KEY(product_name)
			REFERENCES product(product_name)
			ON DELETE CASCADE

);

CREATE SEQUENCE id_seq START WITH 1 INCREMENT 1;
