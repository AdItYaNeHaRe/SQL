/*
=================================================================
QUERY PURPOSE: Perform mathematical operations and transformations on numeric data
=================================================================

CONCEPT EXPLANATION (English):
Numeric functions (also called mathematical or arithmetic functions) are
built-in SQL functions that perform calculations and transformations on
numeric data types (INT, DECIMAL, FLOAT, etc.). They allow you to:
- Round numbers to specific precision
- Calculate absolute values
- Perform mathematical operations (power, square root, etc.)
- Generate random numbers
- Truncate decimal places
- Calculate aggregates and statistics

Numeric functions are essential for:
- Financial calculations (prices, taxes, totals)
- Statistical analysis (averages, deviations)
- Data formatting (rounding for display)
- Mathematical computations (scientific, engineering)
- Data validation (checking ranges, constraints)
- Report generation (formatted numbers)

Categories of Numeric Functions:

1. ROUNDING Functions
   - ROUND: Round to nearest value
   - CEILING/CEIL: Round up to nearest integer
   - FLOOR: Round down to nearest integer
   - TRUNCATE: Remove decimal places without rounding

2. ABSOLUTE & SIGN Functions
   - ABS: Get absolute value (remove negative sign)
   - SIGN: Get sign of number (-1, 0, or 1)

3. POWER & ROOT Functions
   - POWER/POW: Raise to power (exponentiation)
   - SQRT: Square root
   - EXP: Exponential (e^x)
   - LN/LOG: Natural logarithm
   - LOG10: Base-10 logarithm

4. TRIGONOMETRIC Functions
   - SIN, COS, TAN: Basic trigonometry
   - ASIN, ACOS, ATAN: Inverse trigonometry
   - RADIANS, DEGREES: Angle conversion

5. RANDOM Functions
   - RAND/RANDOM: Generate random number

6. CONVERSION Functions
   - CAST: Convert data types
   - CONVERT: Type conversion (SQL Server)

7. MODULO & DIVISION
   - MOD: Remainder after division
   - DIV: Integer division

8. MIN/MAX Functions
   - GREATEST: Maximum of values
   - LEAST: Minimum of values

CONCEPT EXPLANATION (Hinglish):
Numeric functions (mathematical ya arithmetic functions bhi kehte hain)
built-in SQL functions hain jo numeric data types (INT, DECIMAL, FLOAT,
etc.) pe calculations aur transformations perform karte hain. Yeh aapko
allow karte hain:
- Numbers ko specific precision tak round karna
- Absolute values calculate karna
- Mathematical operations karna (power, square root, etc.)
- Random numbers generate karna
- Decimal places truncate karna
- Aggregates aur statistics calculate karna

Numeric functions zaroori hain:
- Financial calculations ke liye (prices, taxes, totals)
- Statistical analysis ke liye (averages, deviations)
- Data formatting ke liye (rounding for display)
- Mathematical computations ke liye (scientific, engineering)
- Data validation ke liye (checking ranges, constraints)
- Report generation ke liye (formatted numbers)

Numeric Functions ki categories:

1. ROUNDING Functions
   - ROUND: Nearest value tak round karna
   - CEILING/CEIL: Upar nearest integer tak round karna
   - FLOOR: Neeche nearest integer tak round karna
   - TRUNCATE: Bina rounding ke decimal places remove karna

2. ABSOLUTE & SIGN Functions
   - ABS: Absolute value nikalna (negative sign hatana)
   - SIGN: Number ka sign nikalna (-1, 0, ya 1)

3. POWER & ROOT Functions
   - POWER/POW: Power tak raise karna (exponentiation)
   - SQRT: Square root nikalna
   - EXP: Exponential (e^x)
   - LN/LOG: Natural logarithm
   - LOG10: Base-10 logarithm

4. TRIGONOMETRIC Functions
   - SIN, COS, TAN: Basic trigonometry
   - ASIN, ACOS, ATAN: Inverse trigonometry
   - RADIANS, DEGREES: Angle conversion

5. RANDOM Functions
   - RAND/RANDOM: Random number generate karna

6. CONVERSION Functions
   - CAST: Data types convert karna
   - CONVERT: Type conversion (SQL Server)

7. MODULO & DIVISION
   - MOD: Division ke baad remainder
   - DIV: Integer division

8. MIN/MAX Functions
   - GREATEST: Values mein se maximum
   - LEAST: Values mein se minimum

USE CASES:
- E-commerce: Calculate discounts, tax, shipping costs
- Finance: Interest calculations, loan payments, compound interest
- Analytics: Statistical measures, data analysis
- Reporting: Format numbers for presentation
- Gaming: Random number generation, score calculations
- Scientific: Mathematical computations, formulas
- Inventory: Stock calculations, reorder points
- Payroll: Salary calculations, deductions, bonuses
- Sales: Commission calculations, revenue analysis
- Engineering: Technical calculations, measurements

SAMPLE DATA (Products table):

id | product_name    | price   | cost    | stock  | discount_pct | rating
---|-----------------|---------|---------|--------|--------------|--------
1  | Laptop          | 999.99  | 750.50  | 45     | 15.5         | 4.7
2  | Mouse           | 25.50   | 12.30   | 150    | 10.0         | 4.2
3  | Keyboard        | 79.95   | 45.20   | 80     | 20.0         | 4.5
4  | Monitor         | 299.00  | 200.00  | 30     | 12.5         | 4.8
5  | Headphones      | 149.99  | 89.99   | 0      | 25.0         | 3.9

Additional sample for calculations:

id | employee_name | salary   | bonus    | deduction | hours_worked
---|---------------|----------|----------|-----------|-------------
1  | John          | 5500.75  | 850.50   | -200.25   | 42.5
2  | Mary          | 6200.00  | 1200.00  | -150.00   | 40.0
3  | Bob           | 4800.50  | 500.25   | -100.50   | 38.75
4  | Alice         | 7500.00  | 1500.00  | -250.00   | 45.0

=================================================================
SECTION 1: ROUNDING FUNCTIONS
=================================================================

1.1 ROUND - Round to Nearest Value
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: ROUND(number, decimals)
Purpose: Rounds number to specified decimal places
  - decimals > 0: Round to that many decimal places
  - decimals = 0: Round to nearest integer
  - decimals < 0: Round to left of decimal point
Returns: Rounded number
Rounding Rule: 0.5 and above rounds up, below 0.5 rounds down
*/

-- Example 1: Round to 2 decimal places (common for money)
SELECT
    product_name,
    price,
    ROUND(price, 2) AS price_rounded_2,
    cost,
    ROUND(cost, 2) AS cost_rounded_2
FROM Products;
/*
Result:
product_name | price  | price_rounded_2 | cost   | cost_rounded_2
-------------|--------|-----------------|--------|----------------
Laptop       | 999.99 | 999.99          | 750.50 | 750.50
Mouse        | 25.50  | 25.50           | 12.30  | 12.30
Keyboard     | 79.95  | 79.95           | 45.20  | 45.20

Use Case: Financial data display, price formatting
*/

