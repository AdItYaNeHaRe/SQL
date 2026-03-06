/*
=================================================================
QUERY PURPOSE: Master all SQL operators for data manipulation and filtering
=================================================================

CONCEPT EXPLANATION (English):
SQL operators are symbols or keywords that perform operations on data.
They are the building blocks of SQL expressions and allow you to:
- Perform calculations (arithmetic)
- Combine values (concatenation)
- Compare values (comparison)
- Establish relationships (relational)
- Combine conditions (logical)
- Execute special operations (special)
- Work with nested queries (subquery)

Operators are essential for:
- Data transformation and calculations
- Complex filtering and searching
- Business logic implementation
- Data validation and verification
- Dynamic query construction
- Advanced data analysis

Categories of SQL Operators:

1. ARITHMETIC Operators (+, -, *, /, %, DIV, MOD)
   - Perform mathematical calculations
   - Used in SELECT, WHERE, UPDATE

2. CONCATENATION Operators (||, CONCAT, +)
   - Combine strings together
   - Build dynamic text

3. COMPARISON Operators (=, !=, <>, >, <, >=, <=)
   - Compare two values
   - Return TRUE/FALSE

4. RELATIONAL Operators (IN, BETWEEN, LIKE, IS NULL)
   - Check relationships and patterns
   - Special comparison operations

5. LOGICAL Operators (AND, OR, NOT, XOR)
   - Combine multiple conditions
   - Boolean logic operations

6. SPECIAL Operators (EXISTS, ANY, ALL, UNIQUE)
   - Advanced operations
   - Work with subqueries

7. SUBQUERY Operators (IN, EXISTS, ANY, ALL, scalar comparisons)
   - Compare with query results
   - Nested query operations

CONCEPT EXPLANATION (Hinglish):
SQL operators symbols ya keywords hain jo data pe operations perform
karte hain. Yeh SQL expressions ke building blocks hain aur aapko
allow karte hain:
- Calculations karna (arithmetic)
- Values combine karna (concatenation)
- Values compare karna (comparison)
- Relationships establish karna (relational)
- Conditions combine karna (logical)
- Special operations execute karna (special)
- Nested queries ke saath kaam karna (subquery)

Operators zaroori hain:
- Data transformation aur calculations ke liye
- Complex filtering aur searching ke liye
- Business logic implementation ke liye
- Data validation aur verification ke liye
- Dynamic query construction ke liye
- Advanced data analysis ke liye

SQL Operators ki categories:

1. ARITHMETIC Operators (+, -, *, /, %, DIV, MOD)
   - Mathematical calculations perform karna
   - SELECT, WHERE, UPDATE mein use hote hain

2. CONCATENATION Operators (||, CONCAT, +)
   - Strings ko together combine karna
   - Dynamic text banana

3. COMPARISON Operators (=, !=, <>, >, <, >=, <=)
   - Do values compare karna
   - TRUE/FALSE return karte hain

4. RELATIONAL Operators (IN, BETWEEN, LIKE, IS NULL)
   - Relationships aur patterns check karna
   - Special comparison operations

5. LOGICAL Operators (AND, OR, NOT, XOR)
   - Multiple conditions combine karna
   - Boolean logic operations

6. SPECIAL Operators (EXISTS, ANY, ALL, UNIQUE)
   - Advanced operations
   - Subqueries ke saath kaam karte hain

7. SUBQUERY Operators (IN, EXISTS, ANY, ALL, scalar comparisons)
   - Query results ke saath compare karna
   - Nested query operations

USE CASES:
- E-commerce: Price calculations, discounts, tax
- Finance: Interest calculations, profit/loss, compound growth
- HR: Salary calculations, bonus, deductions
- Analytics: Statistical calculations, aggregations
- Inventory: Stock calculations, reorder points
- Reporting: Calculated fields, formatted output
- Data validation: Range checks, pattern matching
- Search: Text matching, fuzzy search
- Data cleansing: NULL handling, data correction

SAMPLE DATA (Sales table):

id | product      | quantity | unit_price | discount_pct | tax_rate | sale_date  | region    | customer_id
---|--------------|----------|------------|--------------|----------|------------|-----------|------------
1  | Laptop       | 2        | 999.99     | 10.0         | 8.0      | 2024-03-01 | North     | 101
2  | Mouse        | 5        | 25.50      | 5.0          | 8.0      | 2024-03-02 | South     | 102
3  | Keyboard     | 3        | 79.99      | 15.0         | 8.0      | 2024-03-03 | East      | 103
4  | Monitor      | 1        | 349.99     | 0.0          | 8.0      | 2024-03-04 | West      | 104
5  | Headphones   | 4        | 89.99      | 20.0         | 8.0      | 2024-03-05 | North     | 105
6  | USB Cable    | 10       | 12.99      | 0.0          | 8.0      | 2024-03-06 | South     | 106
7  | Webcam       | 2        | 119.99     | 10.0         | 8.0      | 2024-03-07 | East      | 107
8  | Desk Lamp    | 6        | 45.50      | 12.0         | 8.0      | 2024-03-08 | West      | 108

Additional sample (Employees table):

id | first_name | last_name | salary  | bonus  | dept        | hire_date  | manager_id
---|------------|-----------|---------|--------|-------------|------------|------------
1  | John       | Smith     | 75000   | 5000   | IT          | 2020-01-15 | NULL
2  | Sarah      | Johnson   | 65000   | 3000   | Sales       | 2021-03-20 | 1
3  | Mike       | Davis     | 80000   | 6000   | IT          | 2019-07-10 | 1
4  | Emily      | Brown     | 70000   | 4000   | Marketing   | 2022-05-15 | NULL
5  | David      | Wilson    | 55000   | 2000   | Sales       | 2023-01-10 | 2

=================================================================
SECTION 1: ARITHMETIC OPERATORS
=================================================================

1.1 Addition (+)
━━━━━━━━━━━━━━━

Syntax: operand1 + operand2
Purpose: Add two values
Returns: Sum of values
*/

-- Example 1: Basic addition
SELECT
    product,
    quantity,
    unit_price,
    quantity + unit_price AS simple_addition,
    quantity + 10 AS quantity_plus_10
FROM Sales
LIMIT 3;
/*
Result:
product  | quantity | unit_price | simple_addition | quantity_plus_10
---------|----------|------------|-----------------|------------------
Laptop   | 2        | 999.99     | 1001.99         | 12
Mouse    | 5        | 25.50      | 30.50           | 15
Keyboard | 3        | 79.99      | 82.99           | 13

Explanation:
- quantity + unit_price = 2 + 999.99 = 1001.99
- quantity + 10 = 2 + 10 = 12
- Numbers are added mathematically

Use Case: Adding values, totaling amounts
*/

-- Example 2: Adding salary components
SELECT
    first_name,
    last_name,
    salary,
    bonus,
    salary + bonus AS total_compensation
FROM Employees;
/*
Result:
first_name | last_name | salary | bonus | total_compensation
-----------|-----------|--------|-------|-------------------
John       | Smith     | 75000  | 5000  | 80000
Sarah      | Johnson   | 65000  | 3000  | 68000
Mike       | Davis     | 80000  | 6000  | 86000
Emily      | Brown     | 70000  | 4000  | 74000
David      | Wilson    | 55000  | 2000  | 57000

Use Case: Salary calculations, total compensation
*/

/*
1.2 Subtraction (-)
━━━━━━━━━━━━━━━━━━

Syntax: operand1 - operand2
Purpose: Subtract one value from another
Returns: Difference
*/

