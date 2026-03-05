/*
=================================================================
QUERY PURPOSE: Filter rows based on specified conditions
=================================================================

CONCEPT EXPLANATION (English):
The WHERE clause is one of the most fundamental and important parts of SQL.
It filters rows from a table based on conditions you specify, allowing you
to retrieve, update, or delete only the data that meets your criteria.

Think of WHERE as a "filter" or "gatekeeper" that:
- Examines each row individually
- Evaluates your condition(s) for that row
- Includes the row in results if condition is TRUE
- Excludes the row if condition is FALSE or NULL

WHERE clause works with:
- SELECT statements (filter which rows to retrieve)
- UPDATE statements (filter which rows to modify)
- DELETE statements (filter which rows to remove)

Key concepts:
- WHERE comes AFTER FROM clause
- WHERE comes BEFORE GROUP BY, HAVING, ORDER BY
- Can use comparison operators (=, >, <, >=, <=, !=, <>)
- Can use logical operators (AND, OR, NOT)
- Can use special operators (IN, BETWEEN, LIKE, IS NULL)
- Can combine multiple conditions
- Supports subqueries for complex filtering
- Can use functions, but may impact performance

The WHERE clause is essential for:
- Data retrieval: Getting specific records
- Data analysis: Filtering for relevant information
- Data modification: Updating/deleting specific rows
- Performance: Reducing data processed
- Business logic: Implementing filtering rules
- Security: Row-level access control

CONCEPT EXPLANATION (Hinglish):
WHERE clause SQL ka sabse fundamental aur important part hai. Yeh table
se rows ko aapke specified conditions ke basis pe filter karta hai, jisse
aap sirf woh data retrieve, update, ya delete kar sakte ho jo aapke
criteria ko meet karta hai.

WHERE ko ek "filter" ya "gatekeeper" samjho jo:
- Har row ko individually examine karta hai
- Us row ke liye aapki condition evaluate karta hai
- Row ko results mein include karta hai agar condition TRUE hai
- Row ko exclude karta hai agar condition FALSE ya NULL hai

WHERE clause kaam karta hai:
- SELECT statements ke saath (kaunsi rows retrieve karni hain)
- UPDATE statements ke saath (kaunsi rows modify karni hain)
- DELETE statements ke saath (kaunsi rows remove karni hain)

Key concepts:
- WHERE, FROM clause ke BAAD aata hai
- WHERE, GROUP BY, HAVING, ORDER BY se PEHLE aata hai
- Comparison operators use kar sakte ho (=, >, <, >=, <=, !=, <>)
- Logical operators use kar sakte ho (AND, OR, NOT)
- Special operators use kar sakte ho (IN, BETWEEN, LIKE, IS NULL)
- Multiple conditions combine kar sakte ho
- Complex filtering ke liye subqueries support karta hai
- Functions use kar sakte ho, lekin performance affect ho sakta hai

WHERE clause zaroori hai:
- Data retrieval ke liye: Specific records nikalna
- Data analysis ke liye: Relevant information filter karna
- Data modification ke liye: Specific rows update/delete karna
- Performance ke liye: Processed data reduce karna
- Business logic ke liye: Filtering rules implement karna
- Security ke liye: Row-level access control

USE CASES:
- E-commerce: Filter products by category, price range, availability
- HR: Find employees by department, salary range, hire date
- Finance: Filter transactions by date, amount, status
- Healthcare: Find patients by age, diagnosis, appointment date
- Education: Filter students by grade, enrollment status
- CRM: Find customers by location, purchase history, status
- Analytics: Filter data for specific time periods, segments
- Reports: Generate filtered reports for specific criteria
- Data validation: Find records with missing/invalid data
- Compliance: Filter records requiring action/review

SAMPLE DATA (Products table):

id | product_name        | category     | price  | stock | supplier_id | rating | created_date | is_active
---|---------------------|--------------|--------|-------|-------------|--------|--------------|----------
1  | Laptop Pro 15       | Electronics  | 999.99 | 45    | 101         | 4.5    | 2024-01-15   | 1
2  | Wireless Mouse      | Electronics  | 25.50  | 150   | 102         | 4.2    | 2024-02-20   | 1
3  | Office Chair        | Furniture    | 299.00 | 30    | 103         | 4.8    | 2023-11-10   | 1
4  | Standing Desk       | Furniture    | 599.00 | 12    | 103         | 4.6    | 2024-01-05   | 1
5  | USB-C Cable         | Electronics  | 15.99  | 0     | 102         | 3.9    | 2024-03-01   | 0
6  | Ergonomic Keyboard  | Electronics  | 79.99  | 75    | 101         | 4.7    | 2024-02-14   | 1
7  | Monitor 27"         | Electronics  | 349.99 | 8     | 104         | 4.4    | 2023-12-20   | 1
8  | Desk Lamp           | Furniture    | 45.50  | 60    | 105         | 4.1    | 2024-01-25   | 1
9  | Webcam HD           | Electronics  | 89.99  | 0     | 104         | 4.0    | 2024-03-10   | 0
10 | Bookshelf           | Furniture    | 199.00 | 25    | 103         | 4.3    | 2023-10-15   | 1

Additional sample (Orders table):

id | customer_id | order_date | total_amount | status     | payment_method
---|-------------|------------|--------------|------------|---------------
1  | 201         | 2024-03-01 | 1024.99      | Delivered  | Credit Card
2  | 202         | 2024-03-02 | 325.49       | Shipped    | PayPal
3  | 203         | 2024-03-03 | 599.00       | Processing | Debit Card
4  | 201         | 2024-03-04 | 79.99        | Delivered  | Credit Card
5  | 204         | 2024-03-05 | 1599.99      | Cancelled  | Credit Card
6  | 205         | 2024-03-06 | 45.50        | Delivered  | Cash
7  | 202         | 2024-03-07 | 899.99       | Shipped    | PayPal
8  | 206         | 2024-03-08 | 299.00       | Processing | Debit Card

=================================================================
SECTION 1: BASIC WHERE WITH COMPARISON OPERATORS
=================================================================

1.1 Equality Operator (=)
━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column = value
Purpose: Exact match
Use: When you need precise matching
*/