-- Example 2: Round to nearest integer (0 decimal places)
SELECT
    product_name,
    price,
    ROUND(price, 0) AS price_integer,
    discount_pct,
    ROUND(discount_pct, 0) AS discount_integer
FROM Products;
/*
Result:
product_name | price  | price_integer | discount_pct | discount_integer
-------------|--------|---------------|--------------|------------------
Laptop       | 999.99 | 1000          | 15.5         | 16
Mouse        | 25.50  | 26            | 10.0         | 10
Keyboard     | 79.95  | 80            | 20.0         | 20
Monitor      | 299.00 | 299           | 12.5         | 13

Rounding rules:
- 999.99 → 1000 (0.99 ≥ 0.5, rounds up)
- 25.50 → 26 (0.50 = 0.5, rounds up)
- 79.95 → 80 (0.95 ≥ 0.5, rounds up)
- 12.5 → 13 (0.5 = 0.5, rounds up)

Use Case: Simplified pricing, whole number displays
*/

-- Example 3: Round to left of decimal (negative decimals)
SELECT
    price,
    ROUND(price, 0) AS round_to_ones,
    ROUND(price, -1) AS round_to_tens,
    ROUND(price, -2) AS round_to_hundreds
FROM Products;
/*
Result:
price  | round_to_ones | round_to_tens | round_to_hundreds
-------|---------------|---------------|-------------------
999.99 | 1000          | 1000          | 1000
25.50  | 26            | 30            | 0
79.95  | 80            | 80            | 100
299.00 | 299           | 300           | 300

Explanation:
- ROUND(25.50, -1): Round to nearest 10 → 30
- ROUND(79.95, -2): Round to nearest 100 → 100
- ROUND(299.00, -1): Round to nearest 10 → 300

Use Case: Approximate pricing, budgeting, estimates
*/

-- Example 4: Calculate discount amount with rounding
SELECT
    product_name,
    price,
    discount_pct,
    ROUND(price * (discount_pct / 100), 2) AS discount_amount,
    ROUND(price - (price * discount_pct / 100), 2) AS final_price
FROM Products;
/*
Result:
product_name | price  | discount_pct | discount_amount | final_price
-------------|--------|--------------|-----------------|-------------
Laptop       | 999.99 | 15.5         | 155.00          | 845.00
Mouse        | 25.50  | 10.0         | 2.55            | 22.95
Keyboard     | 79.95  | 20.0         | 15.99           | 63.96
Monitor      | 299.00 | 12.5         | 37.38           | 261.62

Calculations:
Laptop: 999.99 * 0.155 = 154.9984... → ROUND to 155.00
Final: 999.99 - 155.00 = 844.99 → ROUND to 845.00

Use Case: E-commerce pricing, discount calculations
*/

-- Example 5: Rounding for display vs storage
SELECT
    employee_name,
    salary AS exact_salary,
    ROUND(salary, 2) AS display_salary,
    ROUND(salary, 0) AS simplified_salary,
    ROUND(salary, -2) AS budgeted_salary
FROM Employees;
/*
Result:
employee_name | exact_salary | display_salary | simplified | budgeted
--------------|--------------|----------------|------------|----------
John          | 5500.75      | 5500.75        | 5501       | 5500
Mary          | 6200.00      | 6200.00        | 6200       | 6200
Bob           | 4800.50      | 4800.50        | 4801       | 4800
Alice         | 7500.00      | 7500.00        | 7500       | 7500

Use Case: Different precision levels for different purposes
*/

/*
1.2 CEILING/CEIL - Round Up to Nearest Integer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CEILING(number) or CEIL(number)
Purpose: Always rounds UP to next integer, never down
Returns: Smallest integer greater than or equal to number
Note: CEILING and CEIL are same function (different names)
*/

-- Example 6: Basic ceiling (always rounds up)
SELECT
    product_name,
    price,
    CEILING(price) AS price_ceiling,
    CEIL(price) AS price_ceil  -- Same result
FROM Products;
/*
Result:
product_name | price  | price_ceiling | price_ceil
-------------|--------|---------------|------------
Laptop       | 999.99 | 1000          | 1000
Mouse        | 25.50  | 26            | 26
Keyboard     | 79.95  | 80            | 80
Monitor      | 299.00 | 299           | 299
Headphones   | 149.99 | 150           | 150

Key behavior:
- 999.99 → 1000 (rounds UP even though .99 is close to 1000)
- 25.50 → 26 (rounds UP, not to nearest like ROUND)
- 299.00 → 299 (already integer, no change)

Difference from ROUND:
- ROUND(25.50, 0) → 26 (rounds up because .5 or higher)
- ROUND(25.49, 0) → 25 (rounds down because below .5)
- CEILING(25.01) → 26 (ALWAYS rounds up, even .01)
- CEILING(25.99) → 26 (rounds up)

Use Case: Inventory (need whole units), pagination, allocation
*/

-- Example 7: Calculate minimum packages needed
SELECT
    product_name,
    stock,
    CEILING(stock / 10.0) AS boxes_of_10_needed,
    CEILING(stock / 12.0) AS boxes_of_12_needed
FROM Products;
/*
Result:
product_name | stock | boxes_of_10_needed | boxes_of_12_needed
-------------|-------|--------------------|-----------------
Laptop       | 45    | 5                  | 4
Mouse        | 150   | 15                 | 13
Keyboard     | 80    | 8                  | 7
Monitor      | 30    | 3                  | 3
Headphones   | 0     | 0                  | 0

Explanation:
Laptop (45 units):
- Boxes of 10: 45 / 10 = 4.5 → CEILING → 5 boxes
- Boxes of 12: 45 / 12 = 3.75 → CEILING → 4 boxes

Mouse (150 units):
- Boxes of 10: 150 / 10 = 15.0 → CEILING → 15 boxes (exact)
- Boxes of 12: 150 / 12 = 12.5 → CEILING → 13 boxes

Use Case: Packaging, shipping calculations, resource allocation
*/

-- Example 8: Calculate pages needed for pagination
SELECT
    'Total Products' AS description,
    COUNT(*) AS total_items,
    CEILING(COUNT(*) / 10.0) AS pages_of_10,
    CEILING(COUNT(*) / 20.0) AS pages_of_20
FROM Products;
/*
Result:
description      | total_items | pages_of_10 | pages_of_20
-----------------|-------------|-------------|-------------
Total Products   | 5           | 1           | 1

If total_items = 25:
- Pages of 10: 25 / 10 = 2.5 → CEILING → 3 pages
- Pages of 20: 25 / 20 = 1.25 → CEILING → 2 pages

Use Case: Pagination, UI design, data display
*/

/*
1.3 FLOOR - Round Down to Nearest Integer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: FLOOR(number)
Purpose: Always rounds DOWN to previous integer, never up
Returns: Largest integer less than or equal to number
*/

-- Example 9: Basic floor (always rounds down)
SELECT
    product_name,
    price,
    FLOOR(price) AS price_floor