-- Example 3: Calculate discount amount
SELECT
    product,
    unit_price,
    discount_pct,
    unit_price * (discount_pct / 100) AS discount_amount,
    unit_price - (unit_price * discount_pct / 100) AS discounted_price
FROM Sales
LIMIT 4;
/*
Result:
product  | unit_price | discount_pct | discount_amount | discounted_price
---------|------------|--------------|-----------------|------------------
Laptop   | 999.99     | 10.0         | 100.00          | 899.99
Mouse    | 25.50      | 5.0          | 1.28            | 24.23
Keyboard | 79.99      | 15.0         | 12.00           | 67.99
Monitor  | 349.99     | 0.0          | 0.00            | 349.99

Explanation:
- discount_amount = unit_price * (discount_pct / 100)
- discounted_price = unit_price - discount_amount
- Laptop: 999.99 - (999.99 * 0.10) = 899.99

Use Case: Discount calculations, deductions, differences
*/

-- Example 4: Date differences
SELECT
    first_name,
    hire_date,
    CURDATE() AS current_date,
    DATEDIFF(CURDATE(), hire_date) AS days_employed,
    DATEDIFF(CURDATE(), hire_date) / 365 AS years_employed
FROM Employees;
/*
Result (assuming current date is 2024-03-15):
first_name | hire_date  | current_date | days_employed | years_employed
-----------|------------|--------------|---------------|----------------
John       | 2020-01-15 | 2024-03-15   | 1521          | 4.1671
Sarah      | 2021-03-20 | 2024-03-15   | 1091          | 2.9890
Mike       | 2019-07-10 | 2024-03-15   | 1710          | 4.6849
Emily      | 2022-05-15 | 2024-03-15   | 671           | 1.8384
David      | 2023-01-10 | 2024-03-15   | 431           | 1.1808

Use Case: Tenure calculations, time differences
*/

/*
1.3 Multiplication (*)
━━━━━━━━━━━━━━━━━━━━━

Syntax: operand1 * operand2
Purpose: Multiply two values
Returns: Product
*/

-- Example 5: Calculate subtotal
SELECT
    product,
    quantity,
    unit_price,
    quantity * unit_price AS subtotal,
    ROUND(quantity * unit_price, 2) AS subtotal_rounded
FROM Sales
LIMIT 4;
/*
Result:
product  | quantity | unit_price | subtotal | subtotal_rounded
---------|----------|------------|----------|------------------
Laptop   | 2        | 999.99     | 1999.98  | 1999.98
Mouse    | 5        | 25.50      | 127.50   | 127.50
Keyboard | 3        | 79.99      | 239.97   | 239.97
Monitor  | 1        | 349.99     | 349.99   | 349.99

Explanation:
- subtotal = quantity * unit_price
- Laptop: 2 * 999.99 = 1999.98
- Mouse: 5 * 25.50 = 127.50

Use Case: Line item totals, extended prices, area calculations
*/

-- Example 6: Compound calculations
SELECT
    product,
    quantity,
    unit_price,
    discount_pct,
    tax_rate,

    -- Step 1: Subtotal
    quantity * unit_price AS subtotal,

    -- Step 2: Discount amount
    (quantity * unit_price) * (discount_pct / 100) AS discount,

    -- Step 3: After discount
    (quantity * unit_price) - ((quantity * unit_price) * (discount_pct / 100)) AS after_discount,

    -- Step 4: Tax amount
    ((quantity * unit_price) - ((quantity * unit_price) * (discount_pct / 100))) * (tax_rate / 100) AS tax,

    -- Step 5: Final total
    ((quantity * unit_price) - ((quantity * unit_price) * (discount_pct / 100))) * (1 + tax_rate / 100) AS final_total
FROM Sales
LIMIT 3;
/*
Result:
product  | quantity | unit_price | discount_pct | tax_rate | subtotal | discount | after_discount | tax    | final_total
---------|----------|------------|--------------|----------|----------|----------|----------------|--------|-------------
Laptop   | 2        | 999.99     | 10.0         | 8.0      | 1999.98  | 200.00   | 1799.98        | 144.00 | 1943.98
Mouse    | 5        | 25.50      | 5.0          | 8.0      | 127.50   | 6.38     | 121.13         | 9.69   | 130.81
Keyboard | 3        | 79.99      | 15.0         | 8.0      | 239.97   | 36.00    | 203.97         | 16.32  | 220.29

Explanation: Complete sales calculation pipeline
- Subtotal = quantity × unit_price
- Discount = subtotal × discount_pct
- After discount = subtotal - discount
- Tax = after_discount × tax_rate
- Final = after_discount + tax

Use Case: E-commerce calculations, invoicing, pricing
*/

/*
1.4 Division (/)
━━━━━━━━━━━━━━━

Syntax: operand1 / operand2
Purpose: Divide one value by another
Returns: Quotient (decimal)
Note: Watch for division by zero!
*/

-- Example 7: Calculate average and percentages
SELECT
    product,
    quantity,
    unit_price,
    (quantity * unit_price) AS revenue,
    (quantity * unit_price) / quantity AS price_check,  -- Should equal unit_price
    (discount_pct / 100) AS discount_decimal,
    ROUND((discount_pct / 100) * 100, 1) AS discount_percent
FROM Sales
LIMIT 3;
/*
Result:
product  | quantity | unit_price | revenue | price_check | discount_decimal | discount_percent
---------|----------|------------|---------|-------------|------------------|------------------
Laptop   | 2        | 999.99     | 1999.98 | 999.99      | 0.10             | 10.0
Mouse    | 5        | 25.50      | 127.50  | 25.50       | 0.05             | 5.0
Keyboard | 3        | 79.99      | 239.97  | 79.99       | 0.15             | 15.0

Use Case: Averages, percentages, rates, ratios
*/

-- Example 8: Division by zero handling
SELECT
    product,
    quantity,
    unit_price,

    -- Unsafe division (would error if quantity = 0)
    -- unit_price / quantity AS unsafe_avg,

    -- Safe division with NULLIF
    unit_price / NULLIF(quantity, 0) AS safe_avg,

    -- Safe division with CASE
    CASE
        WHEN quantity = 0 THEN NULL
        ELSE unit_price / quantity
    END AS safe_avg_case
FROM Sales
LIMIT 3;
/*
Result:
product  | quantity | unit_price | safe_avg | safe_avg_case
---------|----------|------------|----------|---------------
Laptop   | 2        | 999.99     | 500.00   | 500.00
Mouse    | 5        | 25.50      | 5.10     | 5.10
Keyboard | 3        | 79.99      | 26.66    | 26.66

Explanation:
- NULLIF(quantity, 0) returns NULL if quantity is 0
- Division by NULL returns NULL (safe)
- CASE provides explicit control

Use Case: Safe calculations, avoiding errors
*/

/*
1.5 Modulo (%, MOD)
━━━━━━━━━━━━━━━━━━━

Syntax: operand1 % operand2  OR  MOD(operand1, operand2)
Purpose: Get remainder after division
Returns: Remainder (integer)
*/

-- Example 9: Find odd/even, grouping
SELECT
    id,
    product,
    quantity,
    quantity % 2 AS remainder,
    MOD(quantity, 2) AS mod_function,
    CASE
        WHEN quantity % 2 = 0 THEN 'Even'
        ELSE 'Odd'
    END AS even_odd