-- Example 1: Filter by exact category
SELECT
    product_name,
    category,
    price
FROM Products
WHERE category = 'Electronics';
/*
Result:
product_name       | category    | price
-------------------|-------------|--------
Laptop Pro 15      | Electronics | 999.99
Wireless Mouse     | Electronics | 25.50
USB-C Cable        | Electronics | 15.99
Ergonomic Keyboard | Electronics | 79.99
Monitor 27"        | Electronics | 349.99
Webcam HD          | Electronics | 89.99

Explanation:
- Filters rows where category column EXACTLY equals 'Electronics'
- Case-sensitive in some databases (PostgreSQL), insensitive in others (MySQL default)
- Returns 6 out of 10 products

Use Case: Category filtering, status filtering, exact ID lookup
*/

-- Example 2: Filter by exact price
SELECT
    product_name,
    price,
    stock
FROM Products
WHERE price = 299.00;
/*
Result:
product_name | price  | stock
-------------|--------|-------
Office Chair | 299.00 | 30

Explanation:
- Finds products with price exactly 299.00
- Numeric comparison (no quotes needed)
- Decimal precision matters: 299.00 = 299.0 = 299

Use Case: Price point analysis, finding specific values
*/

-- Example 3: Filter by boolean/bit column
SELECT
    product_name,
    price,
    is_active
FROM Products
WHERE is_active = 1;  -- or TRUE in some databases
/*
Result:
product_name       | price  | is_active
-------------------|--------|----------
Laptop Pro 15      | 999.99 | 1
Wireless Mouse     | 25.50  | 1
Office Chair       | 299.00 | 1
Standing Desk      | 599.00 | 1
Ergonomic Keyboard | 79.99  | 1
Monitor 27"        | 349.99 | 1
Desk Lamp          | 45.50  | 1
Bookshelf          | 199.00 | 1

Explanation:
- Filters for active products only
- 1 = TRUE, 0 = FALSE (in MySQL, SQL Server)
- Some databases use TRUE/FALSE keywords
- Excludes 2 inactive products

Use Case: Active records, enabled features, published content
*/

/*
1.2 Inequality Operators (!=, <>)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column != value  OR  column <> value
Purpose: Not equal to
Use: Exclude specific values
Note: != and <> are equivalent (both mean "not equal")
*/

-- Example 4: Exclude specific category
SELECT
    product_name,
    category,
    price
FROM Products
WHERE category != 'Furniture';  -- Same as: category <> 'Furniture'
/*
Result:
product_name       | category    | price
-------------------|-------------|--------
Laptop Pro 15      | Electronics | 999.99
Wireless Mouse     | Electronics | 25.50
USB-C Cable        | Electronics | 15.99
Ergonomic Keyboard | Electronics | 79.99
Monitor 27"        | Electronics | 349.99
Webcam HD          | Electronics | 89.99

Explanation:
- Returns all products EXCEPT Furniture category
- Opposite of category = 'Furniture'
- Both != and <> work the same way
- Excludes 4 furniture items

Use Case: Exclusion filters, "show everything except X"
*/

-- Example 5: Exclude specific status
SELECT
    id,
    customer_id,
    total_amount,
    status
FROM Orders
WHERE status <> 'Cancelled';
/*
Result:
id | customer_id | total_amount | status
---|-------------|--------------|------------
1  | 201         | 1024.99      | Delivered
2  | 202         | 325.49       | Shipped
3  | 203         | 599.00       | Processing
4  | 201         | 79.99        | Delivered
6  | 205         | 45.50        | Delivered
7  | 202         | 899.99       | Shipped
8  | 206         | 299.00       | Processing

Explanation:
- Excludes cancelled orders
- Includes all other statuses (Delivered, Shipped, Processing)
- Returns 7 out of 8 orders

Use Case: Active orders, valid records, non-error states
*/

/*
1.3 Greater Than (>), Less Than (<)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  column > value   (greater than)
  column < value   (less than)
Purpose: Range filtering (one-sided)
Use: Threshold filtering, minimum/maximum bounds
*/

-- Example 6: Products above certain price
SELECT
    product_name,
    price,
    category
FROM Products
WHERE price > 100;
/*
Result:
product_name  | price  | category
--------------|--------|------------
Laptop Pro 15 | 999.99 | Electronics
Office Chair  | 299.00 | Furniture
Standing Desk | 599.00 | Furniture
Monitor 27"   | 349.99 | Electronics
Bookshelf     | 199.00 | Furniture

Explanation:
- Returns products with price GREATER than 100
- Does NOT include price = 100 (use >= for that)
- Returns 5 products

Use Case: Premium products, high-value items, threshold filtering
*/

-- Example 7: Low stock alert
SELECT
    product_name,
    stock,
    price
FROM Products
WHERE stock < 20;
/*
Result:
product_name  | stock | price
--------------|-------|--------
Standing Desk | 12    | 599.00
USB-C Cable   | 0     | 15.99
Monitor 27"   | 8     | 349.99
Webcam HD     | 0     | 89.99

Explanation:
- Returns products with stock LESS than 20
- Includes stock = 0 (out of stock items)
- Returns 4 products needing reorder

Use Case: Inventory alerts, low stock warnings, reorder triggers
*/

/*
1.4 Greater/Less Than or Equal (>=, <=)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  column >= value  (greater than or equal to)
  column <= value  (less than or equal to)
Purpose: Inclusive range filtering
Use: Minimum/maximum with boundary inclusion
*/

