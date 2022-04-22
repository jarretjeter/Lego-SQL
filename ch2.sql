use lego; -- Tell MariaDB to use the lego database so that I can work with it.

-- Selecting Values

-- Select the name and part_num columns from the parts table. Show only names that include the substring 'Hair', and order them with the part_num in descending order
-- SELECTS only the 'name' and 'part_num' columns to display FROM the 'parts' table in the database WHERE only the rows with 'name' containing a substring LIKE 'Hair' anywhere in the string are displayed. Uses ORDER BY to list by 'part_num' in descending order.
SELECT name, part_num 
FROM parts WHERE name LIKE "%Hair%"
ORDER BY part_num DESC;

--     From the sets table, select all the sets that included the word 'Showdown' in the name between 1990 and 2015
-- Selecting ALL(*) FROM the SETS table WHERE the 'name' contains the string 'Showdown' anywhere where the 'year' is BETWEEN 1990 and 2015
SELECT * 
FROM sets 
WHERE name LIKE "%Showdown%" AND year BETWEEN 1990 AND 2015;
--     Aliasing the part_categories table as p, show the id and name of the values in that table where the name includes the word 'Bricks'
-- Selects only the 'id' and 'name' columns FROM the 'part_categories' table(aliased AS 'p') and selecting only the rows WHERE 'name' has a substring LIKE 'Bricks'
SELECT id, name
FROM part_categories AS p
WHERE name LIKE "%Bricks%";
-- Subqueries

--     Select all the ids from the themes table where the name is in 'Pirates' or 'Star Wars'. This is your subquery. Then show the names of all the sets where the theme_id matches an id in that subquery.
-- Selects the 'name' and 'theme_id' FROM the 'sets' table WHERE the 'theme_id' value is matching IN the subqueried 'themes' table's 'id' column and WHERE the 'name' column has substrings LIKE 'Pirates' or 'Star Wars'
SELECT name, theme_id
FROM sets
WHERE theme_id IN (
    SELECT id
    FROM themes
    WHERE name LIKE "%Pirates%" OR name LIKE "%Star Wars%");
--     Select the ids of the values in the inventories table that have more than one version (i.e. version > 1). This is your subquery. Then select everything from the inventory_parts table where the inventory_id matches an id in that subquery. Limit the output to 10 rows.

-- Selects all columns from the 'inventory_parts' table WHERE the 'inventory_id' is matching IN the created subquery 'id' FROM the 'inventories' table WHERE the version column has a value greater than 1. Use 'LIMIT 10' to limit the outputted table to only 10 rows.
SELECT *
FROM inventory_parts
WHERE inventory_id IN (
    SELECT id
    FROM inventories
    WHERE version > 1
) LIMIT 10;
-- Manipulate Values in Select

--     Aliasing the sets table as 's', select the year and name of the values in that table that include the substring 'Batman'. Concatenate three exclamation marks to the end of each name, and make all the names upper case.

-- First, use UPDATE to uppercase and concatenate with '!!!' all name values containing the string 'Batman'
UPDATE sets SET name = UPPER(CONCAT(name, '!!!'))
WHERE name LIKE '%Batman%';
-- Display the updated 'name' column along with the 'year' column from the 'sets' table
SELECT name, year
FROM sets
WHERE name LIKE '%Batman%'
-- This also works, but the column name 'name' is altered and doesn't look very presentable
SELECT UPPER(CONCAT(name, '!!!')), year
FROM sets AS s
WHERE name LIKE '%Batman%';

--     For every quantity value greater than 1 in the inventory_parts table, double the value of the quantity. Limit your output to 20 rows, and order it by quantity.

-- Updates 'quantity' value to its value * 2 if the initial value is greater than 1
UPDATE inventory_parts SET quantity = quantity * 2
WHERE quantity > 1;
-- For some reason, when I add the clause 'ORDER BY quantity', none of the doubled quantities are displayed, and quantity always equals 1
SELECT *
FROM inventory_parts
ORDER BY quantity LIMIT 20;

-- Working with Dates

-- Selecting from the sets table: - Select the name and year column. Construct an additional column in your SELECT clause using the MySQL MAKEDATE() function. This column's value should be a date corresponding to January 1st of the year. Hint: You should use the year column and day 1 with MAKEDATE(). Read the MySQL documentation for MAKEDATE().

-- MAKEDATE(year, day) takes the value 'year' as whatever the year value is (in this case, the 'year' column) to create a year and the 'day' value creates a month-day combination depending on what day of the year it is 
SELECT name, year, MAKEDATE(year, 1) AS new_year
FROM sets;
-- Aggregation Functions

--     Count the total number of transparent colors in the colors table (Note: is_trans is a binary value, and you want to show how many rows there are where it equals 1).

-- Use COUNT() on 'is_trans' to find how many times 'is_trans' is equal to 1. Totals up to 28
SELECT COUNT(is_trans)
FROM colors
WHERE is_trans = 1;
--     Show the sum of all the parts for all the sets that came out since the year 2000.

-- In the 'sets' table, for every 'year' column value equal to or greater than 2000, SUM() will iterate through and add up the matching values in the 'num_parts' column.
SELECT SUM(num_parts)
FROM sets
WHERE year >= 2000;
--     Show the average number of parts for sets that came out since the year 2000.
-- AVG() will calculate all the values of the 'num_parts' column and get the average of those values, only where the 'year' column value is >= 2000
SELECT AVG(num_parts)
FROM sets
WHERE year >= 2000;
--     Using GROUP BY, show the average number of parts for each theme_id in sets.
-- This query needs 'GROUP BY theme_id' to get the average number of parts for every theme id value, without 'GROUP BY' it will only return the average number of parts for ALL num_parts columns and match to a single theme_id
SELECT theme_id, AVG(num_parts)
FROM sets
GROUP BY theme_id;
-- Joins

--     Using a free-form join (where the JOIN type isn't specified, equivalent to an inner join), join the parts and part_categories tables. Filter for values where the part_categories id matches the parts partcatid, and where the name of the part contains the word 'Werewolf'.

-- I used aliasing on the tables to better identify the columns for myself and aliased the 'part_categories' column 'name' as 'category' so that there weren't two columns named 'name'. I didn't join the 'id' column from 'part_categories' because the 'parts' table already had that value.
SELECT p.part_num, p.name, p.part_cat_id, pc.name AS category
FROM parts AS p, part_categories AS pc
WHERE p.part_cat_id = pc.id AND p.name LIKE '%Werewolf%';
--     Repeat the query above, but this time write it explicitly using INNER JOIN, and alias parts as 'p' and part_categories as 'pc'.

--     Perform left, right, and inner joins on the colors and inventory_parts tables, where the color id matches the inventory_parts color id. Note many rows each join returns. Write a brief comment in your SQL file under these code blocks explaining what the difference in rows tells you.