FROM Sales
LIMIT 5;
/*
Result:
id | product    | quantity | remainder | mod_function | even_odd
---|------------|----------|-----------|--------------|----------
1  | Laptop     | 2        | 0         | 0            | Even
2  | Mouse      | 5        | 1         | 1            | Odd
3  | Keyboard   | 3        | 1         | 1            | Odd
4  | Monitor    | 1        | 1         | 1            | Odd
5  | Headphones | 4        | 0         | 0            | Even

Explanation:
- % and MOD() are equivalent
- remainder = 0 means evenly divisible (even number)
- remainder = 1 means odd number

Use Case: Even/odd detection, grouping, pagination
*/

-- Example 10: Modulo for grouping into batches
SELECT
    id,
    product,
    MOD(id - 1, 3) + 1 AS batch_number,
    CASE MOD(id - 1, 3)
        WHEN 0 THEN 'Batch A'
        WHEN 1 THEN 'Batch B'
        WHEN 2 THEN 'Batch C'
    END AS batch_name
FROM Sales;
/*
Result:
id | product    | batch_number | batch_name
---|------------|--------------|------------
1  | Laptop     | 1            | Batch A
2  | Mouse      | 2            | Batch B
3  | Keyboard   | 3            | Batch C
4  | Monitor    | 1            | Batch A
5  | Headphones | 2            | Batch B
6  | USB Cable  | 3            | Batch C
7  | Webcam     | 1            | Batch A
8  | Desk Lamp  | 2            | Batch B

Explanation:
- MOD(id - 1, 3) gives 0, 1, 2
- Add 1 to get batches 1, 2, 3
- Distributes rows into 3 groups evenly

Use Case: Load balancing, batch processing, round-robin assignment
*/

/*
1.6 Integer Division (DIV) - MySQL specific
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: operand1 DIV operand2
Purpose: Integer division (discard remainder)
Returns: Quotient without decimal
*/

-- Example 11: Integer division
SELECT
    product,
    quantity,
    quantity DIV 2 AS pairs,
    MOD(quantity, 2) AS leftover,

    -- Full breakdown
    CONCAT(
        quantity DIV 2, ' pairs + ',
        MOD(quantity, 2), ' leftover'
    ) AS breakdown
FROM Sales
LIMIT 4;
/*
Result:
product  | quantity | pairs | leftover | breakdown
---------|----------|-------|----------|------------------
Laptop   | 2        | 1     | 0        | 1 pairs + 0 leftover
Mouse    | 5        | 2     | 1        | 2 pairs + 1 leftover
Keyboard | 3        | 1     | 1        | 1 pairs + 1 leftover
Monitor  | 1        | 0     | 1        | 0 pairs + 1 leftover

Explanation:
- 5 DIV 2 = 2 (ignore remainder)
- 5 MOD 2 = 1 (remainder only)
- Together: 5 = (2 × 2) + 1

Use Case: Packaging calculations, pair counting
*/

/*
=================================================================
SECTION 2: CONCATENATION OPERATORS
=================================================================

2.1 CONCAT Function
━━━━━━━━━━━━━━━━━━━

Syntax: CONCAT(string1, string2, ..., stringN)
Purpose: Combine multiple strings
Returns: Single concatenated string
*/

-- Example 12: Concatenate names
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(last_name, ', ', first_name) AS formal_name,
    CONCAT(first_name, ' ', last_name, ' (', dept, ')') AS name_with_dept
FROM Employees;
/*
Result:
first_name | last_name | full_name     | formal_name    | name_with_dept
-----------|-----------|---------------|----------------|----------------------
John       | Smith     | John Smith    | Smith, John    | John Smith (IT)
Sarah      | Johnson   | Sarah Johnson | Johnson, Sarah | Sarah Johnson (Sales)
Mike       | Davis     | Mike Davis    | Davis, Mike    | Mike Davis (IT)
Emily      | Brown     | Emily Brown   | Brown, Emily   | Emily Brown (Marketing)
David      | Wilson    | David Wilson  | Wilson, David  | David Wilson (Sales)

Use Case: Name formatting, display labels, formatted output
*/

-- Example 13: Concatenate with numbers and dates
SELECT
    product,
    quantity,
    unit_price,
    CONCAT(product, ' - $', unit_price) AS product_with_price,
    CONCAT('Order: ', id, ' on ', DATE_FORMAT(sale_date, '%b %d, %Y')) AS order_info,
    CONCAT(quantity, ' × $', unit_price, ' = $', ROUND(quantity * unit_price, 2)) AS calculation
FROM Sales
LIMIT 3;
/*
Result:
product  | quantity | unit_price | product_with_price | order_info              | calculation
---------|----------|------------|--------------------|-----------------------|--------------------------
Laptop   | 2        | 999.99     | Laptop - $999.99   | Order: 1 on Mar 01, 2024| 2 × $999.99 = $1999.98
Mouse    | 5        | 25.50      | Mouse - $25.50     | Order: 2 on Mar 02, 2024| 5 × $25.50 = $127.50
Keyboard | 3        | 79.99      | Keyboard - $79.99  | Order: 3 on Mar 03, 2024| 3 × $79.99 = $239.97

Use Case: Formatted labels, report strings, display messages
*/

/*
2.2 Pipe Operator (||) - PostgreSQL, Oracle, SQLite
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: string1 || string2
Purpose: Concatenate strings
Note: Not available in MySQL (use CONCAT instead)
*/

-- Example 14: Pipe operator (PostgreSQL/Oracle syntax)
/*
-- PostgreSQL/Oracle/SQLite syntax:
SELECT
    first_name || ' ' || last_name AS full_name,
    'Employee: ' || first_name || ' ' || last_name AS label
FROM Employees;
*/

-- MySQL equivalent using CONCAT:
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT('Employee: ', first_name, ' ', last_name) AS label
FROM Employees
LIMIT 2;
/*
Result:
full_name     | label
--------------|------------------------
John Smith    | Employee: John Smith
Sarah Johnson | Employee: Sarah Johnson

Use Case: String building, database portability
*/

/*
2.3 CONCAT_WS (Concatenate With Separator)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CONCAT_WS(separator, string1, string2, ..., stringN)
Purpose: Concatenate with automatic separator
Advantage: Separator added between values automatically
*/

-- Example 15: CONCAT_WS for cleaner syntax
SELECT
    first_name,
    last_name,
    dept,

    -- Without CONCAT_WS (verbose)
    CONCAT(first_name, ' | ', last_name, ' | ', dept) AS manual_concat,

    -- With CONCAT_WS (cleaner)
    CONCAT_WS(' | ', first_name, last_name, dept) AS ws_concat,

    -- CSV format
    CONCAT_WS(',', first_name, last_name, dept, salary) AS csv_format
FROM Employees
LIMIT 3;
/*
Result:
first_name | last_name | dept   | manual_concat          | ws_concat              | csv_format
-----------|-----------|--------|------------------------|------------------------|-------------------------
John       | Smith     | IT     | John | Smith | IT      | John | Smith | IT      | John,Smith,IT,75000
Sarah      | Johnson   | Sales  | Sarah | Johnson | Sales| Sarah | Johnson | Sales| Sarah,Johnson,Sales,65000
Mike       | Davis     | IT     | Mike | Davis | IT      | Mike | Davis | IT      | Mike,Davis,IT,80000

Explanation:
- CONCAT_WS automatically adds separator between each value
- Cleaner syntax than multiple CONCATs
- Useful for CSV, pipe-delimited formats

Use Case: CSV export, delimited data, formatted lists
*/

/*
=================================================================
SECTION 3: COMPARISON OPERATORS
=================================================================

3.1 Equality (=)
━━━━━━━━━━━━━━━

Syntax: value1 = value2
Purpose: Check if values are equal
Returns: TRUE if equal, FALSE otherwise
*/