-- Example 8: Products in mid-price range (inclusive)
SELECT
    product_name,
    price,
    category
FROM Products
WHERE price >= 50 AND price <= 300;
/*
Result:
product_name       | price  | category
-------------------|--------|------------
Office Chair       | 299.00 | Furniture
Ergonomic Keyboard | 79.99  | Electronics
Webcam HD          | 89.99  | Electronics

Explanation:
- Returns products with price from 50 to 300 (both inclusive)
- Includes boundaries: 50 and 300 would be included
- Uses AND to combine two conditions
- Returns 3 products

Use Case: Price range filters, budget constraints, target segments
*/

-- Example 9: Recent products (last 3 months)
SELECT
    product_name,
    created_date,
    price
FROM Products
WHERE created_date >= '2024-01-01';
/*
Result:
product_name       | created_date | price
-------------------|--------------|--------
Laptop Pro 15      | 2024-01-15   | 999.99
Wireless Mouse     | 2024-02-20   | 25.50
Standing Desk      | 2024-01-05   | 599.00
USB-C Cable        | 2024-03-01   | 15.99
Ergonomic Keyboard | 2024-02-14   | 79.99
Desk Lamp          | 2024-01-25   | 45.50
Webcam HD          | 2024-03-10   | 89.99

Explanation:
- Returns products created on or after January 1, 2024
- Date comparison works with standard format 'YYYY-MM-DD'
- Includes the boundary date (2024-01-01)
- Returns 7 products

Use Case: Recent data, time-based filtering, new arrivals
*/

/*
=================================================================
SECTION 2: LOGICAL OPERATORS (AND, OR, NOT)
=================================================================

2.1 AND - All Conditions Must Be True
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: condition1 AND condition2 [AND condition3...]
Purpose: Combine multiple conditions (intersection)
Result: TRUE only if ALL conditions are TRUE
*/

-- Example 10: Multiple criteria (AND)
SELECT
    product_name,
    category,
    price,
    stock
FROM Products
WHERE category = 'Electronics'
  AND price < 100
  AND stock > 0;
/*
Result:
product_name       | category    | price | stock
-------------------|-------------|-------|-------
Wireless Mouse     | Electronics | 25.50 | 150
Ergonomic Keyboard | Electronics | 79.99 | 75
Webcam HD          | Electronics | 89.99 | 0

Wait, Webcam has stock = 0, so it should be excluded!

Actual Result:
product_name       | category    | price | stock
-------------------|-------------|-------|-------
Wireless Mouse     | Electronics | 25.50 | 150
Ergonomic Keyboard | Electronics | 79.99 | 75

Explanation:
- ALL three conditions must be TRUE
- category = 'Electronics' → filters to 6 products
- price < 100 → further filters to 3 products
- stock > 0 → excludes out-of-stock items
- Final result: 2 products that meet all criteria

Use Case: Refined searches, available affordable electronics
*/

-- Example 11: Date range with category
SELECT
    product_name,
    category,
    created_date,
    price
FROM Products
WHERE category = 'Furniture'
  AND created_date >= '2024-01-01'
  AND created_date < '2024-02-01';
/*
Result:
product_name  | category  | created_date | price
--------------|-----------|--------------|--------
Standing Desk | Furniture | 2024-01-05   | 599.00
Desk Lamp     | Furniture | 2024-01-25   | 45.50

Explanation:
- Furniture items created in January 2024
- Three conditions combined with AND
- Date range: Jan 1 to Jan 31, 2024
- Returns 2 products

Use Case: Category-specific date filtering, monthly reports
*/

/*
2.2 OR - At Least One Condition Must Be True
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: condition1 OR condition2 [OR condition3...]
Purpose: Alternative conditions (union)
Result: TRUE if ANY condition is TRUE
*/

-- Example 12: Multiple categories (OR)
SELECT
    product_name,
    category,
    price
FROM Products
WHERE category = 'Electronics'
   OR category = 'Furniture';
/*
Result: All 10 products (since we only have these 2 categories)

product_name       | category    | price
-------------------|-------------|--------
Laptop Pro 15      | Electronics | 999.99
Wireless Mouse     | Electronics | 25.50
Office Chair       | Furniture   | 299.00
Standing Desk      | Furniture   | 599.00
USB-C Cable        | Electronics | 15.99
Ergonomic Keyboard | Electronics | 79.99
Monitor 27"        | Electronics | 349.99
Desk Lamp          | Furniture   | 45.50
Webcam HD          | Electronics | 89.99
Bookshelf          | Furniture   | 199.00

Explanation:
- Returns products from EITHER category
- Includes products matching ANY condition
- Broader results than AND

Use Case: Multiple category selection, flexible filtering
*/

-- Example 13: Out of stock OR low stock
SELECT
    product_name,
    stock,
    price
FROM Products
WHERE stock = 0 OR stock < 20;
/*
Result:
product_name  | stock | price
--------------|-------|--------
Standing Desk | 12    | 599.00
USB-C Cable   | 0     | 15.99
Monitor 27"   | 8     | 349.99
Webcam HD     | 0     | 89.99

Explanation:
- Returns products that are EITHER out of stock OR have low stock
- Includes stock = 0 (first condition)
- Also includes stock < 20 (second condition)
- Returns 4 products

Use Case: Inventory alerts, restock notifications
*/

/*
2.3 NOT - Negates a Condition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: NOT condition
Purpose: Reverse/negate a condition
Result: TRUE becomes FALSE, FALSE becomes TRUE
*/

-- Example 14: NOT with equality
SELECT
    product_name,
    category,
    price
