use lego; -- Tell MariaDB to use the lego database so that I can work with it.

-- Selecting Values

-- Select the name and part_num columns from the parts table. Show only names that include the substring 'Hair', and order them with the part_num in descending order
-- SELECTS only the 'name' and 'part_num' columns to display FROM the 'parts' table in the database WHERE only the rows with 'name' containing a string LIKE 'Hair' are displayed. Uses ORDER BY to list by 'part_num' in descending order.
SELECT name, part_num 
FROM parts WHERE name LIKE "%Hair"
ORDER BY part_num DESC;

--     From the sets table, select all the sets that included the word 'Showdown' in the name between 1990 and 2015

--     Aliasing the part_categories table as p, show the id and name of the values in that table where the name includes the word 'Bricks'

-- Subqueries

--     Select all the ids from the themes table where the name is in 'Pirates' or 'Star Wars'. This is your subquery. Then show the names of all the sets where the theme_id matches an id in that subquery.

--     Select the ids of the values in the inventories table that have more than one version (i.e. version > 1). This is your subquery. Then select everything from the inventory_parts table where the inventory_id matches an id in that subquery. Limit the output to 10 rows.

-- Manipulate Values in Select

--     Aliasing the sets table as 's', select the year and name of the values in that table that include the substring 'Batman'. Concatenate three exclamation marks to the end of each name, and make all the names upper case.

--     For every quantity value greater than 1 in the inventory_parts table, double the value of the quantity. Limit your output to 20 rows, and order it by quantity.

-- Working with Dates

-- Selecting from the sets table: - Select the name and year column. Construct an additional column in your SELECT clause using the MySQL MAKEDATE() function. This column's value should be a date corresponding to January 1st of the year. Hint: You should use the year column and day 1 with MAKEDATE(). Read the MySQL documentation for MAKEDATE().
-- Aggregation Functions

--     Count the total number of transparent colors in the colors table (Note: is_trans is a binary value, and you want to show how many rows there are where it equals 1).

--     Show the sum of all the parts for all the sets that came out since the year 2000.

--     Show the average number of parts for sets that came out since the year 2000.

--     Using GROUP BY, show the average number of parts for each theme_id in sets.

-- Joins

--     Using a free-form join (where the JOIN type isn't specified, equivalent to an inner join), join the parts and part_categories tables. Filter for values where the part_categories id matches the parts partcatid, and where the name of the part contains the word 'Werewolf'.

--     Repeat the query above, but this time write it explicitly using INNER JOIN, and alias parts as 'p' and part_categories as 'pc'.

--     Perform left, right, and inner joins on the colors and inventory_parts tables, where the color id matches the inventory_parts color id. Note many rows each join returns. Write a brief comment in your SQL file under these code blocks explaining what the difference in rows tells you.