-- Example 16: Equality in WHERE and SELECT
SELECT
    product,
    quantity,
    unit_price,
    region,

    -- Comparison in SELECT (returns 1/0 in MySQL)
    region = 'North' AS is_north,
    quantity = 5 AS is_qty_five,

    -- Can be used in calculations
    (region = 'North') * 100 AS north_bonus
FROM Sales
WHERE unit_price = 999.99  -- Equality in WHERE
   OR quantity = 10;
/*
Result:
product   | quantity | unit_price | region | is_north | is_qty_five | north_bonus
----------|----------|------------|--------|----------|-------------|-------------
Laptop    | 2        | 999.99     | North  | 1        | 0           | 100
USB Cable | 10       | 12.99      | South  | 0        | 1           | 0

Explanation:
- region = 'North' returns 1 (TRUE) or 0 (FALSE)
- Can use comparison result in calculations
- WHERE filters rows where condition is TRUE

Use Case: Filtering, conditional logic, flags
*/

/*
3.2 Inequality (!=, <>)
━━━━━━━━━━━━━━━━━━━━━━

Syntax: value1 != value2  OR  value1 <> value2
Purpose: Check if values are NOT equal
Returns: TRUE if different, FALSE if equal
*/

-- Example 17: Exclude specific values
SELECT
    product,
    region,
    quantity * unit_price AS revenue
FROM Sales
WHERE region != 'North'
  AND product <> 'Monitor'
ORDER BY revenue DESC;
/*
Result:
product    | region | revenue
-----------|--------|--------
Desk Lamp  | West   | 273.00
Mouse      | South  | 127.50
USB Cable  | South  | 129.90
Webcam     | East   | 239.98
Keyboard   | East   | 239.97

Explanation:
- Excludes North region AND Monitor product
- Both != and <> work identically
- Returns 5 rows

Use Case: Exclusion filters, "not equal" conditions
*/

/*
3.3 Greater Than (>), Less Than (<)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: value1 > value2,  value1 < value2
Purpose: Compare magnitude
Returns: TRUE/FALSE
*/

-- Example 18: Range filtering
SELECT
    product,
    unit_price,
    quantity,
    discount_pct,

    -- Flags based on comparisons
    unit_price > 100 AS is_premium,
    quantity < 5 AS is_low_qty,
    discount_pct > 10 AS has_big_discount
FROM Sales
WHERE unit_price > 50
  AND quantity < 5;
/*
Result:
product    | unit_price | quantity | discount_pct | is_premium | is_low_qty | has_big_discount
-----------|------------|----------|--------------|------------|------------|------------------
Laptop     | 999.99     | 2        | 10.0         | 1          | 1          | 0
Keyboard   | 79.99      | 3        | 15.0         | 0          | 1          | 1
Monitor    | 349.99     | 1        | 0.0          | 1          | 1          | 0
Headphones | 89.99      | 4        | 20.0         | 0          | 1          | 1
Webcam     | 119.99     | 2        | 10.0         | 1          | 1          | 0

Use Case: Threshold filtering, categorization
*/

/*
3.4 Greater/Less Than or Equal (>=, <=)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: value1 >= value2,  value1 <= value2
Purpose: Inclusive comparison
Returns: TRUE/FALSE
*/

-- Example 19: Inclusive ranges
SELECT
    product,
    quantity,
    unit_price,
    quantity * unit_price AS revenue
FROM Sales
WHERE unit_price >= 25.50
  AND unit_price <= 120
  AND quantity >= 2
ORDER BY revenue DESC;
/*
Result:
product    | quantity | unit_price | revenue
-----------|----------|------------|--------
Laptop     | 2        | 999.99     | 1999.98

Wait, Laptop is > 120, let me recalculate...

Actual Result:
product    | quantity | unit_price | revenue
-----------|----------|------------|--------
Keyboard   | 3        | 79.99      | 239.97
Webcam     | 2        | 119.99     | 239.98
Headphones | 4        | 89.99      | 359.96

Explanation:
- Includes boundaries (25.50 and 120)
- Keyboard: 79.99 is >= 25.50 AND <= 120, quantity 3 >= 2
- Webcam: 119.99 is within range, quantity 2 >= 2

Use Case: Price ranges, inclusive filters
*/

/*
=================================================================
SECTION 4: RELATIONAL OPERATORS
=================================================================

4.1 IN Operator
━━━━━━━━━━━━━━

Syntax: value IN (value1, value2, ..., valueN)
Purpose: Check if value matches any in list
Equivalent: value = value1 OR value = value2 OR ...
*/

-- Example 20: IN with list of values
SELECT
    product,
    region,
    quantity * unit_price AS revenue
FROM Sales
WHERE region IN ('North', 'South', 'East')
  AND product IN ('Laptop', 'Mouse', 'Keyboard')
ORDER BY revenue DESC;
/*
Result:
product  | region | revenue
---------|--------|--------
Laptop   | North  | 1999.98
Keyboard | East   | 239.97
Mouse    | South  | 127.50

Use Case: Multiple value matching, filter by list
*/

-- Example 21: NOT IN (exclusion)
SELECT
    first_name,
    dept,
    salary
FROM Employees
WHERE dept NOT IN ('IT', 'Sales')
ORDER BY salary DESC;
/*
Result:
first_name | dept      | salary
-----------|-----------|--------
Emily      | Marketing | 70000

Explanation:
- Excludes IT and Sales departments
- Returns only Marketing employees

Use Case: Exclusion lists, blacklist filtering
*/

-- Example 22: IN with subquery
SELECT
    product,
    quantity,
    unit_price
FROM Sales
WHERE customer_id IN (
    SELECT customer_id
    FROM Sales
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);
/*
This would find products bought by repeat customers
(if any customer made multiple purchases)

Use Case: Subquery filtering, related records
*/

/*
4.2 BETWEEN Operator
━━━━━━━━━━━━━━━━━━━

Syntax: value BETWEEN low AND high
Purpose: Check if value is in range (inclusive)
Equivalent: value >= low AND value <= high
*/

-- Example 23: BETWEEN for ranges
SELECT
    product,
    unit_price,
    quantity,
    sale_date
FROM Sales
WHERE unit_price BETWEEN 50 AND 150
  AND sale_date BETWEEN '2024-03-01' AND '2024-03-05'
ORDER BY unit_price;
/*
Result:
product    | unit_price | quantity | sale_date
-----------|------------|----------|------------
Keyboard   | 79.99      | 3        | 2024-03-03
Headphones | 89.99      | 4        | 2024-03-05
Webcam     | 119.99     | 2        | 2024-03-07

Wait, Webcam is on 03-07, outside range...

Actual Result:
product    | unit_price | quantity | sale_date
-----------|------------|----------|------------
Keyboard   | 79.99      | 3        | 2024-03-03
Headphones | 89.99      | 4        | 2024-03-05

Explanation:
- BETWEEN is inclusive (includes boundaries)
- unit_price 50-150: includes 50 and 150
- Dates: includes both 03-01 and 03-05

Use Case: Range queries, date ranges, price ranges
*/

-- Example 24: NOT BETWEEN (outside range)
SELECT
    product,
    unit_price,
    quantity
FROM Sales
WHERE unit_price NOT BETWEEN 20 AND 100
ORDER BY unit_price DESC;
/*
Result:
product  | unit_price | quantity
---------|------------|----------
Laptop   | 999.99     | 2
Monitor  | 349.99     | 1
Webcam   | 119.99     | 2
USB Cable| 12.99      | 10

Explanation:
- unit_price < 20 OR unit_price > 100
- Excludes values in 20-100 range

Use Case: Outlier detection, exclude middle range
*/

