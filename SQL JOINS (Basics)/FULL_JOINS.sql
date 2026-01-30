-- =====================================================
-- FULL JOIN EXPLANATION - Complete Breakdown (Master Join!)
-- =====================================================

-- ENGLISH EXPLANATION FOR FULL JOIN

-- FULL JOIN = LEFT JOIN + RIGHT JOIN combined!
-- Returns ALL customers AND ALL orders, with NULLs where no match exists.

SELECT
    c.id,           -- customer id (NULL if orphan order)
    c.first_name,   -- customer name (NULL if orphan order)
    o.order_id,     -- order id (NULL if customer has no orders)
    o.sales         -- sales amount (NULL if customer has no orders)
FROM customers AS c
FULL JOIN orders AS o
    ON c.id = o.customer_id;

-- Result: EVERYTHING from both tables!
-- ✅ Customers with orders → full data
-- ✅ Customers without orders → customer data + NULL orders
-- ✅ Orders without customers → order data + NULL customer data

-- Sample Output:
-- id | first_name | order_id | sales
-- 1  | Rahul      | 101      | 2500    ← matching
-- 2  | Priya      | 103      | 3200    ← matching
-- 3  | Amit       | NULL     | NULL    ← customer, no order
-- NULL| NULL      | 999      | 500     ← orphan order!

-- Use when: "Show complete picture - everything from both tables"


-- HINGLISH EXPLANATION FOR FULL JOIN

-- FULL JOIN = SABKUCH! (LEFT + RIGHT JOIN ka combination)
-- SAARI customers + SAARI orders, jahan match na ho wahan NULL.

SELECT
    c.id,           -- customer id (orphan order mein NULL)
    c.first_name,   -- naam (orphan order mein NULL)
    o.order_id,     -- order number (no order mein NULL)
    o.sales         -- sales (no order mein NULL)
FROM customers AS c
FULL JOIN orders AS o
    ON c.id = o.customer_id;

-- 3 scenarios cover hote hain:
-- 1. Customer + Order match → full data
-- 2. Customer hai, order nahi → customer + NULLs
-- 3. Order hai, customer nahi → NULLs + order data

-- Sample Output (Hinglish samjhaav):
-- id | naam     | order_id | sales
-- 1  | Rahul    | 101      | 2500    ← perfect match
-- 2  | Priya    | 103      | 3200    ← perfect match
-- 3  | Amit     | NULL     | NULL    ← customer bina order
-- NULL| NULL    | 999      | 500     ← order bina customer! 🔥

-- Kab use karo:
-- "Poora data reconciliation chahiye - kuch bhi miss nahi hona chahiye"

-- ⚠️ Note: MySQL FULL JOIN support nahi karta, UNION use karna padta hai