FROM Products
WHERE NOT (category = 'Electronics');
-- Same as: WHERE category != 'Electronics'
/*
Result:
product_name  | category  | price
--------------|-----------|--------
Office Chair  | Furniture | 299.00
Standing Desk | Furniture | 599.00
Desk Lamp     | Furniture | 45.50
Bookshelf     | Furniture | 199.00

Explanation:
- NOT reverses the condition
- Returns everything EXCEPT Electronics
- Parentheses optional but improve readability

Use Case: Exclusion logic, negative filtering
*/

-- Example 15: Complex NOT with AND
SELECT
    product_name,
    category,
    price,
    stock
FROM Products
WHERE NOT (category = 'Electronics' AND price > 100);
/*
Result:
product_name       | category    | price  | stock
-------------------|-------------|--------|-------
Wireless Mouse     | Electronics | 25.50  | 150
Office Chair       | Furniture   | 299.00 | 30
Standing Desk      | Furniture   | 599.00 | 12
USB-C Cable        | Electronics | 15.99  | 0
Ergonomic Keyboard | Electronics | 79.99  | 75
Desk Lamp          | Furniture   | 45.50  | 60
Webcam HD          | Electronics | 89.99  | 0
Bookshelf          | Furniture   | 199.00 | 25

Explanation:
- NOT (Electronics AND price > 100)
- Excludes expensive electronics
- Includes: all Furniture + affordable Electronics
- Returns 8 products

Use Case: Exclusion of specific combinations
*/

/*
2.4 Combining AND, OR with Parentheses
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Importance: Operator precedence is NOT > AND > OR
Use parentheses to control evaluation order
*/

-- Example 16: Without parentheses (may be ambiguous)
SELECT
    product_name,
    category,
    price,
    stock
FROM Products
WHERE category = 'Electronics' AND price < 100 OR stock < 20;
/*
Due to precedence (AND before OR), this reads as:
  (category = 'Electronics' AND price < 100) OR (stock < 20)

Result includes:
- Affordable electronics (<$100) OR
- Any product with low stock (<20)

Result:
product_name       | category    | price  | stock
-------------------|-------------|--------|-------
Wireless Mouse     | Electronics | 25.50  | 150    ← affordable electronics
Standing Desk      | Furniture   | 599.00 | 12     ← low stock
USB-C Cable        | Electronics | 15.99  | 0      ← both!
Ergonomic Keyboard | Electronics | 79.99  | 75     ← affordable electronics
Monitor 27"        | Electronics | 349.99 | 8      ← low stock
Webcam HD          | Electronics | 89.99  | 0      ← both!

Use Case: Multiple independent criteria
*/

-- Example 17: With parentheses (explicit logic)
SELECT
    product_name,
    category,
    price,
    stock
FROM Products
WHERE category = 'Electronics'
  AND (price < 100 OR stock < 20);
/*
Reads as: Electronics AND (affordable OR low stock)

Result:
product_name       | category    | price  | stock
-------------------|-------------|--------|-------
Wireless Mouse     | Electronics | 25.50  | 150
USB-C Cable        | Electronics | 15.99  | 0
Ergonomic Keyboard | Electronics | 79.99  | 75
Monitor 27"        | Electronics | 349.99 | 8
Webcam HD          | Electronics | 89.99  | 0

Explanation:
- Must be Electronics (required)
- AND either affordable OR low stock
- More restrictive than Example 16

Use Case: Category-specific conditions
*/

/*
=================================================================
SECTION 3: SPECIAL OPERATORS
=================================================================

3.1 IN - Match Any Value in List
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column IN (value1, value2, value3, ...)
Purpose: Check if value matches any in the list
Equivalent: col = val1 OR col = val2 OR col = val3...
*/

-- Example 18: Filter by multiple values (IN)
SELECT
    id,
    customer_id,
    status,
    total_amount
FROM Orders
WHERE status IN ('Delivered', 'Shipped');
/*
Result:
id | customer_id | status    | total_amount
---|-------------|-----------|-------------
1  | 201         | Delivered | 1024.99
2  | 202         | Shipped   | 325.49
4  | 201         | Delivered | 79.99
6  | 205         | Delivered | 45.50
7  | 202         | Shipped   | 899.99

Explanation:
- Returns orders with status EITHER 'Delivered' OR 'Shipped'
- Cleaner than: WHERE status = 'Delivered' OR status = 'Shipped'
- Returns 5 orders

Use Case: Multiple selection filters, status filtering
*/

-- Example 19: NOT IN (exclusion)
SELECT
    product_name,
    supplier_id,
    price
FROM Products
WHERE supplier_id NOT IN (101, 102);
/*
Result:
product_name  | supplier_id | price
--------------|-------------|--------
Office Chair  | 103         | 299.00
Standing Desk | 103         | 599.00
Monitor 27"   | 104         | 349.99
Desk Lamp     | 105         | 45.50
Webcam HD     | 104         | 89.99
Bookshelf     | 103         | 199.00

Explanation:
- Excludes products from suppliers 101 and 102
- Returns products from suppliers 103, 104, 105
- Returns 6 products

Use Case: Vendor exclusions, blacklist filtering
*/

-- Example 20: IN with subquery
SELECT
    product_name,
    category,
    price
FROM Products
WHERE category IN (
    SELECT DISTINCT category
    FROM Products
    WHERE price > 500
);
/*
Result:
product_name       | category    | price
-------------------|-------------|--------
Laptop Pro 15      | Electronics | 999.99
Wireless Mouse     | Electronics | 25.50
Office Chair       | Furniture   | 299.00
Standing Desk      | Furniture   | 599.00
USB-C Cable        | Electronics | 15.99
Ergonomic Keyboard | Electronics | 79.99
Monitor 27"        | Electronics | 349.99
Desk Lamp          | Furniture   | 45.50
Webcam HD          | Electronics | 89.99
Bookshelf          | Furniture   | 199.00

Explanation:
- Subquery finds categories with items > $500
- Returns: Electronics and Furniture
- Main query returns ALL products in those categories
- Even products under $500 are included

Use Case: Conditional category filtering, related records
*/

