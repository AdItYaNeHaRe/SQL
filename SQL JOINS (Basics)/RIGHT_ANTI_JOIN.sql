-- =====================================================
-- RIGHT JOIN + IS NULL = "ORDERS WITHOUT CUSTOMERS" PATTERN
-- =====================================================

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.id = o.customer_id
WHERE c.id IS NULL;
-- ENGLISH EXPLANATION

-- RIGHT JOIN:
--   Takes ALL rows from the RIGHT table (orders = o)
--   and matching rows from the LEFT table (customers = c).

-- ON c.id = o.customer_id:
--   Try to match each order’s customer_id to a customer’s id.

-- WHERE c.id IS NULL:
--   Keep ONLY those rows where no matching customer was found.

-- RESULT:
--   This query returns all orders that DO NOT have a corresponding
--   customer record (i.e., "orphan" orders with invalid/missing customers).
--
-- Typical columns in result:
--   c.*  → all NULL (no customer)
--   o.*  → the order that has no matching customer

-- HINGLISH EXPLANATION

-- RIGHT JOIN:
--   RIGHT table (orders) ki SAARI rows lega,
--   LEFT table (customers) se sirf matching rows lega.

-- ON c.id = o.customer_id:
--   Har order ke customer_id ko customers.id se match karne ki koshish.

-- WHERE c.id IS NULL:
--   Sirf woh rows rakhna jahan koi matching customer mila HI nahi,
--   matlab customer side puri NULL hai.

-- RESULT (samjho):
--   Ye query un saare orders ko dikhati hai jinke liye customers table mein
--   koi matching customer entry hi nahi hai.
--   Simple bolun to: "aise orders jinke customers record mein exist nahi karte".

-- PATTERN SUMMARY

-- "Customers WITHOUT orders" pattern:
--   LEFT JOIN + WHERE right_table.column IS NULL

-- "Orders WITHOUT customers" pattern:
--   RIGHT JOIN + WHERE left_table.column IS NULL   ← (yehi tumhari query kar rahi hai)
