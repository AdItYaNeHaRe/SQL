/*
=================================================================
QUERY PURPOSE: Combine multiple conditions using logical operators
=================================================================

CONCEPT EXPLANATION (English):
Logical operators (AND, OR, NOT) allow you to combine multiple conditions
in a WHERE clause to create complex filtering logic. While comparison
operators let you test single conditions, logical operators enable you to
build sophisticated queries that evaluate multiple criteria simultaneously.

Think of logical operators as the "glue" that connects your conditions:
- AND: All conditions must be TRUE (intersection/narrowing)
- OR: At least one condition must be TRUE (union/broadening)
- NOT: Reverses/negates a condition (exclusion)

These operators work with Boolean logic (TRUE/FALSE):
- TRUE AND TRUE = TRUE
- TRUE AND FALSE = FALSE
- TRUE OR FALSE = TRUE
- FALSE OR FALSE = FALSE
- NOT TRUE = FALSE
- NOT FALSE = TRUE

Logical operators enable you to express business rules naturally:
- "Show me IT employees who earn more than $50K" (AND)
- "Show me IT employees or anyone earning above $60K" (OR)
- "Show me everyone except Sales department" (NOT)

Understanding operator precedence is critical:
- Parentheses () have highest precedence
- NOT has higher precedence than AND
- AND has higher precedence than OR
- Use parentheses for clarity and correct logic

CONCEPT EXPLANATION (Hinglish):
Logical operators (AND, OR, NOT) aapko WHERE clause mein multiple
conditions ko combine karne dete hain complex filtering logic banane ke
liye. Jahan comparison operators aapko single conditions test karne dete
hain, logical operators aapko sophisticated queries banana enable karte
hain jo ek saath multiple criteria evaluate kar sakti hain.

Logical operators ko conditions ko jodne wala "glue" samjho:
- AND: Saari conditions TRUE honi chahiye (intersection/narrowing)
- OR: Kam se kam ek condition TRUE honi chahiye (union/broadening)
- NOT: Condition ko reverse/negate karta hai (exclusion)

Yeh operators Boolean logic ke saath kaam karte hain (TRUE/FALSE):
- TRUE AND TRUE = TRUE
- TRUE AND FALSE = FALSE
- TRUE OR FALSE = TRUE
- FALSE OR FALSE = FALSE
- NOT TRUE = FALSE
- NOT FALSE = TRUE

Logical operators aapko business rules naturally express karne dete hain:
- "IT employees dikhaao jo $50K se zyada kamate hain" (AND)
- "IT employees dikhaao ya koi bhi jo $60K se zyada kamata hai" (OR)
- "Sales department ke alawa sab dikhaao" (NOT)

Operator precedence samajhna critical hai:
- Parentheses () sabse high precedence
- NOT ka AND se higher precedence
- AND ka OR se higher precedence
- Clarity aur correct logic ke liye parentheses use karo

USE CASES:
- Finding employees in specific dept with salary range
- Searching products by multiple criteria (category + price + availability)
- User authentication (correct username AND correct password)
- Filtering orders (high-value OR VIP customers)
- Excluding records (active users NOT from blocked countries)
- Complex business rules (eligibility criteria with multiple conditions)
- Data validation (checking multiple constraints)
- Access control (permission checks with multiple conditions)
- Discount eligibility (member OR purchase amount > threshold)
- Risk assessment (combining multiple risk factors)

SAMPLE DATA (Employees table):

id | name   | salary | dept
---|--------|--------|--------
1  | Rahul  | 60000  | IT
2  | Priya  | 45000  | HR
3  | Amit   | 55000  | IT
4  | Neha   | 70000  | Sales

This sample data will be used to demonstrate all examples below.

LOGICAL OPERATORS REFERENCE:

Operator | Syntax      | Meaning                    | Precedence
---------|-------------|----------------------------|------------
AND      | cond1 AND cond2 | Both must be TRUE     | Medium
OR       | cond1 OR cond2  | At least one TRUE     | Low
NOT      | NOT cond    | Reverses condition         | High

Truth Tables:

AND Truth Table:
Condition A | Condition B | A AND B
------------|-------------|--------
TRUE        | TRUE        | TRUE   ← Only this is TRUE
TRUE        | FALSE       | FALSE
FALSE       | TRUE        | FALSE
FALSE       | FALSE       | FALSE

OR Truth Table:
Condition A | Condition B | A OR B
------------|-------------|--------
TRUE        | TRUE        | TRUE   ← All these are TRUE
TRUE        | FALSE       | TRUE   ←
FALSE       | TRUE        | TRUE   ←
FALSE       | FALSE       | FALSE

NOT Truth Table:
Condition | NOT Condition
----------|---------------
TRUE      | FALSE
FALSE     | TRUE

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: AND Operator (Both conditions must be TRUE)
=================================================================

SELECT * FROM Employees WHERE salary > 50000 AND dept = 'IT';

Line 1: SELECT * FROM Employees
  → SELECT *: Retrieve all columns
  → FROM Employees: Source table

Line 2: WHERE salary > 50000 AND dept = 'IT';
  → WHERE: Filter clause
  → salary > 50000: First condition (salary greater than 50000)
  → AND: Logical operator requiring BOTH conditions TRUE
  → dept = 'IT': Second condition (department equals IT)
  → Both conditions MUST be TRUE for row to be included

HOW AND WORKS:
1. Database evaluates each condition separately for each row
2. Checks: Is salary > 50000? (TRUE or FALSE)
3. Checks: Is dept = 'IT'? (TRUE or FALSE)
4. Combines: Only includes row if BOTH are TRUE

Evaluation for each row:

Row 1 (Rahul, 60000, IT):
  → salary > 50000? YES (60000 > 50000) ✓
  → dept = 'IT'? YES (IT = IT) ✓
  → Both TRUE → INCLUDED ✓

Row 2 (Priya, 45000, HR):
  → salary > 50000? NO (45000 ≤ 50000) ✗
  → dept = 'IT'? NO (HR ≠ IT) ✗
  → Both FALSE → EXCLUDED ✗

Row 3 (Amit, 55000, IT):
  → salary > 50000? YES (55000 > 50000) ✓
  → dept = 'IT'? YES (IT = IT) ✓
  → Both TRUE → INCLUDED ✓

Row 4 (Neha, 70000, Sales):
  → salary > 50000? YES (70000 > 50000) ✓
  → dept = 'IT'? NO (Sales ≠ IT) ✗
  → One FALSE → EXCLUDED ✗

Result:
id | name  | salary | dept
---|-------|--------|------
1  | Rahul | 60000  | IT    ← Both conditions TRUE
3  | Amit  | 55000  | IT    ← Both conditions TRUE

Key Point: AND narrows/restricts results
- Without AND: 3 rows with salary > 50000 (Rahul, Amit, Neha)
- Without AND: 2 rows with dept = IT (Rahul, Amit)
- With AND: Only 2 rows satisfy BOTH (Rahul, Amit)

Use Case: Finding employees who meet MULTIPLE criteria
- IT employees earning high salaries
- Products that are both in-stock AND discounted
- Users who are both verified AND premium members
- Orders that are both large AND recent

=================================================================
QUERY 2: OR Operator (At least one condition must be TRUE)
=================================================================

SELECT * FROM Employees WHERE dept = 'IT' OR salary > 60000;

Line 2: WHERE dept = 'IT' OR salary > 60000;
  → dept = 'IT': First condition
  → OR: Logical operator requiring AT LEAST ONE condition TRUE
  → salary > 60000: Second condition
  → If EITHER condition is TRUE, row is included

HOW OR WORKS:
1. Evaluates each condition separately for each row
2. Checks: Is dept = 'IT'? (TRUE or FALSE)
3. Checks: Is salary > 60000? (TRUE or FALSE)
4. Combines: Includes row if AT LEAST ONE is TRUE

Evaluation for each row:

Row 1 (Rahul, 60000, IT):
  → dept = 'IT'? YES ✓
  → salary > 60000? NO (60000 ≤ 60000) ✗
  → One TRUE → INCLUDED ✓

Row 2 (Priya, 45000, HR):
  → dept = 'IT'? NO (HR ≠ IT) ✗
  → salary > 60000? NO (45000 ≤ 60000) ✗
  → Both FALSE → EXCLUDED ✗

Row 3 (Amit, 55000, IT):
  → dept = 'IT'? YES ✓
  → salary > 60000? NO (55000 ≤ 60000) ✗
  → One TRUE → INCLUDED ✓

Row 4 (Neha, 70000, Sales):
  → dept = 'IT'? NO (Sales ≠ IT) ✗
  → salary > 60000? YES (70000 > 60000) ✓
  → One TRUE → INCLUDED ✓

Result:
id | name  | salary | dept
---|-------|--------|-------
1  | Rahul | 60000  | IT     ← Matches dept = IT
3  | Amit  | 55000  | IT     ← Matches dept = IT
4  | Neha  | 70000  | Sales  ← Matches salary > 60000

Key Point: OR broadens/expands results
- dept = IT alone: 2 rows (Rahul, Amit)
- salary > 60000 alone: 1 row (Neha)
- With OR: 3 rows total (union of both conditions)

Use Case: Finding employees who meet ANY of several criteria
- IT employees OR high earners (both groups)
- Products on sale OR new arrivals
- Users who are premium OR have referrals
- Orders that are large OR from VIP customers

=================================================================
QUERY 3: NOT Operator (Reverses/negates condition)
=================================================================

SELECT * FROM Employees WHERE NOT dept = 'Sales';

Line 2: WHERE NOT dept = 'Sales';
  → NOT: Logical operator that reverses/negates condition
  → dept = 'Sales': Original condition
  → NOT dept = 'Sales': Means dept ≠ 'Sales'
  → Includes all rows EXCEPT those where dept = 'Sales'

Alternative syntax (equivalent):
SELECT * FROM Employees WHERE dept != 'Sales';
SELECT * FROM Employees WHERE dept <> 'Sales';

HOW NOT WORKS:
1. Evaluates the condition: dept = 'Sales'
2. Reverses the result: TRUE becomes FALSE, FALSE becomes TRUE
3. Includes rows where the reversed condition is TRUE

Evaluation for each row:

Row 1 (Rahul, 60000, IT):
  → dept = 'Sales'? NO (IT ≠ Sales) → FALSE
  → NOT FALSE = TRUE
  → INCLUDED ✓

Row 2 (Priya, 45000, HR):
  → dept = 'Sales'? NO (HR ≠ Sales) → FALSE
  → NOT FALSE = TRUE
  → INCLUDED ✓

Row 3 (Amit, 55000, IT):
  → dept = 'Sales'? NO (IT ≠ Sales) → FALSE
  → NOT FALSE = TRUE
  → INCLUDED ✓

Row 4 (Neha, 70000, Sales):
  → dept = 'Sales'? YES (Sales = Sales) → TRUE
  → NOT TRUE = FALSE
  → EXCLUDED ✗

Result:
id | name  | salary | dept
---|-------|--------|------
1  | Rahul | 60000  | IT     ← Not Sales
2  | Priya | 45000  | HR     ← Not Sales
3  | Amit  | 55000  | IT     ← Not Sales

Key Point: NOT excludes matching rows
- Without NOT: 1 row (Neha from Sales)
- With NOT: 3 rows (everyone except Sales)

Use Case: Excluding specific values
- All departments except Sales
- All products except discontinued
- All users except banned
- All orders except cancelled

=================================================================
QUERY 4: Complex Combination (AND, OR with Parentheses)
=================================================================

SELECT * FROM Employees
WHERE (salary > 50000 AND dept = 'IT')
   OR (salary < 40000 AND dept = 'HR');

Line 2-3: Complex WHERE clause
  → (salary > 50000 AND dept = 'IT'): First group (high-paid IT)
  → OR: Either first group OR second group
  → (salary < 40000 AND dept = 'HR'): Second group (low-paid HR)
  → Parentheses ensure correct evaluation order

Breaking down the logic:
Group A: salary > 50000 AND dept = 'IT'
  → High-paid IT employees

Group B: salary < 40000 AND dept = 'HR'
  → Low-paid HR employees

Final: Group A OR Group B
  → Either high-paid IT OR low-paid HR

HOW PARENTHESES AFFECT EVALUATION:

Without parentheses (WRONG interpretation):
WHERE salary > 50000 AND dept = 'IT' OR salary < 40000 AND dept = 'HR'

Due to precedence (AND before OR), this reads as:
WHERE (salary > 50000 AND dept = 'IT') OR (salary < 40000 AND dept = 'HR')
Actually, this is correct in this case!

But consider this case:
WHERE salary > 50000 AND dept = 'IT' OR dept = 'HR'

Without parentheses, reads as:
WHERE (salary > 50000 AND dept = 'IT') OR (dept = 'HR')
Includes ALL HR employees, not just high-paid ones!

With explicit parentheses (correct):
WHERE (salary > 50000 AND dept = 'IT') OR dept = 'HR'
Clear and unambiguous

Evaluation for each row:

Row 1 (Rahul, 60000, IT):
  → Group A: salary > 50000? YES, dept = IT? YES → TRUE ✓
  → Group B: salary < 40000? NO → FALSE
  → TRUE OR FALSE = TRUE
  → INCLUDED ✓

Row 2 (Priya, 45000, HR):
  → Group A: salary > 50000? NO → FALSE
  → Group B: salary < 40000? NO (45000 ≥ 40000) → FALSE
  → FALSE OR FALSE = FALSE
  → EXCLUDED ✗

Row 3 (Amit, 55000, IT):
  → Group A: salary > 50000? YES, dept = IT? YES → TRUE ✓
  → Group B: salary < 40000? NO → FALSE
  → TRUE OR FALSE = TRUE
  → INCLUDED ✓

Row 4 (Neha, 70000, Sales):
  → Group A: salary > 50000? YES, dept = IT? NO → FALSE
  → Group B: salary < 40000? NO, dept = HR? NO → FALSE
  → FALSE OR FALSE = FALSE
  → EXCLUDED ✗

Result:
id | name  | salary | dept
---|-------|--------|------
1  | Rahul | 60000  | IT     ← Matches Group A (high-paid IT)
3  | Amit  | 55000  | IT     ← Matches Group A (high-paid IT)

Note: If Priya had salary 35000, she would be included (Group B)

Key Point: Parentheses control evaluation order and logic grouping

Use Case: Complex business rules
- Target employees for different programs
- Segment customers by multiple criteria
- Eligibility rules with multiple pathways
- Risk assessment with combined factors

OPERATOR PRECEDENCE (Order of Evaluation):

1. Parentheses () - Highest precedence
2. NOT
3. AND
4. OR - Lowest precedence

Example demonstrating precedence:
*/