/*
3.2 BETWEEN - Range Matching (Inclusive)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column BETWEEN low_value AND high_value
Purpose: Check if value is within range (inclusive)
Equivalent: column >= low_value AND column <= high_value
Note: INCLUSIVE of both boundaries
*/

-- Example 21: Price range with BETWEEN
SELECT
    product_name,
    price,
    category
FROM Products
WHERE price BETWEEN 50 AND 300;
/*
Result:
product_name       | price  | category
-------------------|--------|------------
Office Chair       | 299.00 | Furniture
Ergonomic Keyboard | 79.99  | Electronics
Webcam HD          | 89.99  | Electronics
Bookshelf          | 199.00 | Furniture

Explanation:
- Returns products with price from 50 to 300 (inclusive)
- Includes boundaries: 50 and 300 would be included
- Cleaner than: WHERE price >= 50 AND price <= 300
- Returns 4 products

Use Case: Price filters, age ranges, date ranges
*/

-- Example 22: Date range with BETWEEN
SELECT
    product_name,
    created_date,
    price
FROM Products
WHERE created_date BETWEEN '2024-01-01' AND '2024-02-29';
/*
Result:
product_name       | created_date | price
-------------------|--------------|--------
Laptop Pro 15      | 2024-01-15   | 999.99
Wireless Mouse     | 2024-02-20   | 25.50
Standing Desk      | 2024-01-05   | 599.00
Ergonomic Keyboard | 2024-02-14   | 79.99
Desk Lamp          | 2024-01-25   | 45.50

Explanation:
- Returns products created in January and February 2024
- Includes both boundary dates
- Works with DATE, DATETIME, TIMESTAMP columns
- Returns 5 products

Use Case: Date range filters, reporting periods
*/

-- Example 23: NOT BETWEEN (outside range)
SELECT
    product_name,
    price,
    stock
FROM Products
WHERE price NOT BETWEEN 50 AND 500;
/*
Result:
product_name  | price  | stock
--------------|--------|-------
Laptop Pro 15 | 999.99 | 45
Wireless Mouse| 25.50  | 150
USB-C Cable   | 15.99  | 0
Standing Desk | 599.00 | 12
Desk Lamp     | 45.50  | 60

Explanation:
- Returns products with price OUTSIDE 50-500 range
- price < 50 OR price > 500
- Returns 5 products

Use Case: Outlier detection, exclude middle range
*/

/*
3.3 LIKE - Pattern Matching
━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column LIKE pattern
Purpose: Match text patterns with wildcards
Wildcards:
  % - matches any sequence of characters (0 or more)
  _ - matches exactly one character
*/

-- Example 24: Starts with pattern
SELECT
    product_name,
    category,
    price
FROM Products
WHERE product_name LIKE 'Laptop%';
/*
Result:
product_name  | category    | price
--------------|-------------|--------
Laptop Pro 15 | Electronics | 999.99

Explanation:
- % matches any characters after "Laptop"
- Finds products starting with "Laptop"
- Case-sensitive in some databases (PostgreSQL)
- Case-insensitive in MySQL (default)

Use Case: Search by prefix, autocomplete suggestions
*/

-- Example 25: Contains pattern
SELECT
    product_name,
    category,
    price
FROM Products
WHERE product_name LIKE '%Desk%';
/*
Result:
product_name  | category  | price
--------------|-----------|--------
Standing Desk | Furniture | 599.00
Desk Lamp     | Furniture | 45.50

Explanation:
- %Desk% matches "Desk" anywhere in the string
- Finds both "Standing Desk" and "Desk Lamp"
- Returns 2 products

Use Case: Full-text search, keyword matching
*/

-- Example 26: Ends with pattern
SELECT
    product_name,
    category,
    price
FROM Products
WHERE product_name LIKE '%Chair';
/*
Result:
product_name | category  | price
-------------|-----------|--------
Office Chair | Furniture | 299.00

Explanation:
- Matches products ending with "Chair"
- % matches any characters before "Chair"

Use Case: Suffix matching, file extensions
*/

-- Example 27: Specific length pattern (_)
SELECT
    product_name,
    category,
    price
FROM Products
WHERE product_name LIKE 'Monitor __"';
/*
Result:
product_name | category    | price
-------------|-------------|--------
Monitor 27"  | Electronics | 349.99

Explanation:
- __ (two underscores) matches exactly 2 characters
- Matches "27" in "Monitor 27""
- Useful for fixed-length patterns

Use Case: Fixed-length codes, formatted data
*/

-- Example 28: NOT LIKE (exclusion)
SELECT
    product_name,
    category
FROM Products
WHERE product_name NOT LIKE '%USB%'
  AND product_name NOT LIKE '%Cable%';
/*
Result: All products except USB-C Cable

Use Case: Exclude specific patterns, content filtering
*/

/*
3.4 IS NULL / IS NOT NULL
━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column IS NULL  OR  column IS NOT NULL
Purpose: Check for NULL values
Important: Cannot use = NULL or != NULL
*/

