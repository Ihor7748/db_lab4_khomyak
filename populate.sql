INSERT INTO region(region_id, locality_name, country_name)
VALUES
	(3, 'Fatick','Senegal'),
	(48, NULL, 'Ukraine'),
	(47, NULL, 'Ukraine'),
	(81, NULL, 'Ukraine'),
	(4842, 'Badakhshan', 'Afghanistan'),
	(5, 'Midlands', 'Zimbabwe');

INSERT INTO market(market_id, market_name, region_id, market_type)
	VALUES
		(1, 'National Average', 3, 'Retail'),
		(1871, 'Lviv', 48, 'Retail'),
		(411, 'Diakhao', 3, 'Retail'),
		( 266, 'Fayzabad', 4842, 'Retail'),
		(3690, 'Badakhshan',4842,'Retail');
INSERT INTO product(product_name)
VALUES
	('Potatoes - Retail'),
	('Bread (rye) - Retail'),
	('Meat (chicken, whole) - Retail'),
	('Wheat flour (first grade) - Retail');

INSERT INTO product_price(product_name, market_id, year, month, price, currency, units)
VALUES
	('Potatoes - Retail', 1871, 2017, 4, 5.86, 'UAH', 'KG'),
	('Bread (rye) - Retail', 1871, 2016, 7, 10.29,'UAH', 'Loaf'),
	('Potatoes - Retail', 1871, 2017, 11, 4.49, 'UAH','KG'),
	('Meat (chicken, whole) - Retail', 1871, 2014, 9, 27.03, 'UAH','KG'),
	('Wheat flour (first grade) - Retail',1871, 2014, 3, 4.67, 'UAH','KG');