-- Without parentheses (precedence: NOT > AND > OR)
SELECT * FROM Employees
WHERE NOT dept = 'Sales' AND salary > 50000 OR dept = 'HR';
-- Reads as: ((NOT dept = 'Sales') AND salary > 50000) OR dept = 'HR'
-- Result: (Non-Sales high earners) OR (all HR)

-- With parentheses for clarity
SELECT * FROM Employees
WHERE (NOT dept = 'Sales' AND salary > 50000) OR dept = 'HR';
-- Same result, but clearer intent

-- Different grouping changes meaning
SELECT * FROM Employees
WHERE NOT (dept = 'Sales' AND salary > 50000 OR dept = 'HR');
-- Reads as: NOT ((dept = 'Sales' AND salary > 50000) OR dept = 'HR')
-- Result: Everyone except (high-paid Sales OR any HR)

/*
COMPREHENSIVE EXAMPLES:

Example 1: Simple AND - Multiple required conditions
*/
SELECT * FROM products
WHERE category = 'Electronics'
  AND price < 500
  AND in_stock = TRUE;
-- All three conditions must be TRUE
-- Affordable electronics that are available

-- Example 2: Simple OR - Any condition satisfies
SELECT * FROM customers
WHERE country = 'USA'
   OR country = 'Canada'
   OR country = 'UK';