-- Example 29: Find NULL values
-- (First, let's add a column that might have NULLs)
ALTER TABLE Products ADD COLUMN discount DECIMAL(5,2);
UPDATE Products SET discount = 10.00 WHERE id IN (1, 3, 5);

SELECT
    product_name,
    price,
    discount
FROM Products
WHERE discount IS NULL;
/*
Result:
product_name       | price  | discount
-------------------|--------|----------
Wireless Mouse     | 25.50  | NULL
Standing Desk      | 599.00 | NULL
Ergonomic Keyboard | 79.99  | NULL
Monitor 27"        | 349.99 | NULL
Desk Lamp          | 45.50  | NULL
Webcam HD          | 89.99  | NULL
Bookshelf          | 199.00 | NULL

Explanation:
- IS NULL finds rows where discount is NULL
- Cannot use: WHERE discount = NULL (always returns nothing)
- Returns products without discounts

Use Case: Find missing data, incomplete records
*/

-- Example 30: Find non-NULL values
SELECT
    product_name,
    price,
    discount
FROM Products
WHERE discount IS NOT NULL;
/*
Result:
product_name  | price  | discount
--------------|--------|----------
Laptop Pro 15 | 999.99 | 10.00
Office Chair  | 299.00 | 10.00
USB-C Cable   | 15.99  | 10.00

Explanation:
- IS NOT NULL finds rows with actual values
- Excludes NULL values
- Returns products with discounts

Use Case: Complete records, required fields validation
*/

-- Clean up
ALTER TABLE Products DROP COLUMN discount;

/*
=================================================================
SECTION 4: WHERE WITH FUNCTIONS
=================================================================

4.1 String Functions in WHERE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Note: Functions on columns prevent index usage
*/

-- Example 31: Case-insensitive search
SELECT
    product_name,
    category,
    price
FROM Products
WHERE LOWER(product_name) LIKE '%mouse%';
/*
Result:
product_name   | category    | price
---------------|-------------|-------
Wireless Mouse | Electronics | 25.50

Explanation:
- LOWER() converts to lowercase for case-insensitive match
- Matches 'Mouse', 'mouse', 'MOUSE', etc.

⚠️ Performance note: Can't use index on product_name

Use Case: User search (case-insensitive)
*/

-- Example 32: String length filtering
SELECT
    product_name,
    LENGTH(product_name) AS name_length
FROM Products
WHERE LENGTH(product_name) > 15;
/*
Result:
product_name       | name_length
-------------------|------------
Ergonomic Keyboard | 18

Use Case: Data validation, display constraints
*/

/*
4.2 Date Functions in WHERE
━━━━━━━━━━━━━━━━━━━━━━━━━━

Extract date parts for filtering
*/

-- Example 33: Filter by month
SELECT
    product_name,
    created_date
FROM Products
WHERE MONTH(created_date) = 2;
/*
Result:
product_name       | created_date
-------------------|-------------
Wireless Mouse     | 2024-02-20
Ergonomic Keyboard | 2024-02-14

Explanation:
- MONTH() extracts month number (1-12)
- Filters for February (month 2)

⚠️ Better for performance:
WHERE created_date >= '2024-02-01' AND created_date < '2024-03-01'

Use Case: Monthly reports, seasonal filtering
*/

-- Example 34: Filter by year
SELECT
    product_name,
    created_date,
    price
FROM Products
WHERE YEAR(created_date) = 2023;
/*
Result:
product_name | created_date | price
-------------|--------------|--------
Office Chair | 2023-11-10   | 299.00
Monitor 27"  | 2023-12-20   | 349.99
Bookshelf    | 2023-10-15   | 199.00

Use Case: Yearly analysis, historical data
*/

/*
4.3 Numeric Functions in WHERE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Calculations in WHERE clause
*/

-- Example 35: Calculated field filtering
SELECT
    product_name,
    price,
    stock,
    (price * stock) AS inventory_value
FROM Products
WHERE (price * stock) > 5000;
/*
Result:
product_name       | price  | stock | inventory_value
-------------------|--------|-------|----------------
Laptop Pro 15      | 999.99 | 45    | 44999.55
Ergonomic Keyboard | 79.99  | 75    | 5999.25

Explanation:
- Filters by calculated inventory value
- Must repeat calculation in WHERE (can't use alias)

Use Case: High-value inventory, calculated metrics
*/

-- Example 36: ROUND in WHERE
SELECT
    product_name,
    price,
    ROUND(price, 0) AS rounded_price
FROM Products
WHERE ROUND(price, 0) = 300;
/*
Result:
product_name | price  | rounded_price
-------------|--------|---------------
Office Chair | 299.00 | 299
Monitor 27"  | 349.99 | 350

Wait, this doesn't include 299, let me recalculate...

Actual Result:
product_name | price  | rounded_price
-------------|--------|---------------
Office Chair | 299.00 | 299

(Office Chair rounds to 299, not 300)

Use Case: Approximate matching, rounding logic
*/

/*
=================================================================
SECTION 5: WHERE WITH SUBQUERIES
=================================================================

5.1 Subquery with IN
━━━━━━━━━━━━━━━━━━━

Use subquery result in IN clause
*/

-- Example 37: Products from top suppliers
SELECT
    product_name,
    supplier_id,
    price
FROM Products
WHERE supplier_id IN (
    SELECT supplier_id
    FROM Products
    GROUP BY supplier_id
    HAVING COUNT(*) >= 2
);
/*
Result:
product_name       | supplier_id | price
-------------------|-------------|--------
Laptop Pro 15      | 101         | 999.99
Wireless Mouse     | 102         | 25.50
Office Chair       | 103         | 299.00
Standing Desk      | 103         | 599.00
USB-C Cable        | 102         | 15.99
Ergonomic Keyboard | 101         | 79.99
Monitor 27"        | 104         | 349.99
Webcam HD          | 104         | 89.99
Bookshelf          | 103         | 199.00

Explanation:
- Subquery finds suppliers with 2+ products
- Main query returns products from those suppliers
- Returns 9 products

Use Case: Multi-level filtering, related data
*/

/*
5.2 Subquery with Comparison
━━━━━━━━━━━━━━━━━━━━━━━━━━

Compare against subquery result
*/

-- Example 38: Products above average price
SELECT
    product_name,
    price,
    category
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);
/*
Result:
product_name  | price  | category
--------------|--------|------------
Laptop Pro 15 | 999.99 | Electronics
Office Chair  | 299.00 | Furniture
Standing Desk | 599.00 | Furniture
Monitor 27"   | 349.99 | Electronics

Explanation:
- Subquery calculates average price (≈ 260)
- Main query returns products above average
- Returns 4 products

Use Case: Above-average analysis, outlier detection
*/