/*
4.3 LIKE Operator (Pattern Matching)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column LIKE pattern
Purpose: Match text patterns
Wildcards: % (any characters), _ (single character)
*/

-- Example 25: LIKE patterns
SELECT
    product,
    unit_price,

    -- Different patterns
    product LIKE 'L%' AS starts_with_L,
    product LIKE '%top%' AS contains_top,
    product LIKE '%e' AS ends_with_e,
    product LIKE '_____' AS exactly_5_chars
FROM Sales
WHERE product LIKE '%a%'  -- Contains 'a'
ORDER BY product;
/*
Result:
product    | unit_price | starts_with_L | contains_top | ends_with_e | exactly_5_chars
-----------|------------|---------------|--------------|-------------|------------------
Desk Lamp  | 45.50      | 0             | 0            | 0           | 0
Headphones | 89.99      | 0             | 0            | 0           | 0
Keyboard   | 79.99      | 0             | 0            | 0           | 0
Laptop     | 999.99     | 1             | 1            | 0           | 0
Webcam     | 119.99     | 0             | 0            | 0           | 0

Explanation:
- % matches any number of characters (including zero)
- _ matches exactly one character
- LIKE is case-insensitive in MySQL (default)

Use Case: Text search, pattern matching, partial matching
*/

-- Example 26: Complex LIKE patterns
SELECT
    first_name,
    last_name,
    dept
FROM Employees
WHERE first_name LIKE 'J%n'     -- Starts with J, ends with n
   OR last_name LIKE '____s%'   -- Exactly 4 chars then 's' then anything
   OR dept LIKE '%ing';         -- Ends with 'ing'
/*
Result:
first_name | last_name | dept
-----------|-----------|------------
John       | Smith     | IT
Sarah      | Johnson   | Sales
Emily      | Brown     | Marketing

Explanation:
- 'J%n': John (starts J, ends n)
- '____s%': (no matches - would need exactly 4 chars before 's')
- '%ing': Marketing (ends with 'ing')

Use Case: Advanced text filtering, name matching
*/

/*
4.4 IS NULL / IS NOT NULL
━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column IS NULL,  column IS NOT NULL
Purpose: Check for NULL values
Important: Cannot use = NULL
*/

-- Example 27: NULL checking
SELECT
    first_name,
    dept,
    manager_id,

    -- NULL checks
    manager_id IS NULL AS is_top_level,
    manager_id IS NOT NULL AS has_manager
FROM Employees;
/*
Result:
first_name | dept      | manager_id | is_top_level | has_manager
-----------|-----------|------------|--------------|-------------
John       | IT        | NULL       | 1            | 0
Sarah      | Sales     | 1          | 0            | 1
Mike       | IT        | 1          | 0            | 1
Emily      | Marketing | NULL       | 1            | 0
David      | Sales     | 2          | 0            | 1

Explanation:
- IS NULL returns TRUE for NULL values
- IS NOT NULL returns TRUE for non-NULL values
- Cannot use: manager_id = NULL (always returns FALSE)

Use Case: Finding missing data, hierarchical data
*/

-- Example 28: COALESCE with NULL
SELECT
    first_name,
    manager_id,
    COALESCE(manager_id, 0) AS manager_id_default,

    CASE
        WHEN manager_id IS NULL THEN 'No Manager'
        ELSE CONCAT('Reports to: ', manager_id)
    END AS reporting_structure
FROM Employees;
/*
Result:
first_name | manager_id | manager_id_default | reporting_structure
-----------|------------|--------------------|-----------------------
John       | NULL       | 0                  | No Manager
Sarah      | 1          | 1                  | Reports to: 1
Mike       | 1          | 1                  | Reports to: 1
Emily      | NULL       | 0                  | No Manager
David      | 2          | 2                  | Reports to: 2

Use Case: NULL handling, default values, conditional display
*/

/*
=================================================================
SECTION 5: LOGICAL OPERATORS
=================================================================

5.1 AND Operator
━━━━━━━━━━━━━━━━

Syntax: condition1 AND condition2 [AND condition3...]
Purpose: All conditions must be TRUE
Truth table:
  TRUE AND TRUE = TRUE
  TRUE AND FALSE = FALSE
  FALSE AND FALSE = FALSE
*/

-- Example 29: Multiple AND conditions
SELECT
    product,
    quantity,
    unit_price,
    discount_pct,
    region
FROM Sales
WHERE quantity >= 3
  AND unit_price < 100
  AND discount_pct > 0
  AND region = 'East';
/*
Result:
product  | quantity | unit_price | discount_pct | region
---------|----------|------------|--------------|--------
Keyboard | 3        | 79.99      | 15.0         | East

Explanation:
- ALL four conditions must be TRUE
- Keyboard: quantity=3 (>=3✓), price=79.99 (<100✓), discount=15 (>0✓), region=East (✓)
- Returns 1 row

Use Case: Precise filtering, multiple requirements
*/

/*
5.2 OR Operator
━━━━━━━━━━━━━━━

Syntax: condition1 OR condition2 [OR condition3...]
Purpose: At least one condition must be TRUE
Truth table:
  TRUE OR TRUE = TRUE
  TRUE OR FALSE = TRUE
  FALSE OR FALSE = FALSE
*/

-- Example 30: Multiple OR conditions
SELECT
    product,
    quantity,
    unit_price,
    region
FROM Sales
WHERE region = 'North'
   OR unit_price > 300
   OR quantity >= 10
ORDER BY unit_price DESC;
/*
Result:
product    | quantity | unit_price | region
-----------|----------|------------|--------
Laptop     | 2        | 999.99     | North     ← North region
Monitor    | 1        | 349.99     | West      ← price > 300
USB Cable  | 10       | 12.99      | South     ← quantity >= 10
Headphones | 4        | 89.99      | North     ← North region

Explanation:
- ANY condition can be TRUE
- Laptop: region=North ✓
- Monitor: price=349.99 > 300 ✓
- USB Cable: quantity=10 >= 10 ✓

Use Case: Multiple alternative criteria, flexible filtering
*/

/*
5.3 NOT Operator
━━━━━━━━━━━━━━━

Syntax: NOT condition
Purpose: Negate/reverse condition
Truth table:
  NOT TRUE = FALSE
  NOT FALSE = TRUE
*/

-- Example 31: NOT with complex conditions
SELECT
    product,
    region,
    unit_price,
    discount_pct
FROM Sales
WHERE NOT (region = 'North' AND discount_pct > 10)
ORDER BY unit_price DESC;
/*
Result: All except (North AND discount > 10)

Explanation:
- NOT reverses the condition
- Excludes: region=North AND discount>10
- Includes: non-North OR discount<=10

Use Case: Complex exclusions, negative logic
*/

/*
5.4 XOR Operator (Exclusive OR) - MySQL specific
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: condition1 XOR condition2
Purpose: TRUE if exactly one condition is TRUE (not both, not neither)
Truth table:
  TRUE XOR TRUE = FALSE
  TRUE XOR FALSE = TRUE
  FALSE XOR TRUE = TRUE
  FALSE XOR FALSE = FALSE
*/

-- Example 32: XOR (one but not both)
SELECT
    product,
    quantity,
    unit_price,

    (quantity > 5) AS high_qty,
    (unit_price > 100) AS high_price,
    (quantity > 5) XOR (unit_price > 100) AS xor_result
