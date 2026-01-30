/*
=================================================================
QUERY PURPOSE: Find all unmatched records from both tables (Full Anti Join)
=================================================================

CONCEPT EXPLANATION (English):
A FULL ANTI JOIN (also called FULL OUTER EXCLUDING JOIN) returns only
the rows that DON'T have matches in the other table. This is achieved
by performing a FULL JOIN and then filtering out all matched records
using WHERE clause with IS NULL conditions on both sides.

Think of it as finding "orphaned" records - orders without customers
AND customers without orders.

CONCEPT EXPLANATION (Hinglish):
FULL ANTI JOIN (ya FULL OUTER EXCLUDING JOIN) sirf woh rows return
karti hai jo dusri table mein match NAHI hoti. Yeh FULL JOIN karke
aur phir WHERE clause se matched records ko filter karke achieve hota hai,
dono sides pe IS NULL condition use karke.

Isse samjho jaise "orphaned" records dhoondhna - aise orders jo customers
ke bina hain AUR aise customers jinke koi orders nahi hain.

USE CASES:
- Data quality checks: Finding orphaned records in both tables
- Database cleanup: Identifying records to delete or fix
- ETL validation: Detecting missing relationships after data migration
- Audit purposes: Finding customers who never ordered AND orders without valid customers
- Referential integrity checks: Spotting broken foreign key relationships

SPECIFIC QUERY BREAKDOWN:

Line 1: SELECT *
  → Selects all columns from both tables (orders and customers)

Line 2-3: FROM orders AS o FULL JOIN customers AS c
  → Performs FULL OUTER JOIN between orders and customers
  → FULL JOIN returns ALL rows from BOTH tables
  → Matched rows show data from both sides
  → Unmatched rows show NULL for missing side

Line 4: ON c.id = o.customer_id
  → Join condition: Links customer ID to order's customer_id
  → This determines what constitutes a "match"

Line 5: WHERE c.id IS NULL OR o.customer_id IS NULL
  → CRITICAL FILTER: This is what makes it an "anti" join
  → c.id IS NULL: Finds orders WITHOUT matching customers (orphaned orders)
  → o.customer_id IS NULL: Finds customers WITHOUT any orders (never purchased)
  → OR: Includes rows matching EITHER condition

HOW IT WORKS VISUALLY:
Table A (Orders)    FULL JOIN    Table B (Customers)
     ╭─────╮                        ╭─────╮
     │  A  │                        │  B  │
     │ only│                        │ only│
     ╰─────╯                        ╰─────╯
         ╲              ╱
          ╲  ╭─────╮  ╱
           ╲ │ Both│ ╱
            ╲╰─────╯╱

FULL ANTI JOIN returns only A only + B only (excludes "Both")

EXAMPLES:

Example 1: Find products never ordered AND orders for deleted products
*/
SELECT *
FROM products AS p
FULL JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE p.product_id IS NULL OR oi.product_id IS NULL;
/*
Returns:
- Products that exist but were never ordered
- Order items referencing products that no longer exist
*/

-- Example 2: Find employees without departments AND departments without employees
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_id,
    d.dept_name,
    CASE
        WHEN e.emp_id IS NULL THEN 'Empty Department'
        WHEN d.dept_id IS NULL THEN 'Employee without Department'
    END AS issue_type
FROM employees AS e
FULL JOIN departments AS d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL OR d.dept_id IS NULL;

-- Example 3: Find students not enrolled in any course AND courses with no students
SELECT
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_name
FROM students AS s
FULL JOIN enrollments AS e ON s.student_id = e.student_id
FULL JOIN courses AS c ON e.course_id = c.course_id
WHERE s.student_id IS NULL OR c.course_id IS NULL;

/*
SAMPLE DATA ILLUSTRATION:

Orders Table:
order_id | customer_id | amount
---------|-------------|--------
1        | 101         | 500
2        | 102         | 750
3        | 999         | 300    ← Customer 999 doesn't exist
4        | 103         | 200

Customers Table:
id  | name     | email
----|----------|------------------
101 | Alice    | alice@email.com
102 | Bob      | bob@email.com
103 | Charlie  | charlie@email.com
104 | Diana    | diana@email.com  ← Diana never ordered

QUERY RESULT:
order_id | customer_id | amount | id   | name  | email
---------|-------------|--------|------|-------|------------------
3        | 999         | 300    | NULL | NULL  | NULL             ← Orphaned order
NULL     | NULL        | NULL   | 104  | Diana | diana@email.com  ← Customer without orders

PERFORMANCE NOTES:
- FULL JOIN can be expensive on large tables (requires scanning both tables completely)
- Consider adding indexes on join columns (c.id and o.customer_id)
- For very large tables, consider breaking into two separate queries:
  * LEFT JOIN with WHERE right IS NULL (find orphaned orders)
  * RIGHT JOIN with WHERE left IS NULL (find customers without orders)
  * Then UNION the results
- Some databases (like MySQL before 8.0) don't support FULL JOIN natively
  * Use: (LEFT JOIN + WHERE right IS NULL) UNION (RIGHT JOIN + WHERE left IS NULL)

COMMON MISTAKES TO AVOID:

1. Using AND instead of OR in WHERE clause:
   WHERE c.id IS NULL AND o.customer_id IS NULL
   ✗ This returns NOTHING (a row can't have both sides NULL in FULL JOIN)

2. Forgetting to check both sides for NULL:
   WHERE c.id IS NULL
   ✗ This only finds orphaned orders, not customers without orders

3. Confusing with INNER JOIN:
   INNER JOIN only shows matched records (opposite of what we want)

4. Not handling NULL values in other columns:
   Be aware that unmatched rows will have NULL for all columns from the missing side

5. Performance issues on large tables without proper indexing

ALTERNATIVE SYNTAX (For databases without FULL JOIN support):

-- Method 1: Using UNION
SELECT * FROM orders o LEFT JOIN customers c ON c.id = o.customer_id WHERE c.id IS NULL
UNION
SELECT * FROM orders o RIGHT JOIN customers c ON c.id = o.customer_id WHERE o.customer_id IS NULL;

-- Method 2: Using NOT EXISTS (often faster)
SELECT * FROM orders WHERE customer_id NOT IN (SELECT id FROM customers WHERE id IS NOT NULL)
UNION
SELECT * FROM customers WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL);

REAL-WORLD SCENARIO:
Imagine aap ek e-commerce company mein data analyst ho:
- Aapko pata karna hai ki kaunse orders aise hain jinke customers delete ho gaye
  (data cleanup ke baad), taaki aap un orders ko archive ya fix kar sako
- Saath hi, kaunse customers ne kabhi order nahi kiya (marketing campaign ke liye)
- Dono problems ko ek hi query se solve kar sakte ho using FULL ANTI JOIN!

=================================================================
*/

SELECT *
FROM orders AS o
FULL JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;