-- Example 39: EXISTS with correlated subquery
SELECT
    p.product_name,
    p.category,
    p.price
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Products p2
    WHERE p2.category = p.category
      AND p2.price < p.price
);
/*
Result: Products that have cheaper alternatives in same category

Explanation:
- Correlated subquery checks for cheaper products in same category
- EXISTS returns TRUE if subquery has results
- Returns products that aren't the cheapest in their category

Use Case: Comparative filtering, relative conditions
*/

/*
=================================================================
SECTION 6: WHERE IN UPDATE AND DELETE
=================================================================

6.1 WHERE in UPDATE
━━━━━━━━━━━━━━━━━━

Filter which rows to update
*/

-- Example 40: Update specific rows
UPDATE Products
SET price = price * 0.9  -- 10% discount
WHERE category = 'Electronics'
  AND stock > 50;
/*
Before:
Wireless Mouse: $25.50, stock 150
Ergonomic Keyboard: $79.99, stock 75

After:
Wireless Mouse: $22.95, stock 150
Ergonomic Keyboard: $71.99, stock 75

Explanation:
- WHERE filters rows to update
- Only affects Electronics with stock > 50
- Other rows unchanged

Use Case: Targeted updates, promotional pricing
*/

-- Example 41: Update with subquery
UPDATE Products
SET is_active = 0
WHERE stock = 0
  AND created_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
/*
Deactivates old out-of-stock products

Use Case: Data cleanup, status management
*/

/*
6.2 WHERE in DELETE
━━━━━━━━━━━━━━━━━━

Filter which rows to delete
*/

-- Example 42: Delete specific rows
-- ⚠️ DANGEROUS: Always test WHERE with SELECT first!

-- Test first:
SELECT product_name, stock, is_active
FROM Products
WHERE is_active = 0 AND stock = 0;

-- If correct, then delete:
DELETE FROM Products
WHERE is_active = 0 AND stock = 0;
/*
Explanation:
- WHERE filters rows to delete
- Only removes inactive, out-of-stock products
- ALWAYS test with SELECT first!

Use Case: Data purging, cleanup operations
*/

/*
=================================================================
SECTION 7: PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ❌ SLOW: Functions on indexed columns
SELECT * FROM Products
WHERE YEAR(created_date) = 2024;

-- ✓ FAST: Use range instead
SELECT * FROM Products
WHERE created_date >= '2024-01-01'
  AND created_date < '2025-01-01';

-- ❌ SLOW: LIKE with leading wildcard
SELECT * FROM Products
WHERE product_name LIKE '%Desk%';  -- Full table scan

-- ✓ FASTER: LIKE without leading wildcard
SELECT * FROM Products
WHERE product_name LIKE 'Desk%';  -- Can use index

-- ❌ SLOW: OR with different columns
SELECT * FROM Products
WHERE price > 500 OR stock < 10;  -- Can't use both indexes

-- ✓ BETTER: Consider UNION if needed
SELECT * FROM Products WHERE price > 500
UNION
SELECT * FROM Products WHERE stock < 10;

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 43: E-commerce product search
SELECT
    product_name,
    category,
    price,
    stock,
    rating
FROM Products
WHERE category IN ('Electronics', 'Furniture')
  AND price BETWEEN 50 AND 500
  AND stock > 0
  AND rating >= 4.0
  AND is_active = 1
ORDER BY rating DESC, price ASC;
/*
Multi-criteria product search:
- Multiple categories
- Price range
- In stock only
- Good ratings only
- Active products only
- Sorted by best rating, then lowest price

Use Case: E-commerce filtering, product search
*/

-- Example 44: Order fulfillment report
SELECT
    id,
    customer_id,
    order_date,
    total_amount,
    status
FROM Orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
  AND status IN ('Processing', 'Shipped')
  AND total_amount > 100
ORDER BY order_date DESC;
/*
Recent orders needing attention:
- Last 7 days
- Active status (not delivered/cancelled)
- Above minimum amount

Use Case: Operations dashboard, order management
*/

-- Example 45: Inventory restock alert
SELECT
    product_name,
    category,
    stock,
    price,
    (price * stock) AS current_value,
    supplier_id
FROM Products
WHERE (stock < 20 OR stock = 0)
  AND is_active = 1
  AND category != 'Discontinued'
ORDER BY
    CASE WHEN stock = 0 THEN 0 ELSE 1 END,  -- Out of stock first
    stock ASC;
/*
Products needing reorder:
- Low or zero stock
- Active products only
- Exclude discontinued
- Prioritize out-of-stock

Use Case: Inventory management, purchase orders
*/

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: Using = NULL
SELECT * FROM Products WHERE discount = NULL;
-- Returns nothing! NULL can't be compared with =

-- ✓ CORRECT:
SELECT * FROM Products WHERE discount IS NULL;

-- ❌ MISTAKE 2: Missing parentheses with AND/OR
SELECT * FROM Products
WHERE category = 'Electronics' AND price < 100 OR stock < 20;
-- Reads as: (Electronics AND cheap) OR (low stock)
-- May not be what you want!

-- ✓ CORRECT:
SELECT * FROM Products
WHERE category = 'Electronics' AND (price < 100 OR stock < 20);

-- ❌ MISTAKE 3: String/number confusion
SELECT * FROM Products WHERE price = '100';
-- Works but implicit conversion (may affect performance)