-- Customers from any of these countries
-- Better alternative: WHERE country IN ('USA', 'Canada', 'UK')

-- Example 3: NOT with comparison
SELECT * FROM orders
WHERE NOT status = 'Cancelled';
-- All orders except cancelled ones
-- Same as: WHERE status != 'Cancelled'

-- Example 4: AND with range
SELECT * FROM students
WHERE marks >= 40
  AND marks <= 100
  AND attendance >= 75;
-- Students who passed with good attendance
-- Better for range: WHERE marks BETWEEN 40 AND 100 AND attendance >= 75

-- Example 5: OR for multiple acceptable values
SELECT * FROM employees
WHERE position = 'Manager'
   OR position = 'Director'
   OR position = 'VP';
-- Senior positions
-- Better: WHERE position IN ('Manager', 'Director', 'VP')

-- Example 6: NOT with AND
SELECT * FROM users
WHERE NOT (is_banned = TRUE AND is_verified = FALSE);
-- Excludes banned unverified users
-- Includes: not banned, or verified, or both

-- Example 7: Complex eligibility check
SELECT * FROM applicants
WHERE (age >= 18 AND age <= 65)
  AND (experience >= 2 OR education = 'Masters');
-- Age requirement AND (experience OR education)

-- Example 8: Multiple department search with salary
SELECT * FROM employees
WHERE (dept = 'IT' OR dept = 'Engineering')
  AND salary > 50000;
