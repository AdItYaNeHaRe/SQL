-- INNER JOIN EXPLANATION (ENGLISH)

-- This query returns only those rows where a customer actually has one or more orders. [web:88]
-- It combines data from customers and orders based on the matching key: customers.id = orders.customer_id. [web:87][web:92]

SELECT *
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;
-- Meaning:
-- FROM customers
--   Start with the customers table.
-- INNER JOIN orders
--   Join the orders table to customers.
-- ON customers.id = orders.customer_id
--   Keep only rows where customer id matches order's customer_id (common key).
-- Result:
--   Each row shows one customer joined with one of their orders.
--   Customers without orders and orders without a matching customer are excluded. [web:88][web:91]


-- INNER JOIN EXPLANATION (HINGLISH)

-- Ye query sirf un customers ko dikhati hai jinke paas kam se kam ek order hai. [web:88]
-- customers aur orders dono tables ko join karti hai jahan customers.id = orders.customer_id match karta hai. [web:87][web:92]

SELECT *
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;
-- FROM customers
--   Pehle customers table se start karte hain.
-- INNER JOIN orders
--   orders table ko customers ke saath join karte hain.
-- ON customers.id = orders.customer_id
--   Sirf wahi rows rakhte hain jahan customer ka id,
--   orders table ke customer_id se match kare.
-- Result:
--   Har row mein customer + uska ek order dikhai dega.
--   Jinke orders nahi hain, wo customers result mein nahi aayenge,
--   aur jin orders ka customer match nahi hota, wo bhi skip ho jayenge. [web:88][web:91]


-- =====================================================
-- INNER JOIN WITH SPECIFIC COLUMNS - Explanation
-- =====================================================

-- ENGLISH EXPLANATION

-- This query returns specific columns from both tables for customers who have placed orders.
-- Only matching customer-order pairs are included in the result.

SELECT
    customers.id,
    customers.first_name,
    orders.order_id,
    orders.sales
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

-- What happens:
-- 1. customers table se id aur first_name select karta hai
-- 2. orders table se order_id aur sales select karta hai
-- 3. INNER JOIN → sirf matching records (customers.id = orders.customer_id)
-- 4. Result → each row: customer ka naam + uska ek order ka details [web:87][web:88]

-- Sample Output:
-- id | first_name | order_id | sales
-- 1  | Rahul      | 101      | 2500
-- 1  | Rahul      | 102      | 1800    ← same customer, different orders
-- 2  | Priya      | 103      | 3200


-- HINGLISH EXPLANATION

-- Ye query specific columns dikhati hai sirf un customers ke liye jinke orders hain.
-- Har matching customer-order pair ek row banata hai.

SELECT
    customers.id,
    customers.first_name,        -- customer ka naam
    orders.order_id,             -- order number
    orders.sales                 -- kitna sale hua
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

-- Step by step (Hinglish):
-- 1. customers table → id, first_name lo
-- 2. orders table → order_id, sales lo
-- 3. INNER JOIN ON → customers.id == orders.customer_id jahan match kare
-- 4. Result → ek customer ke multiple orders alag-alag rows mein

-- Sample data samjhaav:
-- Agar Rahul ka 2 orders hain (101:2500, 102:1800)
-- Rahul 2 baar dikhega, har order ke saath.

-- Key Points:
-- ✅ Same customer multiple times (multiple orders)
-- ❌ No orders = no row for that customer
-- ✅ Fast and simple for matching data
-- ✅ Column names prefix karo (customers.id) ambiguity avoid karne ke liye [web:88][web:92]


-- =====================================================
-- INNER JOIN WITH TABLE ALIASES - Explanation (Advanced)
-- =====================================================

-- ENGLISH EXPLANATION

-- This version uses table aliases (c, o) for cleaner, shorter syntax.
-- Functionally identical to the previous query but more readable and efficient.

SELECT
    c.id,                    -- customers.id (using alias c)
    c.first_name,            -- customers.first_name
    o.order_id,              -- orders.order_id (using alias o)
    o.sales                  -- orders.sales
FROM customers AS c          -- customers table aliased as 'c'
INNER JOIN orders AS o       -- orders table aliased as 'o'
    ON c.id = o.customer_id; -- join condition using aliases

-- Benefits of aliases:
-- ✅ Shorter column names (c.id vs customers.id)
-- ✅ Less typing, cleaner code
-- ✅ Less chance of typos
-- ✅ Standard practice in production SQL [web:87][web:88]

-- Result: Same as before - customer details + their orders only.


-- HINGLISH EXPLANATION

-- Ye same query hai lekin TABLE ALIASES (c, o) use kiye hain - zyada clean aur fast.

SELECT
    c.id,                    -- customers.id (shortcut 'c')
    c.first_name,            -- customer ka naam (c table se)
    o.order_id,              -- order number (o table se)
    o.sales                  -- kitna sale hua (o table se)
FROM customers AS c          -- customers table ko 'c' naam diya
INNER JOIN orders AS o       -- orders table ko 'o' naam diya
    ON c.id = o.customer_id; -- join condition mein short names use kiye

-- Aliases ke fayde (Hinglish):
-- ✅ Kam typing: c.id < customers.id
-- ✅ Padhne mein asaan
-- ✅ Galti kam chance
-- ✅ Professional SQL mein standard practice [web:87][web:88]

-- Output bilkul same:
-- id | first_name | order_id | sales
-- 1  | Rahul      | 101      | 2500
-- 1  | Rahul      | 102      | 1800
-- 2  | Priya      | 103      | 3200

-- Pro Tips:
-- 1. AS optional hai: FROM customers c (AS skip kar sakte ho)
-- 2. Short meaningful aliases: c= customers, o=orders, p=products
-- 3. Multiple tables mein hamesha aliases use karo!

-- 1. With AS (clear)
FROM customers AS c

-- 2. Without AS (common)
FROM customers c

-- 3. Multiple tables
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN products p ON o.product_id = p.id