FROM Products;
/*
Result:
product_name | price  | price_floor
-------------|--------|-------------
Laptop       | 999.99 | 999
Mouse        | 25.50  | 25
Keyboard     | 79.95  | 79
Monitor      | 299.00 | 299
Headphones   | 149.99 | 149

Key behavior:
- 999.99 → 999 (rounds DOWN, loses .99)
- 25.50 → 25 (rounds DOWN, even though .5 would round up in ROUND)
- 299.00 → 299 (already integer, no change)

Comparison:
- ROUND(999.99, 0) → 1000 (rounds to nearest)
- CEILING(999.99) → 1000 (rounds up)
- FLOOR(999.99) → 999 (rounds down)

Use Case: Conservative estimates, minimum guarantees
*/

-- Example 10: Calculate complete sets available
SELECT
    product_name,
    stock,
    FLOOR(stock / 5.0) AS complete_sets_of_5,
    FLOOR(stock / 10.0) AS complete_sets_of_10
FROM Products;
/*
Result:
product_name | stock | complete_sets_of_5 | complete_sets_of_10
-------------|-------|--------------------|-----------------
Laptop       | 45    | 9                  | 4
Mouse        | 150   | 30                 | 15
Keyboard     | 80    | 16                 | 8
Monitor      | 30    | 6                  | 3
Headphones   | 0     | 0                  | 0

Explanation:
Laptop (45 units):
- Sets of 5: 45 / 5 = 9.0 → FLOOR → 9 complete sets
- Sets of 10: 45 / 10 = 4.5 → FLOOR → 4 complete sets (5 units remain)

Mouse (150 units):
- Sets of 5: 150 / 5 = 30.0 → FLOOR → 30 complete sets
- Sets of 10: 150 / 10 = 15.0 → FLOOR → 15 complete sets

Use Case: Inventory bundling, complete kits, guaranteed quantities
*/

-- Example 11: Calculate age in complete years
SELECT
    'John Doe' AS name,
    '1990-03-15' AS birth_date,
    FLOOR(DATEDIFF(CURDATE(), '1990-03-15') / 365.25) AS age_years;
/*
Result (as of 2024):
name     | birth_date | age_years
---------|------------|----------
John Doe | 1990-03-15 | 33

Explanation:
Days lived / 365.25 = years with decimals
FLOOR ensures we only count COMPLETE years

Use Case: Age calculations, tenure, membership duration
*/

/*
1.4 TRUNCATE - Remove Decimal Places Without Rounding
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: TRUNCATE(number, decimals)
Purpose: Cuts off decimal places without rounding
  - Similar to FLOOR for positive decimals
  - Different from ROUND (doesn't round, just cuts)
Returns: Number truncated to specified decimals
*/

-- Example 12: Truncate vs Round comparison
SELECT
    price,
    ROUND(price, 0) AS rounded,
    TRUNCATE(price, 0) AS truncated,
    FLOOR(price) AS floored,
    CEILING(price) AS ceiled
FROM Products;
/*
Result:
price  | rounded | truncated | floored | ceiled
-------|---------|-----------|---------|--------
999.99 | 1000    | 999       | 999     | 1000
25.50  | 26      | 25        | 25      | 26
79.95  | 80      | 79        | 79      | 80
299.00 | 299     | 299       | 299     | 299

Comparison for 999.99:
- ROUND: 999.99 → 1000 (rounds UP because .99 ≥ .5)
- TRUNCATE: 999.99 → 999 (just removes .99, no rounding)
- FLOOR: 999.99 → 999 (rounds DOWN)
- CEILING: 999.99 → 1000 (rounds UP)

For 25.50:
- ROUND: 25.50 → 26 (rounds UP because .50 = .5)
- TRUNCATE: 25.50 → 25 (just removes .50)

Use Case: When you need to cut decimals, not round them
*/

-- Example 13: Truncate to different decimal places
SELECT
    product_name,
    price,
    TRUNCATE(price, 2) AS trunc_2_decimals,
    TRUNCATE(price, 1) AS trunc_1_decimal,
    TRUNCATE(price, 0) AS trunc_no_decimals
FROM Products;
/*
Result:
product_name | price  | trunc_2 | trunc_1 | trunc_0
-------------|--------|---------|---------|--------
Laptop       | 999.99 | 999.99  | 999.90  | 999
Mouse        | 25.50  | 25.50   | 25.50   | 25
Keyboard     | 79.95  | 79.95   | 79.90   | 79

Laptop example (999.99):
- TRUNCATE(999.99, 2) → 999.99 (keeps 2 decimals)
- TRUNCATE(999.99, 1) → 999.90 (cuts after 1 decimal, loses .09)
- TRUNCATE(999.99, 0) → 999 (removes all decimals, loses .99)

Use Case: Display precision control, data formatting
*/

-- Example 14: Negative decimals with TRUNCATE
SELECT
    price,
    TRUNCATE(price, -1) AS trunc_tens,
    TRUNCATE(price, -2) AS trunc_hundreds
FROM Products;
/*
Result:
price  | trunc_tens | trunc_hundreds
-------|------------|----------------
999.99 | 990        | 900
25.50  | 20         | 0
79.95  | 70         | 0
299.00 | 290        | 200

Explanation:
- TRUNCATE(999.99, -1): Cuts to tens → 990 (loses 9.99)
- TRUNCATE(999.99, -2): Cuts to hundreds → 900 (loses 99.99)
- TRUNCATE(25.50, -1): Cuts to tens → 20 (loses 5.50)

Use Case: Rough estimates, significant figures
*/

/*
=================================================================
SECTION 2: ABSOLUTE & SIGN FUNCTIONS
=================================================================

2.1 ABS - Absolute Value
━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: ABS(number)
Purpose: Returns absolute value (distance from zero)
  - Removes negative sign if present
  - Positive numbers unchanged
Returns: Non-negative number
*/

-- Example 15: Basic absolute value
SELECT
    employee_name,
    deduction,
    ABS(deduction) AS deduction_amount,
    bonus,
    ABS(bonus) AS bonus_amount
FROM Employees;
/*
Result:
employee_name | deduction | deduction_amount | bonus   | bonus_amount
--------------|-----------|------------------|---------|-------------
John          | -200.25   | 200.25           | 850.50  | 850.50
Mary          | -150.00   | 150.00           | 1200.00 | 1200.00
Bob           | -100.50   | 100.50           | 500.25  | 500.25
Alice         | -250.00   | 250.00           | 1500.00 | 1500.00

Key points:
- ABS(-200.25) → 200.25 (removes negative sign)
- ABS(850.50) → 850.50 (positive unchanged)

Use Case: Display amounts without sign, distance calculations
*/

-- Example 16: Calculate profit/loss magnitude
SELECT
    product_name,
    price,
    cost,
    (price - cost) AS profit,
    ABS(price - cost) AS profit_magnitude,
    CASE
        WHEN (price - cost) >= 0 THEN 'Profit'
        ELSE 'Loss'
    END AS status
FROM Products;
/*
Result:
product_name | price  | cost   | profit  | profit_mag | status
-------------|--------|--------|---------|------------|--------
Laptop       | 999.99 | 750.50 | 249.49  | 249.49     | Profit
Mouse        | 25.50  | 12.30  | 13.20   | 13.20      | Profit
Keyboard     | 79.95  | 45.20  | 34.75   | 34.75      | Profit
Monitor      | 299.00 | 200.00 | 99.00   | 99.00      | Profit

If cost > price (hypothetical loss scenario):
Product | price | cost | profit | profit_mag | status
--------|-------|------|--------|------------|-------
Item X  | 50.00 | 60.00| -10.00 | 10.00      | Loss

Use Case: Financial analysis, variance calculations
*/