-- ✓ BETTER:
SELECT * FROM Products WHERE price = 100;

-- ❌ MISTAKE 4: BETWEEN with dates (time component)
SELECT * FROM Products
WHERE created_date BETWEEN '2024-01-01' AND '2024-01-31';
-- May miss items on 2024-01-31 if they have times

-- ✓ BETTER:
SELECT * FROM Products
WHERE created_date >= '2024-01-01'
  AND created_date < '2024-02-01';

-- ❌ MISTAKE 5: LIKE without wildcards
SELECT * FROM Products WHERE product_name LIKE 'Laptop';
-- Only exact match, same as = but slower

-- ✓ USE = for exact:
SELECT * FROM Products WHERE product_name = 'Laptop Pro 15';

/*
=================================================================
HINGLISH SUMMARY
=================================================================

WHERE clause SQL ka sabse important part hai - yeh rows ko filter karta hai.

Basic operators:
- = : Exact match (category = 'Electronics')
- != ya <> : Not equal (category != 'Furniture')
- >, <, >=, <= : Comparisons (price > 100, stock <= 20)

Logical operators:
- AND : Saari conditions TRUE honi chahiye
  WHERE category = 'Electronics' AND price < 100

- OR : Koi ek condition TRUE ho
  WHERE category = 'Electronics' OR category = 'Furniture'

- NOT : Condition ko reverse karo
  WHERE NOT (price > 500)

Special operators:
- IN : List mein se koi bhi match ho
  WHERE status IN ('Delivered', 'Shipped')

- BETWEEN : Range mein ho (inclusive)
  WHERE price BETWEEN 50 AND 300

- LIKE : Pattern matching
  '%Desk%' = anywhere, 'Desk%' = starts with, '%Desk' = ends with

- IS NULL / IS NOT NULL : NULL values check
  WHERE discount IS NULL (NOT: = NULL)

Functions in WHERE:
- String: LOWER(), UPPER(), LENGTH()
- Date: YEAR(), MONTH(), DATE()
- Numeric: ROUND(), ABS()
⚠️ Functions prevent index usage (slow!)

Subqueries:
- IN: WHERE id IN (SELECT...)
- Comparison: WHERE price > (SELECT AVG(price)...)
- EXISTS: WHERE EXISTS (SELECT...)

Real-world patterns:
- Product search: Multiple filters combined
  WHERE category = 'X' AND price BETWEEN a AND b AND stock > 0

- Date ranges: Use >= and
  WHERE date >= '2024-01-01' AND date < '2024-02-01'

- Search: Case-insensitive LIKE
  WHERE LOWER(name) LIKE LOWER('%search%')

Performance tips:
✓ Indexed columns bina functions ke use karo
✓ Date ranges: >= aur < use karo (YEAR() nahi)
✓ LIKE: Leading wildcard avoid karo jahan possible
✓ Specific conditions pehle rakho (AND mein)
❌ Functions on indexed columns (slow!)
❌ Leading wildcards in LIKE (can't use index)

Common mistakes:
❌ = NULL use karna (IS NULL chahiye)
❌ Parentheses missing with AND/OR
❌ BETWEEN with datetime (time component miss ho sakta hai)
❌ Functions on indexed columns (performance issue)
❌ Wrong precedence (NOT > AND > OR)

Best practices:
✓ Hamesha WHERE use karo (bina WHERE sab rows affect hongi)
✓ Test with SELECT before UPDATE/DELETE
✓ Parentheses use karo clarity ke liye
✓ NULL properly handle karo (IS NULL)
✓ Performance ke liye indexes ka dhyan rakho
✓ Complex conditions ko break karo multiple steps mein

Remember:
- WHERE filters rows BEFORE processing
- Every condition evaluated to TRUE/FALSE/NULL
- NULL in any comparison → result is NULL (not TRUE/FALSE)
- Operator precedence: NOT > AND > OR
- Performance matters - avoid functions on indexed columns
- Always test WHERE logic with SELECT first
- Parentheses improve readability and prevent errors

KEY TAKEAWAYS:
✓ WHERE filters rows based on conditions
✓ Use comparison operators (=, >, <, >=, <=, !=)
✓ Combine with AND (all true) or OR (any true)
✓ Special operators: IN, BETWEEN, LIKE, IS NULL
✓ Parentheses control evaluation order
✓ NULL requires IS NULL (not = NULL)
✓ Functions on columns hurt performance
✓ Test WHERE logic with SELECT before UPDATE/DELETE
✓ Use appropriate operators for data types
✓ Consider index usage for performance
✓ Subqueries provide powerful filtering
✓ Always be specific to avoid unintended results

=================================================================
*/

-- Comprehensive example combining multiple WHERE techniques:
SELECT
    p.product_name,
    p.category,
    p.price,
    p.stock,
    p.rating,
    p.created_date
FROM Products p
WHERE
    -- Category filter
    p.category IN ('Electronics', 'Furniture')

    -- Price range
    AND p.price BETWEEN 25 AND 600

    -- Availability
    AND p.stock > 0

    -- Quality threshold
    AND p.rating >= 4.0

    -- Active products only
    AND p.is_active = 1

    -- Recent products (last 6 months)
    AND p.created_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)

    -- Name pattern (optional search)
    AND (
        p.product_name LIKE '%Pro%'
        OR p.product_name LIKE '%Desk%'
        OR 1=1  -- Allow all if no specific search
    )

    -- Exclude certain suppliers
    AND p.supplier_id NOT IN (999)

    -- Above average price in category (subquery)
    AND p.price > (
        SELECT AVG(price)
        FROM Products
        WHERE category = p.category
    )

ORDER BY
    p.rating DESC,
    p.price ASC
LIMIT 10;