FROM Sales;
/*
Result:
product    | quantity | unit_price | high_qty | high_price | xor_result
-----------|----------|------------|----------|------------|------------
Laptop     | 2        | 999.99     | 0        | 1          | 1          ← Only price high
Mouse      | 5        | 25.50      | 0        | 0          | 0          ← Neither
Keyboard   | 3        | 79.99      | 0        | 0          | 0          ← Neither
Monitor    | 1        | 349.99     | 0        | 1          | 1          ← Only price high
Headphones | 4        | 89.99      | 0        | 0          | 0          ← Neither
USB Cable  | 10       | 12.99      | 1        | 0          | 1          ← Only qty high
Webcam     | 2        | 119.99     | 0        | 1          | 1          ← Only price high
Desk Lamp  | 6        | 45.50      | 1        | 0          | 1          ← Only qty high

Explanation:
- XOR = TRUE when exactly one condition is TRUE
- FALSE when both TRUE or both FALSE
- Useful for "one or the other, but not both" logic

Use Case: Either/or validation, exclusive conditions
*/

/*
=================================================================
SECTION 6: SPECIAL OPERATORS
=================================================================

6.1 EXISTS Operator
━━━━━━━━━━━━━━━━━━━

Syntax: EXISTS (subquery)
Purpose: Check if subquery returns any rows
Returns: TRUE if subquery has results, FALSE if empty
*/

-- Example 33: EXISTS with correlated subquery
SELECT
    e1.first_name,
    e1.last_name,
    e1.dept,
    e1.salary
FROM Employees e1
WHERE EXISTS (
    SELECT 1
    FROM Employees e2
    WHERE e2.dept = e1.dept
      AND e2.salary > e1.salary
);
/*
Result: Employees who have higher-paid colleagues in same dept

first_name | last_name | dept  | salary
-----------|-----------|-------|--------
John       | Smith     | IT    | 75000   ← Mike earns more in IT
Sarah      | Johnson   | Sales | 65000   ← (no one earns more in Sales)
David      | Wilson    | Sales | 55000   ← Sarah earns more in Sales

Explanation:
- For each employee, checks if there's someone in same dept with higher salary
- EXISTS returns TRUE if subquery finds matching rows
- Correlated: e2.dept = e1.dept connects inner/outer queries

Use Case: Related record checking, hierarchical queries
*/

-- Example 34: NOT EXISTS (no matching rows)
SELECT
    e1.first_name,
    e1.dept,
    e1.salary
FROM Employees e1
WHERE NOT EXISTS (
    SELECT 1
    FROM Employees e2
    WHERE e2.dept = e1.dept
      AND e2.salary > e1.salary
);
/*
Result: Top earners in each department

first_name | dept      | salary
-----------|-----------|--------
Sarah      | Johnson   | 65000   ← Highest in Sales
Mike       | Davis     | 80000   ← Highest in IT
Emily      | Brown     | 70000   ← Only one in Marketing

Use Case: Finding top/unique records, anti-joins
*/

/*
6.2 ANY Operator
━━━━━━━━━━━━━━━━

Syntax: value operator ANY (subquery)
Purpose: Compare with any value from subquery
Returns: TRUE if comparison is true for ANY value
Operators: =, !=, >, <, >=, <=
*/

-- Example 35: ANY with comparison
SELECT
    first_name,
    dept,
    salary
FROM Employees
WHERE salary > ANY (
    SELECT salary
    FROM Employees
    WHERE dept = 'Sales'
);
/*
Result: Employees earning more than ANY Sales employee

first_name | dept      | salary
-----------|-----------|--------
John       | Smith     | 75000   ← > 55000 (David in Sales)
Sarah      | Johnson   | 65000   ← > 55000 (David in Sales)
Mike       | Davis     | 80000   ← > both Sales employees
Emily      | Brown     | 70000   ← > 55000 (David in Sales)

Explanation:
- Sales salaries: 65000, 55000
- > ANY means: greater than at least one value
- Returns anyone earning > 55000 (the minimum)

Use Case: Threshold comparisons, minimum/maximum checks
*/

-- Example 36: = ANY (equivalent to IN)
SELECT
    product,
    region
FROM Sales
WHERE region = ANY (SELECT region FROM Sales WHERE quantity > 5);
-- Equivalent to: WHERE region IN (SELECT...)
/*
Result: Products from regions that have any sale with quantity > 5

Use Case: Subquery matching (IN alternative)
*/

/*
6.3 ALL Operator
━━━━━━━━━━━━━━━━

Syntax: value operator ALL (subquery)
Purpose: Compare with all values from subquery
Returns: TRUE if comparison is true for ALL values
*/

-- Example 37: ALL with comparison
SELECT
    first_name,
    dept,
    salary
FROM Employees
WHERE salary > ALL (
    SELECT salary
    FROM Employees
    WHERE dept = 'Sales'
);
/*
Result: Employees earning more than ALL Sales employees

first_name | dept      | salary
-----------|-----------|--------
John       | Smith     | 75000   ← > 65000 (highest in Sales)
Mike       | Davis     | 80000   ← > 65000
Emily      | Brown     | 70000   ← > 65000

Explanation:
- Sales salaries: 65000, 55000
- > ALL means: greater than every value
- Returns anyone earning > 65000 (the maximum)

Use Case: Maximum/minimum comparisons, "better than all"
*/

-- Example 38: ALL vs ANY comparison
SELECT
    'ANY Example' AS type,
    COUNT(*) AS count
FROM Employees
WHERE salary > ANY (SELECT salary FROM Employees WHERE dept = 'Sales')

UNION ALL

SELECT
    'ALL Example' AS type,
    COUNT(*) AS count
FROM Employees
WHERE salary > ALL (SELECT salary FROM Employees WHERE dept = 'Sales');
/*
Result:
type        | count
------------|-------
ANY Example | 4      ← Greater than at least one (> 55000)
ALL Example | 3      ← Greater than all (> 65000)

Use Case: Understanding ANY vs ALL differences
*/

/*
=================================================================
SECTION 7: SUBQUERY OPERATORS
=================================================================

7.1 Scalar Subquery (Single Value)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Subquery returns single value, use in comparisons
*/

-- Example 39: Scalar subquery comparison
SELECT
    first_name,
    dept,
    salary,
    (SELECT AVG(salary) FROM Employees) AS avg_salary,
    salary - (SELECT AVG(salary) FROM Employees) AS diff_from_avg,

    CASE
        WHEN salary > (SELECT AVG(salary) FROM Employees) THEN 'Above Average'
        WHEN salary < (SELECT AVG(salary) FROM Employees) THEN 'Below Average'
        ELSE 'Average'
    END AS salary_category
FROM Employees
ORDER BY salary DESC;
/*
Result:
first_name | dept      | salary | avg_salary | diff_from_avg | salary_category
-----------|-----------|--------|------------|---------------|------------------
Mike       | Davis     | 80000  | 69000      | 11000         | Above Average
John       | Smith     | 75000  | 69000      | 6000          | Above Average
Emily      | Brown     | 70000  | 69000      | 1000          | Above Average
Sarah      | Johnson   | 65000  | 69000      | -4000         | Below Average
David      | Wilson    | 55000  | 69000      | -14000        | Below Average

Explanation:
- Scalar subquery: (SELECT AVG(salary)...) returns single value
- Can use in SELECT, WHERE, calculations
- Executed once, result reused

Use Case: Comparing with aggregates, statistical analysis
*/

/*
7.2 Row Subquery (Multiple Columns)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Subquery returns single row with multiple columns
*/

-- Example 40: Row subquery
SELECT
    first_name,
    dept,
    salary