-- Example 17: Find difference from target
SELECT
    product_name,
    stock,
    50 AS target_stock,
    (stock - 50) AS difference,
    ABS(stock - 50) AS abs_difference,
    CASE
        WHEN stock > 50 THEN CONCAT('+', (stock - 50))
        WHEN stock < 50 THEN CONCAT('-', (50 - stock))
        ELSE 'At Target'
    END AS variance_display
FROM Products;
/*
Result:
product_name | stock | target | difference | abs_diff | variance
-------------|-------|--------|------------|----------|----------
Laptop       | 45    | 50     | -5         | 5        | -5
Mouse        | 150   | 50     | 100        | 100      | +100
Keyboard     | 80    | 50     | 30         | 30       | +30
Monitor      | 30    | 50     | -20        | 20       | -20
Headphones   | 0     | 50     | -50        | 50       | -50

Use Case: Target tracking, variance analysis, performance metrics
*/

-- Example 18: Calculate temperature difference
SELECT
    'New York' AS city,
    32 AS temp_fahrenheit,
    0 AS freezing_point,
    ABS(32 - 0) AS degrees_from_freezing;
/*
Result:
city     | temp_fahrenheit | freezing_point | degrees_from_freezing
---------|-----------------|----------------|----------------------
New York | 32              | 0              | 32

Another example:
temp = -10°F: ABS(-10 - 0) = ABS(-10) = 10 degrees below freezing
temp = 50°F: ABS(50 - 0) = ABS(50) = 50 degrees above freezing

Use Case: Weather analysis, scientific measurements
*/

/*
2.2 SIGN - Get Sign of Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: SIGN(number)
Purpose: Returns sign indicator
  - Returns -1 if number is negative
  - Returns 0 if number is zero
  - Returns 1 if number is positive
Returns: -1, 0, or 1
*/

-- Example 19: Basic sign detection
SELECT
    employee_name,
    deduction,
    SIGN(deduction) AS deduction_sign,
    bonus,
    SIGN(bonus) AS bonus_sign
FROM Employees;
/*
Result:
employee_name | deduction | deduction_sign | bonus   | bonus_sign
--------------|-----------|----------------|---------|------------
John          | -200.25   | -1             | 850.50  | 1
Mary          | -150.00   | -1             | 1200.00 | 1
Bob           | -100.50   | -1             | 500.25  | 1
Alice         | -250.00   | -1             | 1500.00 | 1

Explanation:
- SIGN(-200.25) → -1 (negative number)
- SIGN(850.50) → 1 (positive number)
- SIGN(0) → 0 (zero)

Use Case: Determining direction, categorizing values
*/

-- Example 20: Categorize profit/loss using SIGN
SELECT
    product_name,
    price,
    cost,
    (price - cost) AS profit,
    SIGN(price - cost) AS profit_sign,
    CASE SIGN(price - cost)
        WHEN 1 THEN 'Profitable'
        WHEN 0 THEN 'Break Even'
        WHEN -1 THEN 'Loss'
    END AS profit_status
FROM Products;
/*
Result:
product_name | price  | cost   | profit | profit_sign | profit_status
-------------|--------|--------|--------|-------------|---------------
Laptop       | 999.99 | 750.50 | 249.49 | 1           | Profitable
Mouse        | 25.50  | 12.30  | 13.20  | 1           | Profitable
Keyboard     | 79.95  | 45.20  | 34.75  | 1           | Profitable

Use Case: Quick categorization, conditional logic
*/

-- Example 21: Compare values using SIGN
SELECT
    product_name,
    stock,
    30 AS reorder_point,
    SIGN(stock - 30) AS comparison,
    CASE SIGN(stock - 30)
        WHEN 1 THEN 'Above Reorder Point'
        WHEN 0 THEN 'At Reorder Point'
        WHEN -1 THEN 'Below Reorder Point - ORDER NOW!'
    END AS stock_status
FROM Products;
/*
Result:
product_name | stock | reorder_pt | comparison | stock_status
-------------|-------|------------|------------|-------------------------
Laptop       | 45    | 30         | 1          | Above Reorder Point
Mouse        | 150   | 30         | 1          | Above Reorder Point
Keyboard     | 80    | 30         | 1          | Above Reorder Point
Monitor      | 30    | 30         | 0          | At Reorder Point
Headphones   | 0     | 30         | -1         | Below Reorder Point - ORDER NOW!

Use Case: Inventory alerts, threshold monitoring
*/

/*
=================================================================
SECTION 3: POWER & ROOT FUNCTIONS
=================================================================

3.1 POWER/POW - Exponentiation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: POWER(base, exponent) or POW(base, exponent)
Purpose: Raises base to the power of exponent
  - POWER(2, 3) = 2^3 = 2 * 2 * 2 = 8
  - POWER(10, 2) = 10^2 = 100
Returns: base raised to exponent
*/

-- Example 22: Basic power calculations
SELECT
    2 AS base,
    3 AS exponent,
    POWER(2, 3) AS result_8,
    POW(2, 3) AS result_8_alt,
    POWER(10, 2) AS ten_squared,
    POWER(5, 0) AS five_to_zero,
    POWER(2, -1) AS two_to_negative_one;
/*
Result:
base | exponent | result_8 | result_8_alt | ten_squared | five_to_zero | two_to_neg_one
-----|----------|----------|--------------|-------------|--------------|----------------
2    | 3        | 8        | 8            | 100         | 1            | 0.5

Calculations:
- POWER(2, 3) = 2³ = 2 * 2 * 2 = 8
- POWER(10, 2) = 10² = 100
- POWER(5, 0) = 5⁰ = 1 (anything to power 0 is 1)
- POWER(2, -1) = 2⁻¹ = 1/2 = 0.5

Use Case: Scientific calculations, growth formulas
*/

-- Example 23: Compound interest calculation
SELECT
    employee_name,
    salary,
    ROUND(salary * POWER(1.05, 3), 2) AS salary_after_3_years_5pct_growth,
    ROUND(salary * POWER(1.10, 5), 2) AS salary_after_5_years_10pct_growth
FROM Employees;
/*
Result:
employee_name | salary  | after_3yrs_5% | after_5yrs_10%
--------------|---------|---------------|----------------
John          | 5500.75 | 6367.12       | 8856.52
Mary          | 6200.00 | 7177.75       | 9982.20
Bob           | 4800.50 | 5557.08       | 7728.51
Alice         | 7500.00 | 8682.19       | 12078.82

Formula: Future Value = Present Value * (1 + rate)^years
John: 5500.75 * (1.05)³ = 5500.75 * 1.157625 = 6367.12

Use Case: Financial projections, compound interest, growth modeling
*/

-- Example 24: Calculate area (square)
SELECT
    product_name,
    stock,
    POWER(stock, 2) AS stock_squared,
    SQRT(POWER(stock, 2)) AS back_to_stock
