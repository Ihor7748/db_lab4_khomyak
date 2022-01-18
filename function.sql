CREATE OR REPLACE FUNCTION f(market_i INT, start_year INT, start_month INT,end_year INT, end_month INT) 
	RETURNS table(prod_n VARCHAR(100), price_diff NUMERIC(32,2)) AS
$$

BEGIN
	RETURN QUERY SELECT price1.product_name, price1.price - price2.price FROM (SELECT DISTINCT product_name, price FROM product_price 
	WHERE year = start_year and month = start_month ) as price1 INNER JOIN (SELECT DISTINCT product_name, price FROM product_price 
	WHERE year = end_year and month = end_month) as price2 ON price1.product_name=price2.product_name;
END;
$$ LANGUAGE 'plpgsql';
