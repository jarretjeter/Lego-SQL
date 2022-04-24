-- Selecting Values

SELECT name, part_num 
FROM parts WHERE name LIKE "%Hair%"
ORDER BY part_num DESC;
-- SELECTS only the 'name' and 'part_num' columns to display FROM the 'parts' table in the database WHERE only the rows with 'name' containing a substring LIKE 'Hair' anywhere in the string are displayed. Uses ORDER BY to list by 'part_num' in descending order.


SELECT * 
FROM sets 
WHERE name LIKE "%Showdown%" AND year BETWEEN 1990 AND 2015;
-- Selecting ALL(*) FROM the SETS table WHERE the 'name' contains the string 'Showdown' anywhere where the 'year' is BETWEEN 1990 and 2015


SELECT id, name
FROM part_categories AS p
WHERE name LIKE "%Bricks%";
-- Selects only the 'id' and 'name' columns FROM the 'part_categories' table(aliased AS 'p') and selecting only the rows WHERE 'name' has a substring LIKE 'Bricks'



-- Subqueries

SELECT name, theme_id
FROM sets
WHERE theme_id IN (
    SELECT id
    FROM themes
    WHERE name LIKE "%Pirates%" OR name LIKE "%Star Wars%");
-- Selects the 'name' and 'theme_id' FROM the 'sets' table WHERE the 'theme_id' value is matching IN the subqueried 'themes' table's 'id' column and WHERE the 'name' column has substrings LIKE 'Pirates' or 'Star Wars'


SELECT *
FROM inventory_parts
WHERE inventory_id IN (
    SELECT id
    FROM inventories
    WHERE version > 1
) LIMIT 10;
-- Selects all columns from the 'inventory_parts' table WHERE the 'inventory_id' is matching IN the created subquery 'id' FROM the 'inventories' table WHERE the version column has a value greater than 1. Use 'LIMIT 10' to limit the outputted table to only 10 rows.



-- Manipulate Values in Select


UPDATE sets SET name = UPPER(CONCAT(name, '!!!'))
WHERE name LIKE '%Batman%';
-- First, use UPDATE to uppercase and concatenate with '!!!' all name values containing the string 'Batman'
SELECT name, year
FROM sets
WHERE name LIKE '%Batman%';
-- Display the updated 'name' column along with the 'year' column from the 'sets' table.
-- or vvv
SELECT UPPER(CONCAT(name, '!!!')), year
FROM sets AS s
WHERE name LIKE '%Batman%';
-- This also works, but the column name 'name' is altered and doesn't look very presentable


UPDATE inventory_parts SET quantity = quantity * 2
WHERE quantity > 1;
-- Updates 'quantity' value to its value * 2 if the initial value is greater than 1
SELECT *
FROM inventory_parts
ORDER BY quantity LIMIT 20;
-- For some reason, when I add the clause 'ORDER BY quantity', none of the doubled quantities are displayed, and quantity always equals 1



-- Working with Dates


SELECT name, year, MAKEDATE(year, 1) AS new_year
FROM sets;
-- MAKEDATE(year, day) takes the value 'year' as whatever the year value is (in this case, the 'year' column) to create a year and the 'day' value creates a month-day combination depending on what day of the year it is 



-- Aggregation Functions


SELECT COUNT(is_trans)
FROM colors
WHERE is_trans = 1;
-- Use COUNT() on 'is_trans' to find how many times 'is_trans' is equal to 1. Totals up to 28

SELECT SUM(num_parts)
FROM sets
WHERE year >= 2000;
-- In the 'sets' table, for every 'year' column value equal to or greater than 2000, SUM() will iterate through and add up the matching values in the 'num_parts' column.


SELECT AVG(num_parts)
FROM sets
WHERE year >= 2000;
-- AVG() will calculate all the values of the 'num_parts' column and get the average of those values, only where the 'year' column value is >= 2000


SELECT theme_id, AVG(num_parts)
FROM sets
GROUP BY theme_id;
-- This query needs 'GROUP BY theme_id' to get the average number of parts for every theme id value, without 'GROUP BY' it will only return the average number of parts for ALL num_parts columns and match to a single theme_id


-- Joins

SELECT *
FROM parts, part_categories
WHERE parts.part_cat_id = part_categories.id AND parts.name LIKE '%Werewolf%';
-- Here I used dot notation so I could better identify which column belonged to which table. Result is all of the tables were included in the join. 


SELECT p.part_num, p.name, p.part_cat_id, pc.name AS category
FROM parts AS p
INNER JOIN part_categories AS pc
	ON p.part_cat_id = pc.id AND p.name LIKE '%Werewolf%';
--Aliased the 'part_category' table's column 'name' AS 'category' so that there aren't more than one 'name' column in the join. Also I didn't find it necessary to join the 'id' column from 'part_categories' because the 'parts' table already had the same id values.


SELECT *
FROM colors AS c
INNER JOIN inventory_parts AS ip
ON c.id = ip.color_id;
-- 50,000/580,251

SELECT *
FROM colors AS c
LEFT JOIN inventory_parts AS ip
ON c.id = ip.color_id;
-- 50,000/580,255

SELECT *
FROM colors AS c
RIGHT JOIN inventory_parts AS ip
ON c.id = ip.color_id;
-- 50,000/580,251

-- The left join on the 'colors' table has 4 more rows than the inner join and the right join on 'inventory_parts'.I believe this means that the colors table has 4 id's that aren't matched/are missing in the inventory_parts color_id columns