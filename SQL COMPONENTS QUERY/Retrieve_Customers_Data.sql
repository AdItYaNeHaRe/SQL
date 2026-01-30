-- English Explanation:
-- The query SELECT * FROM table; retrieves all columns and rows from a specified table.
-- It is used when you want the complete data without specifying individual column names.

-- Syntax:
-- SELECT *
-- FROM table_name;

-- SELECT → tells the database to fetch data.
-- * → wildcard that means “all columns.”
-- FROM table_name → specifies which table to retrieve data from.

-- Example:
-- SELECT * FROM Employees;
-- This returns all columns (e.g., id, name, salary, etc.) and all rows from the Employees table.


-- Hinglish Explanation:
-- Query SELECT * FROM table; ka matlab hai table se saare columns aur rows nikalna.
-- Ye tab use hoti hai jab hume poori table ka data chahiye ho bina column names likhe.

-- Syntax:
-- SELECT *
-- FROM table_name;

-- SELECT → database se data nikalne ke liye.
-- * → matlab saare columns.
-- FROM table_name → batata hai kis table se data laana hai.

-- Example:
-- SELECT * FROM Employees;
-- Matlab Employees table ke saare columns (id, name, salary, etc.) aur saare rows dikhana.


SELECT
    id,
    first_name,
    country
FROM customers;
