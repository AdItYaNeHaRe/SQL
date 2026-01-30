/*
=================================================================
QUERY PURPOSE: Create a Cartesian product of all customers with all orders
=================================================================

CONCEPT EXPLANATION (English):
A CROSS JOIN returns the Cartesian product of two tables, meaning it
combines EVERY row from the first table with EVERY row from the second
table. If table A has 5 rows and table B has 10 rows, the result will
have 5 × 10 = 50 rows.

Unlike other joins, CROSS JOIN does NOT require any join condition (ON clause).
It simply pairs every possible combination of rows from both tables.

CONCEPT EXPLANATION (Hinglish):
CROSS JOIN do tables ka Cartesian product return karta hai, matlab yeh
pehli table ki HAR row ko dusri table ki HAR row ke saath combine karta hai.
Agar table A mein 5 rows hain aur table B mein 10 rows hain, toh result
mein 5 × 10 = 50 rows hongi.

Dusre joins ke unlike, CROSS JOIN ko kisi join condition (ON clause) ki
zarurat NAHI hoti. Yeh simply dono tables ki rows ke har possible combination
ko pair kar deta hai.

USE CASES:
- Generating all possible combinations (e.g., product variants with sizes and colors)
- Creating test data or sample datasets
- Building comparison matrices (comparing every item with every other item)
- Scheduling: Pairing employees with all possible shifts
- Price calculation: Combining all products with all discount rates
- Report generation: Creating templates with all date ranges for all departments
- Game development: Generating all possible card combinations
- Menu combinations: All appetizers with all main courses

SPECIFIC QUERY BREAKDOWN:

Line 1: SELECT * FROM customers
  → Starts with the customers table as the first table
  → Will select all columns from customers

Line 2: CROSS JOIN orders;
  → Performs CROSS JOIN with orders table
  → NO ON clause needed (this is the key characteristic)
  → Every customer row will be paired with EVERY order row
  → Result = (number of customers) × (number of orders) rows

HOW IT WORKS:

If customers table has 3 rows:
Customer_ID | Name
------------|--------
1           | Alice
2           | Bob
3           | Charlie

And orders table has 2 rows:
Order_ID | Amount
---------|--------
101      | 500
102      | 750

Result will have 3 × 2 = 6 rows:
Customer_ID | Name    | Order_ID | Amount
------------|---------|----------|--------
1           | Alice   | 101      | 500
1           | Alice   | 102      | 750
2           | Bob     | 101      | 500
2           | Bob     | 102      | 750
3           | Charlie | 101      | 500
3           | Charlie | 102      | 750

Notice: Every customer appears with EVERY order (no relationship needed!)

EXAMPLES:

Example 1: Generate all possible product-color-size combinations
*/
SELECT
    p.product_name,
    c.color_name,
    s.size_name,
    p.base_price,
    (p.base_price + c.color_premium + s.size_premium) AS final_price
FROM products AS p
CROSS JOIN colors AS c
CROSS JOIN sizes AS s;
/*
Result: If 10 products, 5 colors, 4 sizes → 10 × 5 × 4 = 200 combinations
Use Case: E-commerce inventory setup, generating SKUs for all variants
*/

-- Example 2: Create a work schedule (all employees × all shifts)
SELECT
    e.employee_id,
    e.employee_name,
    s.shift_name,
    s.shift_time,
    s.shift_date
FROM employees AS e
CROSS JOIN shifts AS s
ORDER BY e.employee_id, s.shift_date;
/*
Use Case: Creating a template schedule that needs to be filtered/assigned later
*/

-- Example 3: Generate a sales target report (all products × all months)
SELECT
    p.product_id,
    p.product_name,
    m.month_name,
    m.year,
    p.target_units,
    CONCAT(m.month_name, ' ', m.year) AS period
FROM products AS p
CROSS JOIN months AS m
WHERE m.year = 2024
ORDER BY p.product_id, m.month_num;
/*
Use Case: Creating a template for monthly sales tracking
*/

-- Example 4: Compare every student with every subject (enrollment possibilities)
SELECT
    s.student_id,
    s.student_name,
    s.grade_level,
    sub.subject_id,
    sub.subject_name,
    sub.credits
FROM students AS s
CROSS JOIN subjects AS sub
WHERE sub.grade_level = s.grade_level;  -- Filter to show only relevant combinations
/*
Note: Added WHERE clause to filter the Cartesian product to meaningful results
*/

-- Example 5: Create a comparison matrix for all products
SELECT
    p1.product_name AS product_A,
    p2.product_name AS product_B,
    p1.price AS price_A,
    p2.price AS price_B,
    ABS(p1.price - p2.price) AS price_difference
FROM products AS p1
CROSS JOIN products AS p2
WHERE p1.product_id < p2.product_id;  -- Avoid duplicate comparisons
/*
Use Case: Price comparison analysis, competitive analysis
*/

-- Example 6: Generate date ranges for all departments
SELECT
    d.department_name,
    dr.date_value,
    dr.week_number,
    dr.month_name
FROM departments AS d
CROSS JOIN date_range AS dr
WHERE dr.date_value BETWEEN '2024-01-01' AND '2024-12-31';
/*
Use Case: Creating reporting templates with all dates for all departments
*/