FROM Products
LIMIT 3;
/*
Result:
product_name | stock | stock_squared | back_to_stock
-------------|-------|---------------|---------------
Laptop       | 45    | 2025          | 45
Mouse        | 150   | 22500         | 150
Keyboard     | 80    | 6400          | 80

Calculations:
- POWER(45, 2) = 45² = 2025
- SQRT(2025) = 45 (square root reverses square)

Use Case: Area calculations, geometric formulas
*/

/*
3.2 SQRT - Square Root
━━━━━━━━━━━━━━━━━━━━━━

Syntax: SQRT(number)
Purpose: Returns square root of number
  - SQRT(9) = 3 (because 3 * 3 = 9)
  - SQRT(16) = 4 (because 4 * 4 = 16)
Returns: Square root
Note: Returns NULL for negative numbers
*/

-- Example 25: Basic square root
SELECT
    4 AS number,
    SQRT(4) AS sqrt_result,
    9 AS number2,
    SQRT(9) AS sqrt_result2,
    100 AS number3,
    SQRT(100) AS sqrt_result3;
/*
Result:
number | sqrt_result | number2 | sqrt_result2 | number3 | sqrt_result3
-------|-------------|---------|--------------|---------|-------------
4      | 2           | 9       | 3            | 100     | 10

Calculations:
- SQRT(4) = 2 (because 2² = 4)
- SQRT(9) = 3 (because 3² = 9)
- SQRT(100) = 10 (because 10² = 100)

Use Case: Geometric calculations, statistical formulas
*/

-- Example 26: Standard deviation calculation (simplified)
SELECT
    'Products' AS category,
    AVG(price) AS avg_price,
    ROUND(SQRT(AVG(POWER(price - (SELECT AVG(price) FROM Products), 2))), 2) AS std_deviation
FROM Products;
/*
Result:
category | avg_price | std_deviation
---------|-----------|---------------
Products | 310.89    | 370.84

Simplified standard deviation formula:
SQRT(AVG((value - mean)²))

Use Case: Statistical analysis, variance measurement
*/

-- Example 27: Calculate distance (Pythagorean theorem)
SELECT
    3 AS side_a,
    4 AS side_b,
    ROUND(SQRT(POWER(3, 2) + POWER(4, 2)), 2) AS hypotenuse;
/*
Result:
side_a | side_b | hypotenuse
-------|--------|------------
3      | 4      | 5.00

Formula: c = √(a² + b²)
c = √(3² + 4²) = √(9 + 16) = √25 = 5

Use Case: Distance calculations, geometric problems
*/

/*
3.3 EXP - Exponential Function
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: EXP(number)
Purpose: Returns e raised to the power of number
  - e ≈ 2.71828 (Euler's number)
  - EXP(x) = e^x
Returns: e to the power of number
*/

-- Example 28: Basic exponential
SELECT
    0 AS input,
    EXP(0) AS exp_0,
    1 AS input2,
    EXP(1) AS exp_1,
    2 AS input3,
    EXP(2) AS exp_2;
/*
Result:
input | exp_0 | input2 | exp_1         | input3 | exp_2
------|-------|--------|---------------|--------|---------------
0     | 1     | 1      | 2.718281828   | 2      | 7.389056099

Calculations:
- EXP(0) = e⁰ = 1
- EXP(1) = e¹ = 2.718281828...
- EXP(2) = e² = 7.389056099...

Use Case: Exponential growth models, scientific calculations
*/

-- Example 29: Exponential growth modeling
SELECT
    employee_name,
    salary,
    ROUND(salary * EXP(0.05 * 3), 2) AS salary_continuous_growth_3yrs
FROM Employees;
/*
Continuous compound growth formula: A = P * e^(rt)
where r = rate, t = time

Use Case: Continuous growth models, population growth
*/

/*
3.4 LN/LOG - Logarithms
━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  LN(number) - Natural logarithm (base e)
  LOG(number) - Natural log in MySQL (base e)
  LOG10(number) - Base-10 logarithm
Purpose: Inverse of exponential function
Returns: Logarithm of number
*/

-- Example 30: Basic logarithms
SELECT
    1 AS number,
    LN(1) AS ln_1,
    EXP(1) AS e,
    LN(EXP(1)) AS ln_e,
    10 AS number2,
    LOG10(10) AS log10_10,
    100 AS number3,
    LOG10(100) AS log10_100;
/*
Result:
number | ln_1 | e         | ln_e | number2 | log10_10 | number3 | log10_100
-------|------|-----------|------|---------|----------|---------|----------
1      | 0    | 2.718282  | 1    | 10      | 1        | 100     | 2

Explanation:
- LN(1) = 0 (because e⁰ = 1)
- LN(e) = 1 (because e¹ = e)
- LOG10(10) = 1 (because 10¹ = 10)
- LOG10(100) = 2 (because 10² = 100)

Use Case: Scientific calculations, logarithmic scales
*/

/*
=================================================================
SECTION 4: TRIGONOMETRIC FUNCTIONS
=================================================================

Brief overview - less commonly used in business applications
*/

-- Example 31: Basic trigonometry
SELECT
    0 AS angle_radians,
    SIN(0) AS sine,
    COS(0) AS cosine,
    TAN(0) AS tangent,
    PI() AS pi_value,
    RADIANS(90) AS ninety_degrees_in_radians,
    SIN(RADIANS(90)) AS sin_90_degrees;
/*
Result:
angle_rad | sine | cosine | tangent | pi_value | ninety_rad | sin_90
----------|------|--------|---------|----------|------------|--------
0         | 0    | 1      | 0       | 3.141593 | 1.570796   | 1

Use Case: Engineering calculations, physics, geometry
*/

/*
=================================================================
SECTION 5: RANDOM FUNCTIONS
=================================================================

5.1 RAND/RANDOM - Generate Random Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: RAND() or RAND(seed)
Purpose: Generates random decimal between 0 and 1
  - RAND() returns different value each call
  - RAND(seed) returns same sequence for same seed
Returns: Random decimal 0 ≤ result < 1
*/

-- Example 32: Basic random number
SELECT
    RAND() AS random_0_to_1,
    ROUND(RAND() * 100, 0) AS random_0_to_100,
    FLOOR(RAND() * 10) + 1 AS random_1_to_10;
/*
Result (example - changes each run):
random_0_to_1      | random_0_to_100 | random_1_to_10
-------------------|-----------------|----------------
0.782641829374     | 78              | 8

Explanation:
- RAND() → 0.782... (random decimal)
- RAND() * 100 → 78.2... → ROUND → 78
- RAND() * 10 → 7.82... → FLOOR → 7 → +1 → 8

Use Case: Random sampling, lottery, games
*/

-- Example 33: Randomly select products
SELECT
    product_name,
    price,
    RAND() AS random_value
FROM Products
ORDER BY RAND()
LIMIT 2;
/*
Result (random selection changes each run):
product_name | price  | random_value
-------------|--------|---------------
Keyboard     | 79.95  | 0.234567
Laptop       | 999.99 | 0.876543

Use Case: Random sampling, A/B testing, featured products
*/