-- High-paid tech employees

-- Example 9: Excluding multiple conditions
SELECT * FROM products
WHERE NOT (category = 'Discontinued' OR stock = 0);
-- Active products with stock
-- Same as: WHERE category != 'Discontinued' AND stock > 0

-- Example 10: Date range with status
SELECT * FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2024-02-01'
  AND (status = 'Completed' OR status = 'Shipped');
-- January orders that are completed or shipped

-- Example 11: Nested AND/OR logic
SELECT * FROM loans
WHERE (credit_score >= 700 AND income >= 50000)
   OR (credit_score >= 650 AND income >= 75000 AND has_collateral = TRUE);
-- Two different qualification paths

-- Example 12: NOT with OR (De Morgan's Law)
SELECT * FROM customers
WHERE NOT (country = 'USA' OR age < 18);
-- Neither from USA nor under 18
-- Same as: WHERE country != 'USA' AND age >= 18

-- Example 13: Three-way AND
SELECT * FROM flights
WHERE departure_city = 'NYC'
  AND arrival_city = 'LAX'
  AND departure_date = '2024-03-15';
-- Very specific flight search

-- Example 14: Three-way OR
SELECT * FROM alerts
WHERE severity = 'Critical'
   OR severity = 'High'
   OR affected_users > 1000;
-- Important alerts by different criteria

-- Example 15: Mixed logic with NULL checks
SELECT * FROM employees
WHERE (dept = 'IT' AND salary > 50000)
  AND bonus IS NOT NULL
  AND NOT (performance_rating = 'Poor');
-- IT employees with salary, bonus, and good performance

-- Example 16: Geographic filtering
SELECT * FROM stores
WHERE (state = 'CA' OR state = 'NY')
  AND store_type = 'Flagship'
  AND is_open = TRUE;
-- Open flagship stores in CA or NY

-- Example 17: User segmentation
SELECT * FROM users
WHERE (registration_date < '2023-01-01' AND purchase_count > 10)
   OR (is_premium = TRUE AND last_login > DATE_SUB(NOW(), INTERVAL 7 DAY));
-- Loyal old users OR active premium users

-- Example 18: Complex product filtering
SELECT * FROM products
WHERE ((category = 'Electronics' AND price < 1000)
    OR (category = 'Books' AND price < 50))
  AND rating >= 4.0
  AND NOT brand = 'Generic';
-- Quality affordable products by category, excluding generics

-- Example 19: Time-based filtering
SELECT * FROM sessions
WHERE (start_time >= '09:00:00' AND start_time < '12:00:00')
   OR (start_time >= '14:00:00' AND start_time < '17:00:00');
-- Morning or afternoon sessions (excluding lunch)

-- Example 20: Risk assessment
SELECT * FROM transactions
WHERE (amount > 10000 OR foreign_country = TRUE)
  AND NOT (customer_verified = TRUE AND transaction_age < 24);
-- High-risk transactions for review

/*
REAL-WORLD SCENARIOS:

Scenario 1: E-commerce Product Search
*/
-- Find affordable premium laptops in stock
SELECT * FROM products
WHERE category = 'Laptops'
  AND brand IN ('Dell', 'HP', 'Lenovo')
  AND price >= 500 AND price <= 1500
  AND stock_quantity > 0
  AND rating >= 4.0;

/*
Scenario 2: Student Scholarship Eligibility
*/
-- Students eligible for merit scholarship
SELECT * FROM students
WHERE (marks >= 90 AND attendance >= 85)
   OR (marks >= 85 AND attendance >= 90 AND has_extracurricular = TRUE)
   OR (marks >= 80 AND is_minority = TRUE AND family_income < 30000);
-- Three different paths to eligibility

/*
Scenario 3: Employee Bonus Calculation
*/
-- Employees eligible for year-end bonus
SELECT * FROM employees
WHERE (performance_rating IN ('Excellent', 'Outstanding') AND tenure_years >= 1)
   OR (performance_rating = 'Good' AND tenure_years >= 3)
  AND NOT on_pip = TRUE  -- Not on performance improvement plan
  AND employment_type = 'Full-Time';

/*
Scenario 4: Loan Application Approval
*/
-- Auto-approve loan applications
SELECT * FROM loan_applications
WHERE (credit_score >= 750 AND debt_to_income_ratio < 0.3 AND employment_verified = TRUE)
   OR (credit_score >= 700 AND debt_to_income_ratio < 0.2 AND has_co_signer = TRUE)
  AND NOT (bankruptcy_history = TRUE OR delinquent_accounts > 0);

/*
Scenario 5: Customer Segmentation for Marketing
*/
-- Target customers for premium promotion
SELECT * FROM customers
WHERE (total_purchases > 5000 AND member_since < '2022-01-01')
   OR (average_order_value > 200 AND last_purchase_date > DATE_SUB(NOW(), INTERVAL 30 DAY))
   OR is_vip = TRUE
  AND email_subscribed = TRUE
  AND NOT unsubscribed = TRUE;

/*
Scenario 6: Flight Booking Search
*/
-- Find suitable flights
SELECT * FROM flights
WHERE departure_city = 'NYC'
  AND arrival_city = 'LAX'
  AND departure_date BETWEEN '2024-03-15' AND '2024-03-20'
  AND (class = 'Economy' OR class = 'Premium Economy')
  AND available_seats >= 2
  AND NOT airline = 'Budget Air'
  AND (is_direct = TRUE OR layover_duration < 180);  -- Direct or short layover

/*
Scenario 7: Medical Records - High-Risk Patients
*/
-- Identify high-risk patients for proactive care
SELECT * FROM patients
WHERE (age > 65 AND chronic_conditions >= 2)
   OR (diabetes = TRUE AND heart_disease = TRUE)
   OR (age > 50 AND family_history_cancer = TRUE AND smoker = TRUE)
  AND insurance_active = TRUE
  AND NOT deceased = TRUE;

/*
Scenario 8: Social Media Content Moderation
*/
-- Flag content for review
SELECT * FROM posts
WHERE (reported_count >= 5 OR contains_banned_words = TRUE)
  AND NOT (reviewed = TRUE AND approved = TRUE)
  AND post_date > DATE_SUB(NOW(), INTERVAL 7 DAY)
  AND (engagement_rate > 100 OR follower_count > 10000);
-- High-impact content needing review

/*
DE MORGAN'S LAWS (Important for NOT with AND/OR):

Law 1: NOT (A AND B) = (NOT A) OR (NOT B)
Law 2: NOT (A OR B) = (NOT A) AND (NOT B)
*/

-- Example of Law 1:
-- "Not (IT department AND high salary)"
SELECT * FROM employees WHERE NOT (dept = 'IT' AND salary > 50000);
-- Equivalent to:
SELECT * FROM employees WHERE dept != 'IT' OR salary <= 50000;
-- Includes: non-IT employees OR low-paid employees (or both)

-- Example of Law 2:
-- "Not (USA OR Canada)"
SELECT * FROM customers WHERE NOT (country = 'USA' OR country = 'Canada');
-- Equivalent to:
SELECT * FROM customers WHERE country != 'USA' AND country != 'Canada';
-- Excludes: USA customers AND Canada customers

/*
COMMON PATTERNS AND IDIOMS:

Pattern 1: Range with additional condition
*/
SELECT * FROM products
WHERE price BETWEEN 100 AND 500
  AND category = 'Electronics';

-- Pattern 2: Multiple exclusions
SELECT * FROM orders
WHERE status NOT IN ('Cancelled', 'Refunded', 'Failed');
-- Better than: WHERE status != 'Cancelled' AND status != 'Refunded' AND status != 'Failed'

-- Pattern 3: Active records
SELECT * FROM users
WHERE is_active = TRUE
  AND deleted_at IS NULL
  AND NOT banned = TRUE;

-- Pattern 4: Recent high-value transactions
SELECT * FROM transactions
WHERE amount > 1000
  AND transaction_date >= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- Pattern 5: Verified and complete profiles
SELECT * FROM profiles
WHERE email_verified = TRUE
  AND phone_verified = TRUE
  AND profile_picture IS NOT NULL
  AND bio IS NOT NULL;

/*
PERFORMANCE CONSIDERATIONS:

1. Order conditions by selectivity (most restrictive first):
*/
-- ✓ Better (assuming dept is highly selective):
SELECT * FROM employees
WHERE dept = 'IT'  -- Filters to 100 rows
  AND salary > 50000;  -- Filters to 50 rows

-- vs.
-- ⚠️ Less optimal:
SELECT * FROM employees
WHERE salary > 50000  -- Filters to 500 rows
  AND dept = 'IT';  -- Filters to 100 rows

/*
2. Use indexes on columns in WHERE clause:
*/
CREATE INDEX idx_dept_salary ON employees(dept, salary);
-- Composite index helps with: WHERE dept = 'IT' AND salary > 50000

/*
3. OR may prevent index usage:
*/
-- May not use indexes efficiently:
SELECT * FROM employees
WHERE dept = 'IT' OR dept = 'Sales';

-- Better with index:
SELECT * FROM employees
WHERE dept IN ('IT', 'Sales');

-- Or use UNION for complex OR:
SELECT * FROM employees WHERE dept = 'IT'
UNION
SELECT * FROM employees WHERE salary > 60000;

/*
4. Avoid functions on indexed columns in WHERE:
*/
-- ❌ Bad (can't use index on salary):
SELECT * FROM employees
WHERE ROUND(salary / 1000) * 1000 > 50000;

-- ✓ Good (can use index):
SELECT * FROM employees
WHERE salary > 50000;

/*
COMMON MISTAKES TO AVOID:

1. ❌ Missing parentheses with mixed AND/OR:
*/
SELECT * FROM employees
WHERE salary > 50000 AND dept = 'IT' OR dept = 'Sales';
-- Reads as: (salary > 50000 AND dept = 'IT') OR dept = 'Sales'
-- Includes ALL Sales employees, even with low salary!

-- ✓ Correct:
SELECT * FROM employees
WHERE salary > 50000 AND (dept = 'IT' OR dept = 'Sales');

/*
2. ❌ Using AND when OR is needed:
*/
SELECT * FROM employees
WHERE dept = 'IT' AND dept = 'Sales';
-- ❌ Impossible! dept can't be both IT AND Sales simultaneously
-- Returns 0 rows

-- ✓ Correct:
SELECT * FROM employees
WHERE dept = 'IT' OR dept = 'Sales';

/*
3. ❌ NOT with wrong scope:
*/
SELECT * FROM employees
WHERE NOT dept = 'IT' AND salary > 50000;
-- Reads as: (NOT dept = 'IT') AND salary > 50000
-- Non-IT employees with high salary

-- If you meant "not (IT with high salary)":
SELECT * FROM employees
WHERE NOT (dept = 'IT' AND salary > 50000);

/*
4. ❌ Redundant conditions:
*/
SELECT * FROM employees
WHERE salary > 50000 AND salary > 30000;
-- Second condition is redundant (if > 50000, definitely > 30000)

-- ✓ Simplified:
SELECT * FROM employees
WHERE salary > 50000;

/*
5. ❌ Contradictory conditions:
*/
SELECT * FROM employees
WHERE salary > 60000 AND salary < 50000;
-- Impossible condition, returns 0 rows

/*
6. ❌ NULL comparison issues:
*/
SELECT * FROM employees
WHERE bonus = NULL OR bonus > 1000;
-- ❌ "bonus = NULL" never TRUE (should be IS NULL)

-- ✓ Correct:
SELECT * FROM employees
WHERE bonus IS NULL OR bonus > 1000;

/*
7. ❌ Case sensitivity in string comparisons:
*/
SELECT * FROM employees
WHERE dept = 'it';  -- May not match 'IT' in case-sensitive databases

-- ✓ Better:
SELECT * FROM employees
WHERE LOWER(dept) = 'it';

/*
TESTING YOUR UNDERSTANDING:

Given Employees data:
1. Rahul | 60000 | IT
2. Priya | 45000 | HR
3. Amit  | 55000 | IT
4. Neha  | 70000 | Sales

Quiz:
*/

-- Q1: How many rows for: salary > 50000 OR dept = 'HR'?
SELECT COUNT(*) FROM Employees
WHERE salary > 50000 OR dept = 'HR';
-- Answer: 4 (Rahul, Priya, Amit, Neha - all match one condition)

-- Q2: How many rows for: salary > 50000 AND dept = 'HR'?
SELECT COUNT(*) FROM Employees
WHERE salary > 50000 AND dept = 'HR';
-- Answer: 0 (Priya is HR but salary 45000 ≤ 50000)

-- Q3: What's returned: NOT (dept = 'IT' OR dept = 'Sales')?
SELECT * FROM Employees
WHERE NOT (dept = 'IT' OR dept = 'Sales');
-- Answer: Priya (HR only - not IT and not Sales)

-- Q4: Difference between these two queries?
-- Query A:
SELECT * FROM Employees
WHERE dept = 'IT' AND salary > 50000 OR dept = 'Sales';
-- Returns: Rahul, Amit, Neha (high-paid IT + all Sales)

-- Query B:
SELECT * FROM Employees
WHERE dept = 'IT' AND (salary > 50000 OR dept = 'Sales');
-- Returns: Rahul, Amit (IT employees only, with salary > 50000)
-- Wait, this logic is wrong! Should be:
SELECT * FROM Employees
WHERE (dept = 'IT' AND salary > 50000) OR dept = 'Sales';
-- Returns: Rahul, Amit, Neha

/*
HINGLISH SUMMARY:

Logical operators (AND, OR, NOT) multiple conditions ko combine karne
ke liye use hote hain WHERE clause mein.

1. AND - SAARI conditions TRUE chahiye (narrowing)
   SELECT * FROM Employees WHERE salary > 50000 AND dept = 'IT';
   → Dono conditions match honi chahiye
   → Result: Rahul, Amit (IT employees with high salary)
   → Sabse restrictive - kam rows return karta hai

2. OR - KAM SE KAM EK condition TRUE chahiye (broadening)
   SELECT * FROM Employees WHERE dept = 'IT' OR salary > 60000;
   → Ek bhi condition match ho jaaye, enough hai
   → Result: Rahul, Amit, Neha (IT employees + anyone with 60K+)
   → Zyada inclusive - zyada rows return karta hai

3. NOT - Condition ko REVERSE karta hai (negation)
   SELECT * FROM Employees WHERE NOT dept = 'Sales';
   → Condition ko ulta kar deta hai
   → Result: Rahul, Priya, Amit (everyone except Sales)
   → Same as: WHERE dept != 'Sales'

4. Complex combinations - Parentheses use karo
   SELECT * FROM Employees
   WHERE (salary > 50000 AND dept = 'IT')
      OR (salary < 40000 AND dept = 'HR');
   → Groups banao logic clear rakhne ke liye
   → Parentheses se evaluation order control karo

Truth Tables (yaad rakho):
- TRUE AND TRUE = TRUE (sirf yahi TRUE)
- TRUE OR FALSE = TRUE (koi bhi ek TRUE = TRUE)
- NOT TRUE = FALSE (ulta ho jata hai)

Operator Precedence (konsa pehle evaluate hoga):
1. () Parentheses - Sabse pehle
2. NOT - Phir NOT
3. AND - Phir AND
4. OR - Sabse last

Common patterns:
- Range + condition: price BETWEEN 100 AND 500 AND category = 'Electronics'
- Multiple exclusions: status NOT IN ('Cancelled', 'Refunded')
- Active records: is_active = TRUE AND deleted_at IS NULL
- Complex eligibility: (criteria_A AND criteria_B) OR (criteria_C AND criteria_D)

Real-world examples:
- Employee search: High-paid IT employees
  WHERE salary > 50000 AND dept = 'IT'
- Product filter: Affordable items from specific brands
  WHERE price < 100 AND brand IN ('A', 'B', 'C')
- User segment: Active members or recent shoppers
  WHERE is_member = TRUE OR last_purchase > '2024-01-01'
- Loan approval: Good credit and income, or co-signer
  WHERE (credit >= 700 AND income > 50000) OR has_cosigner = TRUE

De Morgan's Laws:
- NOT (A AND B) = (NOT A) OR (NOT B)
- NOT (A OR B) = (NOT A) AND (NOT B)

Common mistakes:
❌ Parentheses missing (galat logic)
❌ AND jahan OR chahiye (impossible conditions)
❌ NOT ka scope galat (wrong negation)
❌ NULL comparison mein = use karna (IS NULL chahiye)
❌ Case sensitivity ignore karna

Performance tips:
- Selective conditions pehle rakho
- Indexes use karo
- OR ki jagah IN use karo (jahan possible)
- Functions avoid karo indexed columns pe

Remember:
- AND = sabhi TRUE chahiye (intersection)
- OR = koi ek TRUE chahiye (union)
- NOT = ulta kar do (negation)
- Parentheses = clarity aur correctness ke liye zaroori
- Hamesha test karo different data pe

KEY TAKEAWAYS:
✓ AND requires ALL conditions TRUE (narrowing)
✓ OR requires AT LEAST ONE condition TRUE (broadening)
✓ NOT reverses/negates a condition (exclusion)
✓ Use parentheses for clarity and correct logic
✓ Precedence: () > NOT > AND > OR
✓ AND narrows results, OR expands results
✓ Can combine multiple operators for complex logic
✓ De Morgan's Laws for NOT with AND/OR
✓ NULL requires IS NULL, not = NULL
✓ Test with sample data to verify logic
✓ Use indexes on columns in WHERE clause
✓ Watch for case sensitivity in strings
✓ Order conditions by selectivity

=================================================================
*/

-- Logical Operators Demo with Employees table:

-- AND example: Both conditions must be TRUE
SELECT * FROM Employees WHERE salary > 50000 AND dept = 'IT';
-- Result: rows 1, 3 (Rahul, Amit) - IT employees earning over 50K

-- OR example: At least one condition must be TRUE
SELECT * FROM Employees WHERE dept = 'IT' OR salary > 60000;
-- Result: rows 1, 3, 4 (Rahul, Amit, Neha) - IT employees OR high earners

-- NOT example: Reverses condition
SELECT * FROM Employees WHERE NOT dept = 'Sales';
-- Result: rows 1, 2, 3 (everyone except Neha from Sales)

-- Complex combination: Groups with parentheses
SELECT * FROM Employees
WHERE (salary > 50000 AND dept = 'IT')
   OR (salary < 40000 AND dept = 'HR');
-- Result: High-paid IT employees OR low-paid HR employees
-- With sample data: rows 1, 3 (Rahul, Amit) - only Group A matches
