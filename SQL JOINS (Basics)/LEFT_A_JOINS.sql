-- =====================================================
-- LEFT JOIN + IS NULL = "CUSTOMERS WITHOUT ORDERS" PATTERN
-- =====================================================
-- 🔥 MASTER INTERVIEW QUESTION PATTERN! 🔥

-- ENGLISH EXPLANATION

-- This is the GOLDEN PATTERN to find "records without matches":
-- 1. LEFT JOIN → ALL customers + matching orders (NULL if no match)
-- 2. WHERE o.customer_id IS NULL → filter ONLY customers with no orders

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

-- Step-by-step breakdown:
-- LEFT JOIN → ALL customers (with orders OR NULL orders)
-- WHERE IS NULL → "NULL orders" wale customers ko filter karo
-- Result → ONLY customers jo kabhi order nahi kar paye!

-- Sample Output:
-- id | first_name | order_id | customer_id | sales
-- 3  | Amit       | NULL     | NULL        | NULL    ← NO orders!
-- 5  | Riya       | NULL     | NULL        | NULL    ← NO orders!

-- Real-world use: "Inactive customers", "Unsold products", "Unassigned employees"


-- HINGLISH EXPLANATION (Interview trick!)

-- Ye query famous INTERVIEW QUESTION solve karti hai:
-- "Kaun se customers ne kabhi order nahi kiya?"

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id  -- matching try karo
WHERE o.customer_id IS NULL;  -- sirf NO match wale chahiye

-- Logic samjhaav:
-- 1. LEFT JOIN → SAARI customers + unke orders (NULL if no order)
-- 2. o.customer_id IS NULL → sirf wo customers jinke orders NULL hain
-- 3. Result → "Inactive customers" list!

-- Sample data:
-- Rahul(id=1) → orders hain → WHERE mein filter out
-- Amit(id=3)  → orders NAHI → IS NULL → RESULT mein aayega

-- 💎 PRO PATTERNS (yaad rakho):

-- 1. Products without sales:
```sql
SELECT * FROM products p
LEFT JOIN sales s ON p.id = s.product_id
WHERE s.product_id IS NULL;

**Universal Anti-Pattern (galti mat karna):**
```sql
-- ❌ WRONG (NOT IN - NULL trap!)
SELECT * FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);

-- ✅ CORRECT (LEFT JOIN pattern)
SELECT * FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.customer_id IS NULL;