/*
REAL-WORLD PRACTICAL EXAMPLE:

Scenario: Online T-shirt store needs to generate all product variants

Tables:
tshirts:
design_id | design_name
----------|-------------
1         | Logo
2         | Plain
3         | Striped

colors:
color_id | color_name | price_add
---------|------------|----------
1        | Red        | 0
2        | Blue       | 0
3        | Black      | 2

sizes:
size_id | size_name | price_add
--------|-----------|----------
1       | S         | 0
2       | M         | 0
3       | L         | 2
4       | XL        | 3
*/

SELECT
    t.design_name,
    c.color_name,
    s.size_name,
    CONCAT(t.design_name, '-', c.color_name, '-', s.size_name) AS sku,
    (20 + c.price_add + s.price_add) AS price
FROM tshirts AS t
CROSS JOIN colors AS c
CROSS JOIN sizes AS s
ORDER BY t.design_id, c.color_id, s.size_id;

/*
Result: 3 designs × 3 colors × 4 sizes = 36 unique product variants!

Sample Output:
design_name | color_name | size_name | sku              | price
------------|------------|-----------|------------------|-------
Logo        | Red        | S         | Logo-Red-S       | 20
Logo        | Red        | M         | Logo-Red-M       | 20
Logo        | Red        | L         | Logo-Red-L       | 22
Logo        | Red        | XL        | Logo-Red-XL      | 23
Logo        | Blue       | S         | Logo-Blue-S      | 20
... (36 total rows)

ALTERNATIVE SYNTAX:

Method 1: Implicit CROSS JOIN (older syntax, comma-separated)
*/
SELECT *
FROM customers, orders;
/*
This is equivalent to CROSS JOIN but less explicit
Modern SQL prefers explicit CROSS JOIN for clarity
*/

-- Method 2: CROSS JOIN with explicit column selection
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
FROM customers AS c
CROSS JOIN orders AS o;

-- Method 3: Using WHERE to filter Cartesian product (common pattern)
SELECT *
FROM customers AS c
CROSS JOIN orders AS o
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
AND c.country = 'USA';

/*
PERFORMANCE NOTES:

⚠️ WARNING: CROSS JOIN can create MASSIVE result sets!

- If customers has 1,000 rows and orders has 10,000 rows
  → Result will have 1,000 × 10,000 = 10,000,000 rows!

- This can:
  * Consume huge amounts of memory
  * Take very long to execute
  * Crash your application or database
  * Fill up disk space with temp files

PERFORMANCE TIPS:
1. Always consider if you really need CROSS JOIN
2. Use WHERE clause to filter results early
3. Limit the result set for testing: ADD LIMIT 100 at the end
4. Use it on small reference tables (colors, sizes, etc.)
5. Avoid on large transactional tables
6. Consider using it in subqueries with filters rather than in main query
7. Test with COUNT(*) first to see how many rows will be generated:

*/
SELECT
    COUNT(*) AS total_combinations,
    (SELECT COUNT(*) FROM customers) AS customer_count,
    (SELECT COUNT(*) FROM orders) AS order_count
FROM customers
CROSS JOIN orders;
/*
This helps you understand the result size before actually fetching all data

COMMON MISTAKES TO AVOID:

1. Using CROSS JOIN when you meant INNER JOIN:
   ✗ CROSS JOIN doesn't filter based on relationships
   ✓ Use INNER JOIN with ON clause for related data

2. Forgetting to add WHERE clause to filter:
   Without filtering, you get ALL combinations (usually not what you want)

3. Using CROSS JOIN on large tables without LIMIT:
   Can bring down your database or application

4. Not understanding the exponential growth:
   3 tables with 100 rows each = 100 × 100 × 100 = 1,000,000 rows!

5. Mixing up comma syntax with proper join syntax:
   FROM t1, t2 WHERE t1.id = t2.id  ← This is actually INNER JOIN, not CROSS JOIN

6. Expecting meaningful relationships in results:
   CROSS JOIN doesn't care about foreign keys or logical relationships

WHEN TO USE vs WHEN NOT TO USE:

✓ USE CROSS JOIN WHEN:
- Generating all possible combinations of attributes
- Creating templates or scaffolding data
- Working with small reference tables
- Building comparison matrices
- You genuinely need every possible pairing

✗ DON'T USE CROSS JOIN WHEN:
- Tables have a foreign key relationship (use INNER/LEFT/RIGHT JOIN instead)
- You only want matching records
- Working with large tables without proper filtering
- You're not sure what join to use (probably not CROSS JOIN!)

HINGLISH SUMMARY:
CROSS JOIN tab use karo jab aapko har possible combination chahiye ho,
jaise products ke saath har color aur har size. Lekin dhyaan rakho -
yeh bohot saare rows generate kar sakta hai! Agar 100 customers aur
1000 orders hain, toh 100,000 rows mil jaayenge. Hamesha WHERE clause
use karke results ko filter karo, aur pehle COUNT(*) se check karo
kitni rows generate hongi. Large tables pe yeh dangerous ho sakta hai!

QUIZ YOURSELF:
Q: If table A has 50 rows and table B has 200 rows, how many rows in CROSS JOIN?
A: 50 × 200 = 10,000 rows

Q: When would you use CROSS JOIN instead of INNER JOIN?
A: When you need all combinations, not just matching relationships

Q: How to make CROSS JOIN safer on large tables?
A: Add WHERE clause filters and use LIMIT for testing

=================================================================
*/

-- Cross Joins

SELECT * FROM customers
CROSS JOIN orders;
