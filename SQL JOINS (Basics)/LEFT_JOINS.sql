-- =====================================================
-- LEFT JOIN vs INNER JOIN - Complete Explanation
-- =====================================================

-- ENGLISH EXPLANATION FOR LEFT JOIN

-- LEFT JOIN returns ALL customers (c table) + their orders if they exist.
-- Customers WITHOUT orders also appear with NULL values in order columns.

SELECT
    c.id,
    c.first_name,
    o.order_id,      -- NULL if no order
    o.sales          -- NULL if no order
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id;

-- Key difference from INNER JOIN:
-- INNER JOIN → Only customers WITH orders
-- LEFT JOIN  → ALL customers (with orders OR NULL)

-- Sample Output:
-- id | first_name | order_id | sales
-- 1  | Rahul      | 101      | 2500     ← has orders
-- 2  | Priya      | 103      | 3200     ← has orders
-- 3  | Amit       | NULL     | NULL     ← NO orders! (but still shows)

-- Use LEFT JOIN when: "Show ALL customers, even those without orders"


-- HINGLISH EXPLANATION FOR LEFT JOIN

-- LEFT JOIN ka matlab: SAARI customers dikhao + unke orders (agar hain to).
-- Jin customers ke orders nahi hain, unke liye order columns mein NULL aayega.

SELECT
    c.id,
    c.first_name,
    o.order_id,      -- NULL agar order nahi hai
    o.sales          -- NULL agar order nai hai
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id;

-- INNER JOIN vs LEFT JOIN (Hinglish samjhaav):
-- INNER JOIN → sirf wo customers jinke orders hain
-- LEFT JOIN  → SAARI customers (orders ho ya na ho)

-- Sample data output:
-- id | first_name | order_id | sales
-- 1  | Rahul      | 101      | 2500    ← orders hain
-- 2  | Priya      | 103      | 3200    ← orders hain
-- 3  | Amit       | NULL     | NULL    ← orders NAHI hain (lekin dikha!)

-- LEFT JOIN kab use karo:
-- "SAARI customers ka list chahiye, chahe unke orders ho ya na ho"

-- Pro tip:
-- NULL check karne ke liye:
-- WHERE o.order_id IS NULL  → sirf un customers ko jo NO orders
-- WHERE o.order_id IS NOT NULL → sirf un customers jo orders have karte hain

customers           orders      INNER JOIN Result     LEFT JOIN Result
id | name         order_id|cust  id|name|order_id|sales  id|name|order_id|sales
1  | Rahul ← ───── 101    | 1           1|Rahul|101|2500     1|Rahul|101|2500
2  | Priya ← ───── 103    | 2           2|Priya|103|3200     2|Priya|103|3200
3  | Amit                    ❌            ❌               3|Amit |NULL |NULL  ← !!

INNER = Intersection (common only)
LEFT  = Left + matching right (sab left + jo match kare)
RIGHT = Right + matching left
FULL  = Everything (sab + sab)