FROM Employees
WHERE (dept, salary) = (
    SELECT dept, MAX(salary)
    FROM Employees
    WHERE dept = 'IT'
    GROUP BY dept
);
/*
Result: Highest paid IT employee

first_name | dept | salary
-----------|------|--------
Mike       | IT   | 80000

Explanation:
- Subquery returns (dept='IT', salary=80000)
- Matches row where both dept AND salary match
- Row comparison: (col1, col2) = (val1, val2)

Use Case: Multi-column matching, complex filters
*/

/*
7.3 Table Subquery (Multiple Rows)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Subquery returns multiple rows (table)
*/

-- Example 41: IN with table subquery
SELECT
    product,
    quantity,
    unit_price,
    region
FROM Sales
WHERE customer_id IN (
    SELECT customer_id
    FROM Sales
    WHERE quantity * unit_price > 500
);
/*
Result: All sales from customers who made large purchases

Use Case: Related records, customer segmentation
*/

-- Example 42: Correlated subquery in SELECT
SELECT
    product,
    quantity,
    unit_price,
    quantity * unit_price AS revenue,

    -- Correlated subquery: average for this product
    (SELECT AVG(quantity * unit_price)
     FROM Sales s2
     WHERE s2.product = Sales.product) AS avg_revenue_for_product,

    -- Compare to average
    CASE
        WHEN quantity * unit_price > (
            SELECT AVG(quantity * unit_price)
            FROM Sales s2
            WHERE s2.product = Sales.product
        ) THEN 'Above Avg'
        ELSE 'Below Avg'
    END AS performance
FROM Sales
ORDER BY product, revenue DESC;
/*
Result: Each sale compared to its product average

Explanation:
- Correlated subquery references outer query (Sales.product)
- Executes for each row in outer query
- Can be slower than JOIN

Use Case: Row-level comparisons, relative metrics
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 43: Complete Sales Calculation with All Operators
SELECT
    id,
    product,
    quantity,
    unit_price,
    discount_pct,
    tax_rate,
    region,

    -- ARITHMETIC: Calculate subtotal
    quantity * unit_price AS subtotal,

    -- ARITHMETIC: Discount amount
    ROUND((quantity * unit_price) * (discount_pct / 100), 2) AS discount_amount,

    -- ARITHMETIC: After discount
    ROUND((quantity * unit_price) * (1 - discount_pct / 100), 2) AS after_discount,

    -- ARITHMETIC: Tax
    ROUND((quantity * unit_price) * (1 - discount_pct / 100) * (tax_rate / 100), 2) AS tax_amount,

    -- ARITHMETIC: Final total
    ROUND((quantity * unit_price) * (1 - discount_pct / 100) * (1 + tax_rate / 100), 2) AS final_total,

    -- CONCATENATION: Receipt line
    CONCAT(quantity, ' × ', product, ' @ $', unit_price, ' = $',
           ROUND(quantity * unit_price, 2)) AS receipt_line,

    -- COMPARISON: Flags
    unit_price > 100 AS is_premium,
    discount_pct > 10 AS has_big_discount,

    -- LOGICAL: Category
    CASE
        WHEN unit_price >= 500 THEN 'Luxury'
        WHEN unit_price >= 100 THEN 'Premium'
        WHEN unit_price >= 50 THEN 'Standard'
        ELSE 'Budget'
    END AS price_category,

    -- SUBQUERY: Compare to product average
    CASE
        WHEN quantity * unit_price > (
            SELECT AVG(quantity * unit_price)
            FROM Sales s2
            WHERE s2.product = Sales.product
        ) THEN 'High Revenue'
        ELSE 'Normal Revenue'
    END AS revenue_level

FROM Sales
WHERE
    -- RELATIONAL: Date range
    sale_date BETWEEN '2024-03-01' AND '2024-03-08'

    -- LOGICAL: Region filter
    AND region IN ('North', 'South', 'East')

    -- COMPARISON: Minimum quantity
    AND quantity >= 2

    -- SPECIAL: Product pattern
    AND product LIKE '%a%'

ORDER BY final_total DESC
LIMIT 5;
/*
Complete sales analysis with all operator types

Use Case: Invoice generation, sales reporting, analytics
*/

-- Example 44: Employee Compensation Analysis
SELECT
    first_name,
    last_name,
    dept,
    salary,
    bonus,

    -- ARITHMETIC: Total compensation
    salary + bonus AS total_comp,

    -- ARITHMETIC: Monthly salary
    ROUND(salary / 12, 2) AS monthly_salary,

    -- ARITHMETIC: Bonus percentage
    ROUND((bonus / salary) * 100, 2) AS bonus_pct,

    -- CONCATENATION: Full name and title
    CONCAT(first_name, ' ', last_name, ' - ', dept) AS employee_title,

    -- COMPARISON & LOGICAL: Compensation tier
    CASE
        WHEN salary + bonus >= 80000 THEN 'Senior'
        WHEN salary + bonus >= 65000 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS level,

    -- SUBQUERY: Compare to department average
    ROUND(salary - (
        SELECT AVG(salary)
        FROM Employees e2
        WHERE e2.dept = Employees.dept
    ), 2) AS diff_from_dept_avg,

    -- SPECIAL: Has manager?
    manager_id IS NOT NULL AS has_manager,

    -- RELATIONAL: Tenure category
    CASE
        WHEN YEAR(CURDATE()) - YEAR(hire_date) >= 5 THEN 'Veteran'
        WHEN YEAR(CURDATE()) - YEAR(hire_date) >= 2 THEN 'Experienced'
        ELSE 'New'
    END AS tenure_category

FROM Employees
WHERE
    -- Active employees only (example condition)
    dept IS NOT NULL

ORDER BY total_comp DESC;
/*
Complete employee analysis with all operator categories

Use Case: HR reporting, compensation analysis, performance review
*/

/*
=================================================================
OPERATOR PRECEDENCE (Order of Evaluation)
=================================================================

From HIGHEST to LOWEST precedence:

1. Parentheses ()
2. Multiplication *, Division /, Modulo %
3. Addition +, Subtraction -
4. Comparison operators =, !=, <>, >, <, >=, <=
5. IS NULL, IS NOT NULL, LIKE, IN, BETWEEN
6. NOT
7. AND
8. OR, XOR

Always use parentheses for clarity!
*/

-- Example 45: Precedence demonstration
SELECT
    product,
    quantity,
    unit_price,

    -- Without parentheses (follows precedence)
    quantity + 10 * unit_price AS without_parens,  -- = quantity + (10 * unit_price)

    -- With parentheses (explicit order)
    (quantity + 10) * unit_price AS with_parens,

    -- Comparison
    quantity > 5 AND unit_price > 50 OR region = 'North' AS complex_logic,
    -- Reads as: (quantity > 5 AND unit_price > 50) OR (region = 'North')

    -- Better with explicit parentheses
    (quantity > 5 AND unit_price > 50) OR region = 'North' AS explicit_logic

FROM Sales
LIMIT 3;
/*
Result shows how precedence affects results

Best Practice: Always use parentheses for clarity!
*/