-- Example 34: Generate random discount (5% to 25%)
SELECT
    product_name,
    price,
    ROUND(5 + (RAND() * 20), 1) AS random_discount_pct,
    ROUND(price * (1 - (5 + RAND() * 20) / 100), 2) AS discounted_price
FROM Products;
/*
Result (example):
product_name | price  | random_discount | discounted_price
-------------|--------|-----------------|------------------
Laptop       | 999.99 | 17.3            | 826.99
Mouse        | 25.50  | 8.9             | 23.23

Formula for random in range [min, max]:
min + (RAND() * (max - min))
5 + (RAND() * 20) gives range [5, 25)

Use Case: Flash sales, randomized promotions
*/

/*
=================================================================
SECTION 6: MODULO & DIVISION
=================================================================

6.1 MOD - Modulo (Remainder)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: MOD(dividend, divisor) or dividend % divisor
Purpose: Returns remainder after division
  - MOD(10, 3) = 1 (10 ÷ 3 = 3 remainder 1)
  - MOD(15, 4) = 3 (15 ÷ 4 = 3 remainder 3)
Returns: Remainder (integer)
*/

-- Example 35: Basic modulo
SELECT
    10 AS number,
    3 AS divisor,
    MOD(10, 3) AS remainder,
    10 % 3 AS remainder_alt,
    FLOOR(10 / 3) AS quotient;
/*
Result:
number | divisor | remainder | remainder_alt | quotient
-------|---------|-----------|---------------|----------
10     | 3       | 1         | 1             | 3

Explanation:
10 ÷ 3 = 3 with remainder 1
- Quotient: 3 (how many times 3 goes into 10)
- Remainder: 1 (what's left over)
- 10 = (3 * 3) + 1

Use Case: Even/odd detection, grouping, pagination
*/

-- Example 36: Find even/odd products
SELECT
    product_name,
    stock,
    MOD(stock, 2) AS mod_2,
    CASE
        WHEN MOD(stock, 2) = 0 THEN 'Even'
        ELSE 'Odd'
    END AS even_or_odd
FROM Products;
/*
Result:
product_name | stock | mod_2 | even_or_odd
-------------|-------|-------|-------------
Laptop       | 45    | 1     | Odd
Mouse        | 150   | 0     | Even
Keyboard     | 80    | 0     | Even
Monitor      | 30    | 0     | Even
Headphones   | 0     | 0     | Even

Explanation:
- MOD(45, 2) = 1 (45 ÷ 2 = 22 remainder 1) → Odd
- MOD(150, 2) = 0 (150 ÷ 2 = 75 remainder 0) → Even

Use Case: Alternating row colors, pairing, scheduling
*/

-- Example 37: Group into batches
SELECT
    id,
    product_name,
    FLOOR((id - 1) / 2) + 1 AS batch_number,
    MOD(id - 1, 2) + 1 AS position_in_batch
FROM Products;
/*
Result:
id | product_name | batch_number | position_in_batch
---|--------------|--------------|-------------------
1  | Laptop       | 1            | 1
2  | Mouse        | 1            | 2
3  | Keyboard     | 2            | 1
4  | Monitor      | 2            | 2
5  | Headphones   | 3            | 1

Groups of 2:
- IDs 1-2 → Batch 1
- IDs 3-4 → Batch 2
- ID 5 → Batch 3

Use Case: Batch processing, pagination, grouping
*/

/*
6.2 DIV - Integer Division
━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: dividend DIV divisor (MySQL specific)
Purpose: Performs integer division (discards remainder)
  - 10 DIV 3 = 3 (ignores remainder)
  - 15 DIV 4 = 3 (ignores remainder)
Returns: Integer quotient
Note: MySQL specific; use FLOOR(a/b) in other databases
*/

-- Example 38: Integer division
SELECT
    stock,
    10 AS items_per_box,
    stock DIV 10 AS full_boxes,
    MOD(stock, 10) AS items_remaining
FROM Products;
/*
Result:
stock | items_per_box | full_boxes | items_remaining
------|---------------|------------|----------------
45    | 10            | 4          | 5
150   | 10            | 15         | 0
80    | 10            | 8          | 0
30    | 10            | 3          | 0
0     | 10            | 0          | 0

Explanation:
45 items: 45 DIV 10 = 4 full boxes, MOD(45, 10) = 5 items left

Use Case: Packaging, inventory, resource allocation
*/

/*
=================================================================
SECTION 7: MIN/MAX VALUE FUNCTIONS
=================================================================

7.1 GREATEST - Maximum of Values
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: GREATEST(value1, value2, ..., valueN)
Purpose: Returns largest value from list
Returns: Maximum value
*/

-- Example 39: Find maximum value
SELECT
    product_name,
    price,
    cost,
    discount_pct,
    GREATEST(price, cost, discount_pct) AS max_value
FROM Products;
/*
Result:
product_name | price  | cost   | discount_pct | max_value
-------------|--------|--------|--------------|----------
Laptop       | 999.99 | 750.50 | 15.5         | 999.99
Mouse        | 25.50  | 12.30  | 10.0         | 25.50
Keyboard     | 79.95  | 45.20  | 20.0         | 79.95

Use Case: Finding maximum across columns
*/

-- Example 40: Calculate maximum deduction
SELECT
    employee_name,
    salary,
    bonus,
    ABS(deduction) AS deduction_amt,
    GREATEST(salary, bonus, ABS(deduction)) AS highest_amount
FROM Employees;
/*
Result:
employee_name | salary  | bonus   | deduction_amt | highest_amount
--------------|---------|---------|---------------|----------------
John          | 5500.75 | 850.50  | 200.25        | 5500.75
Mary          | 6200.00 | 1200.00 | 150.00        | 6200.00
Bob           | 4800.50 | 500.25  | 100.50        | 4800.50
Alice         | 7500.00 | 1500.00 | 250.00        | 7500.00

Use Case: Finding peak values, max across columns
*/

/*
7.2 LEAST - Minimum of Values
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: LEAST(value1, value2, ..., valueN)
Purpose: Returns smallest value from list
Returns: Minimum value
*/

-- Example 41: Find minimum value
SELECT
    product_name,
    price,
    cost,
    stock,
    LEAST(price, cost, stock) AS min_value
FROM Products;
/*
Result:
product_name | price  | cost   | stock | min_value
-------------|--------|--------|-------|----------
Laptop       | 999.99 | 750.50 | 45    | 45.00
Mouse        | 25.50  | 12.30  | 150   | 12.30
Keyboard     | 79.95  | 45.20  | 80    | 45.20
Monitor      | 299.00 | 200.00 | 30    | 30.00
Headphones   | 149.99 | 89.99  | 0     | 0.00

Use Case: Finding minimum across columns
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 42: E-commerce Price Calculation
SELECT
    product_name,
    price AS original_price,
    discount_pct,

    -- Calculate discount amount
    ROUND(price * (discount_pct / 100), 2) AS discount_amount,

    -- Calculate final price
    ROUND(price - (price * discount_pct / 100), 2) AS final_price,

    -- Round up for display
    CEILING(price - (price * discount_pct / 100)) AS display_price,

    -- Calculate profit margin
    ROUND(((price - cost) / price) * 100, 1) AS profit_margin_pct
FROM Products;
/*
Result:
product_name | original | discount | discount_amt | final   | display | profit_margin
-------------|----------|----------|--------------|---------|---------|---------------
Laptop       | 999.99   | 15.5     | 155.00       | 845.00  | 845     | 25.0%
Mouse        | 25.50    | 10.0     | 2.55         | 22.95   | 23      | 51.8%
Keyboard     | 79.95    | 20.0     | 15.99        | 63.96   | 64      | 43.5%

Use Case: E-commerce pricing, sales calculations
*/

