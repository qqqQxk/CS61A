.read data.sql


CREATE TABLE average_prices AS
  SELECT category, AVG(MSRP) AS average_price
    FROM products
    GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT i.store, i.item, i.price
    FROM inventory AS i
    GROUP BY i.item
    HAVING i.price = MIN(i.price);

CREATE TABLE shop_helper AS
  SELECT name, MIN(MSRP / rating) AS best
  FROM products
  GROUP BY category;
CREATE TABLE shopping_list AS
  SELECT p.name, l.store
    FROM products AS p, shop_helper AS s, lowest_prices AS l
    WHERE p.name = s.name AND (p.MSRP / p.rating) = s.best AND p.name = l.item
    ORDER BY p.name;


CREATE TABLE total_bandwidth AS
  SELECT SUM(st.Mbs)
    FROM stores AS st, shopping_list AS sh
    WHERE st.store = sh.store;