/*
=================================================================
PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ❌ SLOW: Function on indexed column
SELECT * FROM Sales
WHERE YEAR(sale_date) = 2024;

-- ✓ FAST: Direct comparison
SELECT * FROM Sales
WHERE sale_date >= '2024-01-01' AND sale_date < '2025-01-01';

-- ❌ SLOW: Correlated subquery in SELECT
SELECT product, (SELECT COUNT(*) FROM Sales s2 WHERE s2.product = s1.product)
FROM Sales s1;

-- ✓ FASTER: JOIN or window function
SELECT product, COUNT(*) OVER (PARTITION BY product)
FROM Sales;

-- ❌ SLOW: Multiple OR conditions on different columns
SELECT * FROM Sales
WHERE unit_price > 500 OR quantity > 10 OR discount_pct > 20;

-- ✓ CONSIDER: UNION if selective
SELECT * FROM Sales WHERE unit_price > 500
UNION
SELECT * FROM Sales WHERE quantity > 10
UNION
SELECT * FROM Sales WHERE discount_pct > 20;

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: Integer division truncation
SELECT 5 / 2 AS result;  -- May return 2 (integer division)

-- ✓ CORRECT: Force decimal
SELECT 5.0 / 2 AS result;  -- Returns 2.5
SELECT CAST(5 AS DECIMAL) / 2 AS result;

-- ❌ MISTAKE 2: NULL in arithmetic
SELECT 10 + NULL AS result;  -- Returns NULL

-- ✓ HANDLE: Use COALESCE
SELECT 10 + COALESCE(NULL, 0) AS result;  -- Returns 10

-- ❌ MISTAKE 3: String concatenation with NULL
SELECT CONCAT('Hello', NULL, 'World') AS result;  -- Returns NULL in some databases

-- ✓ HANDLE: Use COALESCE
SELECT CONCAT('Hello', COALESCE(NULL, ''), 'World') AS result;

-- ❌ MISTAKE 4: Wrong operator precedence assumption
SELECT 5 + 3 * 2;  -- Returns 11, not 16

-- ✓ EXPLICIT: Use parentheses
SELECT (5 + 3) * 2;  -- Returns 16

-- ❌ MISTAKE 5: Comparing NULL with =
SELECT * FROM Employees WHERE manager_id = NULL;  -- Returns nothing!

-- ✓ CORRECT: Use IS NULL
SELECT * FROM Employees WHERE manager_id IS NULL;

/*
=================================================================
HINGLISH SUMMARY
=================================================================

SQL Operators data pe operations perform karne ke liye use hote hain.

1. ARITHMETIC Operators - Calculations
   + : Addition (salary + bonus)
   - : Subtraction (price - discount)
   * : Multiplication (quantity * price)
   / : Division (total / count)
   % : Modulo/Remainder (id % 2 for even/odd)
   DIV: Integer division (quantity DIV 2 for pairs)

2. CONCATENATION - Strings combine karna
   CONCAT('First', ' ', 'Last') → 'First Last'
   CONCAT_WS(' | ', val1, val2, val3) → separator automatic
   || : PostgreSQL/Oracle mein (MySQL mein CONCAT use karo)

3. COMPARISON - Values compare karna
   = : Equal to
   != ya <> : Not equal to
   >, <, >=, <= : Greater/less than (or equal)
   Result: TRUE (1) ya FALSE (0)

4. RELATIONAL - Special comparisons
   IN: List mein match (WHERE id IN (1,2,3))
   BETWEEN: Range check (WHERE price BETWEEN 10 AND 100)
   LIKE: Pattern match (WHERE name LIKE '%John%')
   IS NULL: NULL check (NOT: = NULL)

5. LOGICAL - Conditions combine karna
   AND: Saari TRUE chahiye
   OR: Koi ek TRUE ho
   NOT: Reverse karo
   XOR: Exactly ek TRUE (MySQL)
   Precedence: NOT > AND > OR

6. SPECIAL - Advanced operations
   EXISTS: Subquery mein rows hain? (TRUE/FALSE)
   ANY: Koi bhi match ho
   ALL: Sabhi match hon

7. SUBQUERY - Nested queries
   Scalar: Single value (SELECT AVG(price))
   Row: Multiple columns ((dept, salary))
   Table: Multiple rows (IN subquery)
   Correlated: Outer query reference kare

Real-world examples:
- Sales: quantity * unit_price * (1 - discount/100) * (1 + tax/100)
- Employee: salary + bonus, CONCAT(first, ' ', last)
- Filtering: WHERE price BETWEEN 10 AND 100 AND category IN ('A','B')

Operator precedence (high to low):
1. () Parentheses
2. *, /, %
3. +, -
4. =, !=, >, <, >=, <=
5. IS NULL, LIKE, IN, BETWEEN
6. NOT
7. AND
8. OR, XOR

Performance tips:
✓ Use operators on values, not columns (indexing)
✓ Avoid functions on indexed columns
✓ Subqueries can be slow (consider JOINs)
✓ Parentheses for clarity AND correctness

Common mistakes:
❌ Integer division (5/2 = 2, use 5.0/2)
❌ NULL in arithmetic (result NULL hota hai)
❌ = NULL instead of IS NULL
❌ CONCAT with NULL (result NULL)
❌ Wrong precedence assumption

Best practices:
✓ Hamesha parentheses use karo clarity ke liye
✓ NULL properly handle karo (COALESCE)
✓ Decimal division ke liye .0 add karo
✓ Performance ke liye simple operators prefer karo
✓ Subqueries optimize karo ya JOIN use karo

Remember:
- Arithmetic: +, -, *, /, %, DIV
- Concat: CONCAT, CONCAT_WS
- Compare: =, !=, >, <, >=, <=
- Relational: IN, BETWEEN, LIKE, IS NULL
- Logical: AND, OR, NOT, XOR
- Special: EXISTS, ANY, ALL
- Subquery: Scalar, Row, Table, Correlated
- Precedence matters!
- NULL handling critical
- Performance: simple > complex

KEY TAKEAWAYS:
✓ Arithmetic operators for calculations
✓ CONCAT for string building
✓ Comparison operators return TRUE/FALSE
✓ IN, BETWEEN, LIKE for special comparisons
✓ IS NULL for NULL checking (not =)
✓ AND requires all TRUE, OR needs any TRUE
✓ NOT reverses conditions
✓ EXISTS checks if subquery has rows
✓ ANY/ALL compare against subquery results
✓ Precedence: () > */ > +- > compare > NOT > AND > OR
✓ Use parentheses for clarity
✓ Handle NULL explicitly
✓ Watch integer vs decimal division
✓ Consider performance implications
✓ Test complex operator combinations

=================================================================
*/

-- Final comprehensive example combining ALL operators:
SELECT
    -- CONCATENATION
    CONCAT(id, '-', product) AS order_id,
    product,

    -- ARITHMETIC
    quantity,
    unit_price,
    quantity * unit_price AS subtotal,
    ROUND(quantity * unit_price * (discount_pct/100), 2) AS discount_amt,
    ROUND(quantity * unit_price * (1 - discount_pct/100), 2) AS after_discount,

    -- COMPARISON & LOGICAL
    CASE
        WHEN unit_price >= 500 AND quantity >= 2 THEN 'VIP Sale'
        WHEN unit_price >= 100 OR quantity >= 5 THEN 'High Value'
        ELSE 'Standard'
    END AS sale_type,

    -- RELATIONAL
    region IN ('North', 'South') AS is_major_region,
    sale_date BETWEEN '2024-03-01' AND '2024-03-07' AS is_first_week,

    -- SUBQUERY with SPECIAL operators
    quantity * unit_price > (SELECT AVG(quantity * unit_price) FROM Sales) AS above_avg,

    EXISTS (
        SELECT 1 FROM Sales s2
        WHERE s2.customer_id = Sales.customer_id
        AND s2.id != Sales.id
    ) AS is_repeat_customer

FROM Sales
WHERE
    -- ALL operator types in WHERE
    (quantity >= 2 AND unit_price > 25)  -- ARITHMETIC comparison
    OR region = 'North'                   -- COMPARISON
    AND product LIKE '%a%'                -- RELATIONAL
    AND discount_pct IS NOT NULL          -- IS NULL check

ORDER BY quantity * unit_price DESC;