-- Example 43: Payroll Calculation
SELECT
    employee_name,
    salary,
    bonus,
    deduction,
    hours_worked,

    -- Calculate gross pay
    ROUND(salary + bonus, 2) AS gross_pay,

    -- Calculate net pay
    ROUND(salary + bonus + deduction, 2) AS net_pay,

    -- Calculate hourly rate (assuming 40 hrs/week, 4 weeks/month)
    ROUND(salary / (40 * 4), 2) AS hourly_rate,

    -- Overtime hours (over 40)
    GREATEST(hours_worked - 40, 0) AS overtime_hours,

    -- Overtime pay (1.5x rate)
    ROUND(GREATEST(hours_worked - 40, 0) * (salary / (40 * 4)) * 1.5, 2) AS overtime_pay
FROM Employees;
/*
Result:
employee_name | salary  | bonus   | deduction | hours | gross_pay | net_pay | hourly | overtime_hrs | overtime_pay
--------------|---------|---------|-----------|-------|-----------|---------|--------|--------------|-------------
John          | 5500.75 | 850.50  | -200.25   | 42.5  | 6351.25   | 6151.00 | 34.38  | 2.5          | 128.91
Mary          | 6200.00 | 1200.00 | -150.00   | 40.0  | 7400.00   | 7250.00 | 38.75  | 0            | 0.00
Bob           | 4800.50 | 500.25  | -100.50   | 38.75 | 5300.75   | 5200.25 | 30.00  | 0            | 0.00
Alice         | 7500.00 | 1500.00 | -250.00   | 45.0  | 9000.00   | 8750.00 | 46.88  | 5.0          | 351.56

Use Case: Payroll systems, compensation calculations
*/

-- Example 44: Inventory Reorder Calculation
SELECT
    product_name,
    stock AS current_stock,

    -- Reorder point (30 days of average daily sales, assuming 5/day)
    30 * 5 AS reorder_point,

    -- Days of stock remaining
    FLOOR(stock / 5.0) AS days_remaining,

    -- Units below reorder point
    GREATEST(150 - stock, 0) AS units_to_reorder,

    -- Emergency order flag
    CASE
        WHEN stock < 30 THEN 'URGENT'
        WHEN stock < 100 THEN 'SOON'
        ELSE 'OK'
    END AS reorder_status
FROM Products;
/*
Result:
product_name | current | reorder_pt | days_remain | units_to_order | status
-------------|---------|------------|-------------|----------------|--------
Laptop       | 45      | 150        | 9           | 105            | SOON
Mouse        | 150     | 150        | 30          | 0              | OK
Keyboard     | 80      | 150        | 16          | 70             | SOON
Monitor      | 30      | 150        | 6           | 120            | SOON
Headphones   | 0       | 150        | 0           | 150            | URGENT

Use Case: Inventory management, supply chain planning
*/

-- Example 45: Statistical Analysis
SELECT
    'Price Statistics' AS metric,
    ROUND(AVG(price), 2) AS average,
    ROUND(MIN(price), 2) AS minimum,
    ROUND(MAX(price), 2) AS maximum,
    ROUND(MAX(price) - MIN(price), 2) AS range,
    ROUND(SQRT(AVG(POWER(price - (SELECT AVG(price) FROM Products), 2))), 2) AS std_dev
FROM Products;
/*
Result:
metric             | average | minimum | maximum | range  | std_dev
-------------------|---------|---------|---------|--------|--------
Price Statistics   | 310.89  | 25.50   | 999.99  | 974.49 | 370.84

Use Case: Data analysis, reporting, business intelligence
*/

/*
=================================================================
NUMERIC FUNCTIONS IN WHERE CLAUSE
=================================================================
*/

-- Example 46: Filter by rounded values
SELECT product_name, price
FROM Products
WHERE ROUND(price, 0) > 50;
-- Products with rounded price over $50

-- Example 47: Find products with profit margin over 40%
SELECT product_name, price, cost
FROM Products
WHERE ((price - cost) / price * 100) > 40;
-- High-margin products

-- Example 48: Find even-ID products
SELECT product_name, id
FROM Products
WHERE MOD(id, 2) = 0;
-- Even IDs only

/*
=================================================================
NUMERIC FUNCTIONS IN UPDATE
=================================================================
*/

-- Example 49: Apply calculated price increase
UPDATE Products
SET price = ROUND(price * 1.10, 2)
WHERE category = 'Electronics';
-- 10% price increase, rounded to 2 decimals

-- Example 50: Adjust stock to nearest dozen
UPDATE Products
SET stock = CEILING(stock / 12.0) * 12
WHERE stock > 0;
-- Round up to nearest 12

/*
=================================================================
PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ⚠️ Avoid functions on indexed columns in WHERE
-- ❌ Slow (can't use index):
SELECT * FROM Products WHERE ROUND(price, 0) = 100;

-- ✓ Better (can use index):
SELECT * FROM Products WHERE price BETWEEN 99.50 AND 100.49;

-- ⚠️ Pre-calculate complex expressions
-- ❌ Recalculates for every row:
SELECT product_name,
       ROUND(price * (1 - discount_pct/100) * 1.08, 2) AS final_price
FROM Products;

-- ✓ Better: Use computed/generated columns (MySQL 5.7+)
ALTER TABLE Products
ADD COLUMN final_price DECIMAL(10,2)
GENERATED ALWAYS AS (ROUND(price * (1 - discount_pct/100) * 1.08, 2)) STORED;

/*
=================================================================
DATABASE-SPECIFIC VARIATIONS
=================================================================
*/

-- MySQL:
ROUND(n, d), CEILING(n), FLOOR(n), TRUNCATE(n, d)
ABS(n), SIGN(n), POWER(n, exp), SQRT(n)
MOD(n, m), n DIV m, RAND(), GREATEST(...), LEAST(...)

-- PostgreSQL:
ROUND(n, d), CEIL(n), FLOOR(n), TRUNC(n, d)
ABS(n), SIGN(n), POWER(n, exp), SQRT(n)
MOD(n, m), n / m (integer if both int), RANDOM(), GREATEST(...), LEAST(...)

-- SQL Server:
ROUND(n, d), CEILING(n), FLOOR(n)
ABS(n), SIGN(n), POWER(n, exp), SQRT(n)
n % m, n / m, RAND(), (use CASE for GREATEST/LEAST)

-- Oracle:
ROUND(n, d), CEIL(n), FLOOR(n), TRUNC(n, d)
ABS(n), SIGN(n), POWER(n, exp), SQRT(n)
MOD(n, m), GREATEST(...), LEAST(...)

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: Integer division when you want decimal
SELECT 10 / 3 AS result;  -- Returns 3 (integer division in some DBs)

