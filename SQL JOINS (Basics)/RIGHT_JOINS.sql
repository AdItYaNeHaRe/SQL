-- =====================================================
-- RIGHT JOIN EXPLANATION - Complete Breakdown
-- =====================================================

-- ENGLISH EXPLANATION FOR RIGHT JOIN

-- RIGHT JOIN returns ALL orders (o table) + matching customers if they exist.
-- Orders WITHOUT matching customers show customer columns as NULL.

SELECT
    o.customer_id,       -- from orders table
    o.sales,             -- from orders table
    c.id,                -- NULL if no matching customer
    c.first_name         -- NULL if no matching customer
FROM orders AS o           -- LEFT table (but RIGHT JOIN focuses on RIGHT)
RIGHT JOIN customers AS c  -- RIGHT table (ALL rows included)
    ON o.customer_id = c.id;

-- Key difference:
-- RIGHT JOIN → ALL customers + matching orders (opposite of LEFT JOIN)
-- Table after RIGHT JOIN (customers) → guaranteed to appear

-- Sample Output:
-- cust_id | sales | id | first_name
-- 1       | 2500  | 1  | Rahul      ← matching
-- 1       | 1800  | 1  | Rahul      ← matching
-- 999     | 1200  | NULL| NULL      ← NO customer found!

-- Use RIGHT JOIN when: "Show ALL customers, even orphaned orders"


-- HINGLISH EXPLANATION FOR RIGHT JOIN

-- RIGHT JOIN ka matlab: SAARI customers dikhao (c table) + unke matching orders.
-- Jin customers ke orders nahi hain, order columns NULL mein aayenge.

SELECT
    o.customer_id,       -- orders se customer_id
    o.sales,             -- orders se sales amount
    c.id,                -- customers se id (NULL if no match)
    c.first_name         -- customers se naam (NULL if no match)
FROM orders AS o
RIGHT JOIN customers AS c  -- customers table SABKA data milega
    ON o.customer_id = c.id;

-- INNER vs LEFT vs RIGHT (Hinglish memory trick):
-- INNER → sirf matching (dono taraf match)
-- LEFT  → LEFT table sab + RIGHT matching
-- RIGHT → RIGHT table sab + LEFT matching

-- Is case mein:
-- RIGHT table = customers (sab customers dikhenge)
-- LEFT table = orders (matching orders hi aayenge)

-- Sample Output (Hinglish samjhaav):
-- cust_id | sales | id | first_name
-- 1       | 2500  | 1  | Rahul     ← match mila
-- 2       | 3200  | 2  | Priya     ← match mila
-- NULL    | NULL  | 3  | Amit      ← customer hai, order nahi

-- Pro Tip:
-- RIGHT JOIN kam use hota hai kyunki same result LEFT JOIN se mil jaata hai:
-- FROM customers c LEFT JOIN orders o → same as RIGHT JOIN above!