-- ✓ CORRECT: Force decimal division
SELECT 10.0 / 3 AS result;  -- Returns 3.333...
SELECT CAST(10 AS DECIMAL) / 3 AS result;

-- ❌ MISTAKE 2: Rounding too early
SELECT ROUND(price * discount_pct / 100, 2) AS discount;
-- May lose precision

-- ✓ BETTER: Round at the end
SELECT ROUND(price * discount_pct / 100, 2) AS discount;
-- Same in this case, but be mindful in complex calculations

-- ❌ MISTAKE 3: Using SQRT on negative numbers
SELECT SQRT(-9);  -- Returns NULL (error in some databases)

-- ✓ CORRECT: Check before using
SELECT CASE WHEN value >= 0 THEN SQRT(value) ELSE NULL END;

-- ❌ MISTAKE 4: Division by zero
SELECT price / 0;  -- ERROR!

-- ✓ CORRECT: Check denominator
SELECT CASE WHEN quantity != 0 THEN price / quantity ELSE 0 END;
-- Or use NULLIF:
SELECT price / NULLIF(quantity, 0);  -- Returns NULL if quantity is 0

-- ❌ MISTAKE 5: Assuming ROUND always rounds .5 up
-- Some databases use "banker's rounding" (round to nearest even)
SELECT ROUND(2.5, 0);  -- May return 2 (not 3) in some systems

-- ✓ Be aware: Test rounding behavior in your database

/*
=================================================================
HINGLISH SUMMARY
=================================================================

Numeric functions numbers pe mathematical operations karne ke liye hain.

Main categories:

1. ROUNDING Functions - Numbers ko round karna

   ROUND(999.99, 0) → 1000
   - Nearest value tak round karta hai (.5 aur upar = up)

   CEILING(25.01) → 26
   - Hamesha UPAR round karta hai (next integer)

   FLOOR(25.99) → 25
   - Hamesha NEECHE round karta hai (previous integer)

   TRUNCATE(999.99, 1) → 999.9
   - Bina rounding ke decimal cut kar deta hai

2. ABSOLUTE & SIGN - Positive/negative handle karna

   ABS(-200.25) → 200.25
   - Negative sign hata deta hai (absolute value)

   SIGN(-200) → -1, SIGN(0) → 0, SIGN(200) → 1
   - Number ka sign bata deta hai

3. POWER & ROOT - Exponents aur roots

   POWER(2, 3) → 8 (2³ = 2*2*2)
   - Power/exponentiation calculate karta hai

   SQRT(9) → 3
   - Square root nikalta hai

   EXP(1) → 2.71828 (e¹)
   - Exponential function

4. RANDOM - Random numbers

   RAND() → 0.7826... (0 se 1 ke beech)
   - Random decimal generate karta hai

   FLOOR(RAND() * 10) + 1 → 1 to 10
   - Range mein random integer

5. MODULO & DIVISION

   MOD(10, 3) → 1
   - Division ke baad remainder

   10 DIV 3 → 3
   - Integer division (remainder ignore)

6. MIN/MAX

   GREATEST(10, 20, 5) → 20
   - Sabse bada value

   LEAST(10, 20, 5) → 5
   - Sabse chhota value

Real-world use cases:
- E-commerce: Discounts calculate karna
  final_price = ROUND(price * (1 - discount/100), 2)

- Payroll: Salary calculations
  net_pay = salary + bonus + deduction
  overtime = GREATEST(hours - 40, 0) * rate * 1.5

- Inventory: Reorder calculations
  days_remaining = FLOOR(stock / daily_sales)
  boxes_needed = CEILING(stock / box_size)

- Finance: Interest calculations
  future_value = principal * POWER(1 + rate, years)

- Statistics: Analysis
  std_dev = SQRT(AVG(POWER(value - mean, 2)))

Common patterns:
- Money rounding: ROUND(amount, 2)
- Percentage: ROUND((part / total) * 100, 1)
- Even/Odd check: MOD(number, 2) = 0
- Packing: CEILING(items / box_size)
- Complete sets: FLOOR(items / set_size)

Important notes:
- ROUND: .5 aur upar = up, neeche = down
- CEILING: Hamesha up (even .01 bhi)
- FLOOR: Hamesha down
- TRUNCATE: Cut karta hai, round nahi
- Division by zero = ERROR (check karo!)
- SQRT of negative = NULL/ERROR

Performance tips:
- Functions in WHERE slow hai (index use nahi hota)
- Complex calculations ko pre-calculate karo
- Generated/computed columns use karo jahan possible

Mistakes to avoid:
❌ Integer division jab decimal chahiye (10/3 vs 10.0/3)
❌ Division by zero check na karna
❌ Negative numbers pe SQRT
❌ Bahut jaldi round karna (precision loss)
❌ Indexed columns pe functions (slow queries)

Remember:
- ROUND = nearest, CEILING = up, FLOOR = down
- ABS = remove sign, SIGN = get sign
- POWER = multiply, SQRT = root
- MOD = remainder, DIV = quotient
- Hamesha division by zero check karo
- Money ko 2 decimals tak round karo
- Functions in WHERE avoid karo performance ke liye

KEY TAKEAWAYS:
✓ ROUND for nearest value (banker's rounding in some DBs)
✓ CEILING always rounds up, FLOOR always rounds down
✓ TRUNCATE cuts decimals without rounding
✓ ABS removes negative sign (absolute value)
✓ POWER for exponentiation, SQRT for square root
✓ MOD for remainder, DIV for integer division
✓ RAND for random numbers (0 to 1)
✓ GREATEST/LEAST for min/max across columns
✓ Always check for division by zero
✓ Round money to 2 decimal places
✓ Use CEILING for "at least" calculations
✓ Use FLOOR for "at most" calculations
✓ Avoid functions on indexed columns in WHERE
✓ Pre-calculate complex expressions when possible
✓ Test rounding behavior in your specific database

=================================================================
*/

-- Comprehensive example using multiple numeric functions:
SELECT
    product_name,
    price AS original_price,
    cost,
    discount_pct,
    stock,

    -- Price calculations
    ROUND(price * (discount_pct / 100), 2) AS discount_amount,
    ROUND(price * (1 - discount_pct / 100), 2) AS sale_price,
    CEILING(price * (1 - discount_pct / 100)) AS display_price,

    -- Profit calculations
    ROUND(price - cost, 2) AS profit_per_unit,
    ROUND(((price - cost) / price) * 100, 1) AS profit_margin_pct,
    ABS(ROUND(price - cost, 2)) AS profit_magnitude,

    -- Stock calculations
    FLOOR(stock / 10.0) AS complete_boxes_of_10,
    MOD(stock, 10) AS units_remaining,
    CEILING(stock / 12.0) AS boxes_of_12_needed,

    -- Status indicators
    SIGN(stock - 50) AS stock_vs_target,
    CASE
        WHEN MOD(id, 2) = 0 THEN 'Even ID'
        ELSE 'Odd ID'
    END AS id_parity

FROM Products;
