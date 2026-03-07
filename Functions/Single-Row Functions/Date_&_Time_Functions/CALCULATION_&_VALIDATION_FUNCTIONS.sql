/*
=================================================================
QUERY PURPOSE: Master date/time calculations and validation functions
=================================================================

CONCEPT EXPLANATION (English):
Date and time calculation and validation functions are essential tools
for working with temporal data. They allow you to:
- Calculate differences between dates (age, tenure, days until event)
- Add or subtract time periods (future dates, past dates)
- Validate date formats and values
- Handle time zones and daylight saving
- Perform date arithmetic
- Compare dates and times

These functions are critical for:
- Business logic: Payment due dates, expiration dates, scheduling
- Analytics: Time-series analysis, trend calculations, period comparisons
- Reporting: Age calculations, duration metrics, date ranges
- Data quality: Validating date inputs, checking data integrity
- User experience: Display relative dates ("3 days ago")
- Compliance: Tracking retention periods, audit trails

Categories of Date/Time Functions:

1. CALCULATION Functions
   - DATEDIFF: Calculate difference between dates
   - DATEADD: Add/subtract time intervals (SQL Server)
   - DATE_ADD: Add intervals (MySQL)
   - DATE_SUB: Subtract intervals (MySQL)
   - TIMESTAMPDIFF: Difference in specific units (MySQL)
   - ADDDATE, SUBDATE: MySQL date arithmetic
   - INTERVAL: Time period specification
   - AGE: Calculate age/duration (PostgreSQL)

2. VALIDATION Functions
   - ISDATE: Check if valid date (SQL Server)
   - STR_TO_DATE: Parse and validate (MySQL)
   - TRY_CONVERT: Safe conversion (SQL Server)
   - Constraint checking
   - Range validation
   - Format validation

CONCEPT EXPLANATION (Hinglish):
Date aur time calculation aur validation functions temporal data ke
saath kaam karne ke zaroori tools hain. Yeh aapko allow karte hain:
- Dates ke beech difference calculate karna (age, tenure, days until event)
- Time periods add ya subtract karna (future dates, past dates)
- Date formats aur values validate karna
- Time zones aur daylight saving handle karna
- Date arithmetic perform karna
- Dates aur times compare karna

Yeh functions critical hain:
- Business logic ke liye: Payment due dates, expiration, scheduling
- Analytics ke liye: Time-series analysis, trends, period comparisons
- Reporting ke liye: Age calculations, duration metrics, date ranges
- Data quality ke liye: Date inputs validate karna, integrity check
- User experience ke liye: Relative dates display ("3 days ago")
- Compliance ke liye: Retention periods track karna, audit trails

Date/Time Functions ki categories:

1. CALCULATION Functions
   - DATEDIFF: Dates ke beech difference calculate karna
   - DATEADD: Time intervals add/subtract karna (SQL Server)
   - DATE_ADD: Intervals add karna (MySQL)
   - DATE_SUB: Intervals subtract karna (MySQL)
   - TIMESTAMPDIFF: Specific units mein difference (MySQL)
   - ADDDATE, SUBDATE: MySQL date arithmetic
   - INTERVAL: Time period specification
   - AGE: Age/duration calculate karna (PostgreSQL)

2. VALIDATION Functions
   - ISDATE: Valid date check karna (SQL Server)
   - STR_TO_DATE: Parse aur validate karna (MySQL)
   - TRY_CONVERT: Safe conversion (SQL Server)
   - Constraint checking
   - Range validation
   - Format validation

USE CASES:
- E-commerce: Shipping estimates, delivery tracking, warranty expiration
- HR: Employee age, tenure, probation end dates, leave balances
- Finance: Loan maturity, interest accrual, payment schedules
- Healthcare: Patient age, appointment scheduling, medication schedules
- Education: Semester dates, assignment deadlines, age eligibility
- Subscription: Trial periods, renewal dates, cancellation windows
- Project management: Task duration, deadlines, milestone tracking
- Compliance: Data retention, audit periods, license expiration
- Marketing: Campaign duration, seasonal promotions, event timing
- Inventory: Product age, shelf life, expiration dates

SAMPLE DATA (Employees table):

id | employee_name | hire_date  | birth_date | last_promotion | contract_end | dept
---|---------------|------------|------------|----------------|--------------|--------
1  | Alice Smith   | 2020-03-15 | 1990-07-22 | 2023-01-10     | 2025-03-14   | IT
2  | Bob Johnson   | 2018-11-01 | 1985-02-14 | 2022-11-01     | NULL         | Sales
3  | Carol White   | 2022-06-20 | 1995-09-30 | NULL           | 2024-06-19   | HR
4  | David Brown   | 2019-09-10 | 1988-12-05 | 2023-09-10     | 2026-09-09   | IT
5  | Emma Davis    | 2021-01-05 | 1992-04-18 | 2023-07-01     | 2025-01-04   | Marketing

Additional sample (Orders table):

id | customer_id | order_date | ship_date  | delivery_date | expected_delivery | status
---|-------------|------------|------------|---------------|-------------------|----------
1  | 101         | 2024-03-01 | 2024-03-02 | 2024-03-05    | 2024-03-06        | Delivered
2  | 102         | 2024-03-10 | 2024-03-11 | NULL          | 2024-03-15        | Shipped
3  | 103         | 2024-03-05 | 2024-03-06 | 2024-03-09    | 2024-03-10        | Delivered
4  | 104         | 2024-03-12 | NULL       | NULL          | 2024-03-17        | Processing
5  | 105         | 2024-03-08 | 2024-03-09 | NULL          | 2024-03-14        | Shipped

=================================================================
SECTION 1: DATE DIFFERENCE CALCULATIONS
=================================================================

1.1 DATEDIFF - Calculate Date Difference (MySQL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: DATEDIFF(date1, date2)
Purpose: Returns difference in days between two dates
Returns: Integer (positive or negative)
Formula: date1 - date2
Database: MySQL, MariaDB
*/

-- Example 1: Basic DATEDIFF for age and tenure
SELECT
    employee_name,
    birth_date,
    hire_date,

    -- Days since birth (age in days)
    DATEDIFF(CURDATE(), birth_date) AS days_old,

    -- Age in years (approximate)
    FLOOR(DATEDIFF(CURDATE(), birth_date) / 365.25) AS age_years,

    -- Days employed
    DATEDIFF(CURDATE(), hire_date) AS days_employed,

    -- Tenure in years
    FLOOR(DATEDIFF(CURDATE(), hire_date) / 365.25) AS tenure_years,

    -- More precise tenure (years, months approximation)
    CONCAT(
        FLOOR(DATEDIFF(CURDATE(), hire_date) / 365.25), ' years, ',
        FLOOR((DATEDIFF(CURDATE(), hire_date) % 365.25) / 30), ' months'
    ) AS tenure_formatted
FROM Employees;
/*
Result (assuming current date is 2024-03-15):
employee_name | birth_date | hire_date  | days_old | age_years | days_employed | tenure_years | tenure_formatted
--------------|------------|------------|----------|-----------|---------------|--------------|-------------------
Alice Smith   | 1990-07-22 | 2020-03-15 | 12290    | 33        | 1461          | 4            | 4 years, 0 months
Bob Johnson   | 1985-02-14 | 2018-11-01 | 14274    | 39        | 1961          | 5            | 5 years, 4 months
Carol White   | 1995-09-30 | 2022-06-20 | 10424    | 28        | 634           | 1            | 1 years, 8 months
David Brown   | 1988-12-05 | 2019-09-10 | 12884    | 35        | 1648          | 4            | 4 years, 6 months
Emma Davis    | 1992-04-18 | 2021-01-05 | 11653    | 31        | 1166          | 3            | 3 years, 2 months

Explanation:
- DATEDIFF(CURDATE(), birth_date): Current date minus birth date
- Positive number means date1 is after date2
- Divide by 365.25 to account for leap years
- Use FLOOR to get whole years

Use Case: Age calculations, tenure tracking, time-since metrics
*/

-- Example 2: DATEDIFF for order fulfillment metrics
SELECT
    id,
    order_date,
    ship_date,
    delivery_date,
    expected_delivery,
    status,

    -- Days to ship
    DATEDIFF(ship_date, order_date) AS days_to_ship,

    -- Days to deliver
    DATEDIFF(delivery_date, ship_date) AS days_in_transit,

    -- Total fulfillment time
    DATEDIFF(delivery_date, order_date) AS total_days,

    -- Delivery performance (negative = early, positive = late)
    DATEDIFF(delivery_date, expected_delivery) AS delivery_variance,

    -- Performance label
    CASE
        WHEN delivery_date IS NULL THEN 'Pending'
        WHEN DATEDIFF(delivery_date, expected_delivery) < 0 THEN 'Early'
        WHEN DATEDIFF(delivery_date, expected_delivery) = 0 THEN 'On Time'
        ELSE CONCAT('Late by ', DATEDIFF(delivery_date, expected_delivery), ' days')
    END AS delivery_status
FROM Orders;
/*
Result:
id | order_date | ship_date  | delivery_date | expected_delivery | status     | days_to_ship | days_in_transit | total_days | delivery_variance | delivery_status
---|------------|------------|---------------|-------------------|------------|--------------|-----------------|------------|-------------------|------------------
1  | 2024-03-01 | 2024-03-02 | 2024-03-05    | 2024-03-06        | Delivered  | 1            | 3               | 4          | -1                | Early
2  | 2024-03-10 | 2024-03-11 | NULL          | 2024-03-15        | Shipped    | 1            | NULL            | NULL       | NULL              | Pending
3  | 2024-03-05 | 2024-03-06 | 2024-03-09    | 2024-03-10        | Delivered  | 1            | 3               | 4          | -1                | Early
4  | 2024-03-12 | NULL       | NULL          | 2024-03-17        | Processing | NULL         | NULL            | NULL       | NULL              | Pending
5  | 2024-03-08 | 2024-03-09 | NULL          | 2024-03-14        | Shipped    | 1            | NULL            | NULL       | NULL              | Pending

Explanation:
- DATEDIFF(ship_date, order_date): Days between order and shipment
- Negative variance means early delivery
- NULL results when dates are missing

Use Case: Logistics metrics, SLA tracking, performance monitoring
*/

-- Example 3: DATEDIFF for upcoming/overdue events
SELECT
    employee_name,
    contract_end,

    -- Days until contract ends
    DATEDIFF(contract_end, CURDATE()) AS days_remaining,

    -- Categorize contract status
    CASE
        WHEN contract_end IS NULL THEN 'Permanent'
        WHEN DATEDIFF(contract_end, CURDATE()) < 0 THEN 'EXPIRED'
        WHEN DATEDIFF(contract_end, CURDATE()) <= 30 THEN 'Expiring Soon (< 30 days)'
        WHEN DATEDIFF(contract_end, CURDATE()) <= 90 THEN 'Expiring (< 90 days)'
        ELSE 'Active'
    END AS contract_status,

    -- Readable time remaining
    CASE
        WHEN contract_end IS NULL THEN 'No end date'
        WHEN DATEDIFF(contract_end, CURDATE()) < 0
            THEN CONCAT('Expired ', ABS(DATEDIFF(contract_end, CURDATE())), ' days ago')
        WHEN DATEDIFF(contract_end, CURDATE()) = 0 THEN 'Expires TODAY'
        WHEN DATEDIFF(contract_end, CURDATE()) <= 30
            THEN CONCAT('Expires in ', DATEDIFF(contract_end, CURDATE()), ' days')
        ELSE CONCAT(FLOOR(DATEDIFF(contract_end, CURDATE()) / 30), ' months remaining')
    END AS time_remaining
FROM Employees
ORDER BY
    CASE WHEN contract_end IS NULL THEN 999999 ELSE DATEDIFF(contract_end, CURDATE()) END;
/*
Result (assuming current date is 2024-03-15):
employee_name | contract_end | days_remaining | contract_status         | time_remaining
--------------|--------------|----------------|-------------------------|----------------------
Carol White   | 2024-06-19   | 96             | Expiring (< 90 days)    | 3 months remaining
Emma Davis    | 2025-01-04   | 295            | Active                  | 9 months remaining
Alice Smith   | 2025-03-14   | 364            | Active                  | 12 months remaining
David Brown   | 2026-09-09   | 909            | Active                  | 30 months remaining
Bob Johnson   | NULL         | NULL           | Permanent               | No end date

Use Case: Contract management, expiration tracking, renewal reminders
*/

/*
1.2 TIMESTAMPDIFF - Difference in Specific Units (MySQL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: TIMESTAMPDIFF(unit, datetime1, datetime2)
Purpose: Calculate difference in specific time units
Returns: Integer in specified unit
Units: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
Database: MySQL, MariaDB
*/

-- Example 4: TIMESTAMPDIFF for precise calculations
SELECT
    employee_name,
    birth_date,
    hire_date,

    -- Age in different units
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age_years,
    TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) AS age_months,
    TIMESTAMPDIFF(DAY, birth_date, CURDATE()) AS age_days,

    -- Tenure in different units
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS tenure_years,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS tenure_months,
    TIMESTAMPDIFF(WEEK, hire_date, CURDATE()) AS tenure_weeks,

    -- Precise age breakdown
    CONCAT(
        TIMESTAMPDIFF(YEAR, birth_date, CURDATE()), ' years, ',
        TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) % 12, ' months'
    ) AS age_formatted
FROM Employees;
/*
Result (assuming current date is 2024-03-15):
employee_name | birth_date | hire_date  | age_years | age_months | age_days | tenure_years | tenure_months | tenure_weeks | age_formatted
--------------|------------|------------|-----------|------------|----------|--------------|---------------|--------------|-------------------
Alice Smith   | 1990-07-22 | 2020-03-15 | 33        | 403        | 12290    | 4            | 48            | 208          | 33 years, 7 months
Bob Johnson   | 1985-02-14 | 2018-11-01 | 39        | 469        | 14274    | 5            | 64            | 280          | 39 years, 1 months
Carol White   | 1995-09-30 | 2022-06-20 | 28        | 341        | 10424    | 1            | 20            | 90           | 28 years, 5 months
David Brown   | 1988-12-05 | 2019-09-10 | 35        | 423        | 12884    | 4            | 54            | 235          | 35 years, 3 months
Emma Davis    | 1992-04-18 | 2021-01-05 | 31        | 382        | 11653    | 3            | 38            | 166          | 31 years, 10 months

Explanation:
- TIMESTAMPDIFF(YEAR, ...) gives exact years (not approximate)
- Different units for different precision needs
- More accurate than dividing DATEDIFF result
- Handles month/year variations properly

Use Case: Precise age/tenure, multi-unit displays, accurate metrics
*/

-- Example 5: TIMESTAMPDIFF with time components
SELECT
    id,
    order_date,
    ship_date,

    -- Assume times are included (datetime)
    CONCAT(order_date, ' 09:00:00') AS order_datetime,
    CONCAT(ship_date, ' 17:00:00') AS ship_datetime,

    -- Time to ship in various units
    TIMESTAMPDIFF(HOUR,
        CONCAT(order_date, ' 09:00:00'),
        CONCAT(COALESCE(ship_date, CURDATE()), ' 17:00:00')
    ) AS hours_to_ship,

    TIMESTAMPDIFF(MINUTE,
        CONCAT(order_date, ' 09:00:00'),
        CONCAT(COALESCE(ship_date, CURDATE()), ' 17:00:00')
    ) AS minutes_to_ship
FROM Orders
WHERE ship_date IS NOT NULL
LIMIT 3;
/*
Result:
id | order_date | ship_date  | order_datetime      | ship_datetime       | hours_to_ship | minutes_to_ship
---|------------|------------|---------------------|---------------------|---------------|------------------
1  | 2024-03-01 | 2024-03-02 | 2024-03-01 09:00:00 | 2024-03-02 17:00:00 | 32            | 1920
2  | 2024-03-10 | 2024-03-11 | 2024-03-10 09:00:00 | 2024-03-11 17:00:00 | 32            | 1920
3  | 2024-03-05 | 2024-03-06 | 2024-03-05 09:00:00 | 2024-03-06 17:00:00 | 32            | 1920

Use Case: SLA compliance (hours/minutes), precise timing, shift calculations
*/

/*
=================================================================
SECTION 2: DATE ADDITION/SUBTRACTION
=================================================================

2.1 DATE_ADD and DATE_SUB (MySQL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  DATE_ADD(date, INTERVAL value unit)
  DATE_SUB(date, INTERVAL value unit)
Purpose: Add or subtract time intervals from dates
Units: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
Database: MySQL, MariaDB
*/

-- Example 6: DATE_ADD for future dates
SELECT
    employee_name,
    hire_date,

    -- Future dates
    DATE_ADD(hire_date, INTERVAL 90 DAY) AS probation_end,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS first_anniversary,
    DATE_ADD(hire_date, INTERVAL 5 YEAR) AS five_year_mark,

    -- Contract extensions
    DATE_ADD(CURDATE(), INTERVAL 1 MONTH) AS review_date,
    DATE_ADD(CURDATE(), INTERVAL 6 MONTH) AS next_eval,
    DATE_ADD(CURDATE(), INTERVAL 1 YEAR) AS annual_review,

    -- Multiple units
    DATE_ADD(hire_date, INTERVAL '1-6' YEAR_MONTH) AS plus_1y_6m,
    DATE_ADD(hire_date, INTERVAL '2 3' DAY_HOUR) AS plus_2d_3h
FROM Employees
LIMIT 3;
/*
Result (assuming current date is 2024-03-15):
employee_name | hire_date  | probation_end | first_anniversary | five_year_mark | review_date | next_eval  | annual_review | plus_1y_6m | plus_2d_3h
--------------|------------|---------------|-------------------|----------------|-------------|------------|---------------|------------|--------------------
Alice Smith   | 2020-03-15 | 2020-06-13    | 2021-03-15        | 2025-03-15     | 2024-04-15  | 2024-09-15 | 2025-03-15    | 2021-09-15 | 2020-03-17 03:00:00
Bob Johnson   | 2018-11-01 | 2019-01-30    | 2019-11-01        | 2023-11-01     | 2024-04-15  | 2024-09-15 | 2025-03-15    | 2020-05-01 | 2018-11-03 03:00:00
Carol White   | 2022-06-20 | 2022-09-18    | 2023-06-20        | 2027-06-20     | 2024-04-15  | 2024-09-15 | 2025-03-15    | 2024-12-20 | 2022-06-22 03:00:00

Explanation:
- DATE_ADD adds specified interval to date
- INTERVAL keyword specifies amount and unit
- Can use compound intervals (YEAR_MONTH, DAY_HOUR)
- Results are proper dates (handles month-end, leap years)

Use Case: Scheduling, deadline calculation, expiration dates
*/

-- Example 7: DATE_SUB for past dates and lookback
SELECT
    employee_name,
    hire_date,

    -- Past dates from hire
    DATE_SUB(hire_date, INTERVAL 1 MONTH) AS month_before_hire,
    DATE_SUB(hire_date, INTERVAL 90 DAY) AS 90_days_before,

    -- Lookback periods from today
    DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS last_30_days,
    DATE_SUB(CURDATE(), INTERVAL 90 DAY) AS last_quarter,
    DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AS last_year,

    -- Check if hired in last year
    CASE
        WHEN hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
        THEN 'Recent Hire'
        ELSE 'Tenured'
    END AS hire_recency
FROM Employees;
/*
Result (assuming current date is 2024-03-15):
employee_name | hire_date  | month_before_hire | 90_days_before | last_30_days | last_quarter | last_year  | hire_recency
--------------|------------|-------------------|----------------|--------------|--------------|------------|-------------
Alice Smith   | 2020-03-15 | 2020-02-15        | 2019-12-15     | 2024-02-14   | 2023-12-15   | 2023-03-15 | Tenured
Bob Johnson   | 2018-11-01 | 2018-10-01        | 2018-08-02     | 2024-02-14   | 2023-12-15   | 2023-03-15 | Tenured
Carol White   | 2022-06-20 | 2022-05-20        | 2022-03-22     | 2024-02-14   | 2023-12-15   | 2023-03-15 | Tenured
David Brown   | 2019-09-10 | 2019-08-10        | 2019-06-12     | 2024-02-14   | 2023-12-15   | 2023-03-15 | Tenured
Emma Davis    | 2021-01-05 | 2020-12-05        | 2020-10-07     | 2024-02-14   | 2023-12-15   | 2023-03-15 | Tenured

Use Case: Historical analysis, trend periods, time windows
*/

-- Example 8: Practical shipping date calculation
SELECT
    id,
    order_date,
    status,

    -- Standard shipping (3-5 business days)
    DATE_ADD(order_date, INTERVAL 3 DAY) AS min_delivery,
    DATE_ADD(order_date, INTERVAL 5 DAY) AS max_delivery,

    -- Express shipping (1-2 business days)
    DATE_ADD(order_date, INTERVAL 1 DAY) AS express_min,
    DATE_ADD(order_date, INTERVAL 2 DAY) AS express_max,

    -- International (2-3 weeks)
    DATE_ADD(order_date, INTERVAL 2 WEEK) AS intl_min,
    DATE_ADD(order_date, INTERVAL 3 WEEK) AS intl_max,

    -- Calculate if order is late (comparing expected vs actual delivery)
    CASE
        WHEN delivery_date IS NULL AND CURDATE() > expected_delivery THEN 'OVERDUE'
        WHEN delivery_date > expected_delivery THEN 'Was Late'
        WHEN delivery_date < expected_delivery THEN 'Early'
        WHEN delivery_date = expected_delivery THEN 'On Time'
        ELSE 'In Transit'
    END AS delivery_performance
FROM Orders;
/*
Result:
id | order_date | status     | min_delivery | max_delivery | express_min | express_max | intl_min   | intl_max   | delivery_performance
---|------------|------------|--------------|--------------|-------------|-------------|------------|------------|---------------------
1  | 2024-03-01 | Delivered  | 2024-03-04   | 2024-03-06   | 2024-03-02  | 2024-03-03  | 2024-03-15 | 2024-03-22 | Early
2  | 2024-03-10 | Shipped    | 2024-03-13   | 2024-03-15   | 2024-03-11  | 2024-03-12  | 2024-03-24 | 2024-03-31 | In Transit
3  | 2024-03-05 | Delivered  | 2024-03-08   | 2024-03-10   | 2024-03-06  | 2024-03-07  | 2024-03-19 | 2024-03-26 | Early
4  | 2024-03-12 | Processing | 2024-03-15   | 2024-03-17   | 2024-03-13  | 2024-03-14  | 2024-03-26 | 2024-04-02 | In Transit
5  | 2024-03-08 | Shipped    | 2024-03-11   | 2024-03-13   | 2024-03-09  | 2024-03-10  | 2024-03-22 | 2024-03-29 | In Transit

Use Case: Shipping estimates, delivery windows, SLA calculations
*/

/*
2.2 ADDDATE and SUBDATE (MySQL Shortcuts)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  ADDDATE(date, INTERVAL value unit) - same as DATE_ADD
  ADDDATE(date, days) - adds days (shortcut)
  SUBDATE(date, INTERVAL value unit) - same as DATE_SUB
  SUBDATE(date, days) - subtracts days (shortcut)
*/

-- Example 9: ADDDATE/SUBDATE shortcuts
SELECT
    employee_name,
    hire_date,

    -- Add days (simple syntax)
    ADDDATE(hire_date, 90) AS plus_90_days,
    ADDDATE(hire_date, 365) AS plus_1_year,

    -- Subtract days
    SUBDATE(hire_date, 30) AS minus_30_days,

    -- With INTERVAL (same as DATE_ADD/DATE_SUB)
    ADDDATE(hire_date, INTERVAL 6 MONTH) AS plus_6_months,
    SUBDATE(hire_date, INTERVAL 1 YEAR) AS minus_1_year
FROM Employees
LIMIT 3;
/*
Result:
employee_name | hire_date  | plus_90_days | plus_1_year | minus_30_days | plus_6_months | minus_1_year
--------------|------------|--------------|-------------|---------------|---------------|-------------
Alice Smith   | 2020-03-15 | 2020-06-13   | 2021-03-15  | 2020-02-14    | 2020-09-15    | 2019-03-15
Bob Johnson   | 2018-11-01 | 2019-01-30   | 2019-11-01  | 2018-10-02    | 2019-05-01    | 2017-11-01
Carol White   | 2022-06-20 | 2022-09-18   | 2023-06-20  | 2022-05-21    | 2022-12-20    | 2021-06-20

Use Case: Quick day arithmetic, readable code for common operations
*/

/*
2.3 Adding/Subtracting with INTERVAL operator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: date + INTERVAL value unit, date - INTERVAL value unit
Purpose: Direct date arithmetic using + and - operators
*/

-- Example 10: Direct INTERVAL arithmetic
SELECT
    employee_name,
    hire_date,

    -- Addition with +
    hire_date + INTERVAL 90 DAY AS probation_end,
    hire_date + INTERVAL 1 YEAR AS first_year,
    hire_date + INTERVAL 6 MONTH AS six_months,

    -- Subtraction with -
    hire_date - INTERVAL 1 MONTH AS month_before,

    -- Current date arithmetic
    CURDATE() + INTERVAL 30 DAY AS future_30_days,
    CURDATE() - INTERVAL 90 DAY AS past_90_days,

    -- Multiple operations
    (hire_date + INTERVAL 1 YEAR) + INTERVAL 6 MONTH AS year_and_half
FROM Employees
LIMIT 3;
/*
Result:
employee_name | hire_date  | probation_end | first_year | six_months | month_before | future_30_days | past_90_days | year_and_half
--------------|------------|---------------|------------|------------|--------------|----------------|--------------|---------------
Alice Smith   | 2020-03-15 | 2020-06-13    | 2021-03-15 | 2020-09-15 | 2020-02-15   | 2024-04-14     | 2023-12-15   | 2021-09-15
Bob Johnson   | 2018-11-01 | 2019-01-30    | 2019-11-01 | 2019-05-01 | 2018-10-01   | 2024-04-14     | 2023-12-15   | 2020-05-01
Carol White   | 2022-06-20 | 2022-09-18    | 2023-06-20 | 2022-12-20 | 2022-05-20   | 2024-04-14     | 2023-12-15   | 2024-12-20

Explanation:
- Cleaner syntax than DATE_ADD/DATE_SUB
- Can chain operations
- Mathematically intuitive

Use Case: Date calculations, scheduling, projections
*/

/*
=================================================================
SECTION 3: COMBINING CALCULATIONS FOR BUSINESS LOGIC
=================================================================
*/

-- Example 11: Employee milestone tracking
SELECT
    employee_name,
    hire_date,
    birth_date,

    -- Current metrics
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS current_tenure_years,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS current_age,

    -- Upcoming milestones
    hire_date + INTERVAL (TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1) YEAR AS next_anniversary,
    birth_date + INTERVAL (TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) + 1) YEAR AS next_birthday,

    -- Days until milestones
    DATEDIFF(
        hire_date + INTERVAL (TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1) YEAR,
        CURDATE()
    ) AS days_to_anniversary,

    DATEDIFF(
        birth_date + INTERVAL (TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) + 1) YEAR,
        CURDATE()
    ) AS days_to_birthday,

    -- Milestone detection
    CASE
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) IN (5, 10, 15, 20, 25)
            THEN CONCAT(TIMESTAMPDIFF(YEAR, hire_date, CURDATE()), ' Year Service Award!')
        ELSE NULL
    END AS service_milestone
FROM Employees;
/*
Result (assuming current date is 2024-03-15):
employee_name | hire_date  | birth_date | current_tenure_years | current_age | next_anniversary | next_birthday | days_to_anniversary | days_to_birthday | service_milestone
--------------|------------|------------|----------------------|-------------|------------------|---------------|---------------------|------------------|---------------------
Alice Smith   | 2020-03-15 | 1990-07-22 | 4                    | 33          | 2025-03-15       | 2024-07-22    | 365                 | 129              | NULL
Bob Johnson   | 2018-11-01 | 1985-02-14 | 5                    | 39          | 2024-11-01       | 2025-02-14    | 231                 | 336              | 5 Year Service Award!
Carol White   | 2022-06-20 | 1995-09-30 | 1                    | 28          | 2024-06-20       | 2024-09-30    | 97                  | 199              | NULL
David Brown   | 2019-09-10 | 1988-12-05 | 4                    | 35          | 2024-09-10       | 2024-12-05    | 179                 | 265              | NULL
Emma Davis    | 2021-01-05 | 1992-04-18 | 3                    | 31          | 2025-01-05       | 2024-04-18    | 296                 | 34               | NULL

Use Case: HR dashboards, recognition programs, celebration planning
*/

-- Example 12: Comprehensive order lifecycle analysis
SELECT
    id,
    order_date,
    ship_date,
    delivery_date,
    expected_delivery,
    status,

    -- Processing metrics
    DATEDIFF(COALESCE(ship_date, CURDATE()), order_date) AS processing_days,
    DATEDIFF(COALESCE(delivery_date, CURDATE()), COALESCE(ship_date, order_date)) AS transit_days,
    DATEDIFF(COALESCE(delivery_date, CURDATE()), order_date) AS total_days,

    -- Performance vs expected
    CASE
        WHEN delivery_date IS NOT NULL THEN
            DATEDIFF(delivery_date, expected_delivery)
        ELSE
            DATEDIFF(CURDATE(), expected_delivery)
    END AS days_variance,

    -- Status indicators
    CASE
        WHEN status = 'Delivered' AND delivery_date <= expected_delivery THEN '✓ On Time'
        WHEN status = 'Delivered' AND delivery_date > expected_delivery THEN '⚠ Late'
        WHEN status IN ('Shipped', 'Processing') AND CURDATE() > expected_delivery THEN '🚨 OVERDUE'
        WHEN status IN ('Shipped', 'Processing') AND DATEDIFF(expected_delivery, CURDATE()) <= 2 THEN '⏰ Due Soon'
        ELSE '→ On Track'
    END AS delivery_status,

    -- Estimated completion (for pending orders)
    CASE
        WHEN status = 'Processing' THEN order_date + INTERVAL 5 DAY
        WHEN status = 'Shipped' THEN ship_date + INTERVAL 3 DAY
        ELSE delivery_date
    END AS estimated_completion,

    -- Days until expected delivery (for pending)
    CASE
        WHEN delivery_date IS NULL THEN DATEDIFF(expected_delivery, CURDATE())
        ELSE NULL
    END AS days_until_expected
FROM Orders;
/*
Result (assuming current date is 2024-03-15):
id | order_date | ship_date  | delivery_date | expected_delivery | status     | processing_days | transit_days | total_days | days_variance | delivery_status | estimated_completion | days_until_expected
---|------------|------------|---------------|-------------------|------------|-----------------|--------------|------------|---------------|-----------------|----------------------|--------------------
1  | 2024-03-01 | 2024-03-02 | 2024-03-05    | 2024-03-06        | Delivered  | 1               | 3            | 4          | -1            | ✓ On Time       | 2024-03-05           | NULL
2  | 2024-03-10 | 2024-03-11 | NULL          | 2024-03-15        | Shipped    | 1               | 4            | 5          | 0             | → On Track      | 2024-03-14           | 0
3  | 2024-03-05 | 2024-03-06 | 2024-03-09    | 2024-03-10        | Delivered  | 1               | 3            | 4          | -1            | ✓ On Time       | 2024-03-09           | NULL
4  | 2024-03-12 | NULL       | NULL          | 2024-03-17        | Processing | 3               | 3            | 3          | -2            | → On Track      | 2024-03-17           | 2
5  | 2024-03-08 | 2024-03-09 | NULL          | 2024-03-14        | Shipped    | 1               | 6            | 7          | 1             | 🚨 OVERDUE      | 2024-03-12           | -1

Use Case: Operations dashboards, SLA monitoring, customer service
*/

/*
=================================================================
SECTION 4: DATE VALIDATION
=================================================================

4.1 Date Format Validation with STR_TO_DATE (MySQL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: STR_TO_DATE(string, format)
Purpose: Parse string as date; returns NULL if invalid
Returns: DATE if valid, NULL if invalid
*/

-- Example 13: Validate date strings
SELECT
    'Valid Dates' AS test_category,
    STR_TO_DATE('2024-03-15', '%Y-%m-%d') AS iso_format,
    STR_TO_DATE('03/15/2024', '%m/%d/%Y') AS us_format,
    STR_TO_DATE('15-03-2024', '%d-%m-%Y') AS euro_format,
    STR_TO_DATE('March 15, 2024', '%M %d, %Y') AS text_format

UNION ALL

SELECT
    'Invalid Dates' AS test_category,
    STR_TO_DATE('2024-13-01', '%Y-%m-%d') AS invalid_month,
    STR_TO_DATE('2024-02-30', '%Y-%m-%d') AS invalid_day,
    STR_TO_DATE('not a date', '%Y-%m-%d') AS invalid_string,
    STR_TO_DATE('', '%Y-%m-%d') AS empty_string;
/*
Result:
test_category | iso_format | us_format  | euro_format | text_format
--------------|------------|------------|-------------|-------------
Valid Dates   | 2024-03-15 | 2024-03-15 | 2024-03-15  | 2024-03-15
Invalid Dates | NULL       | NULL       | NULL        | NULL

Explanation:
- STR_TO_DATE returns NULL for invalid dates
- Month 13 doesn't exist → NULL
- Feb 30 doesn't exist → NULL
- Non-date strings → NULL
- Use this for validation before inserting data

Use Case: Data validation, import checking, user input verification
*/

-- Example 14: Validation in queries
CREATE TEMPORARY TABLE DateInputs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_input VARCHAR(50),
    expected_format VARCHAR(20)
);

INSERT INTO DateInputs (user_input, expected_format) VALUES
('2024-03-15', 'YYYY-MM-DD'),
('03/15/2024', 'MM/DD/YYYY'),
('2024-13-01', 'YYYY-MM-DD'),  -- Invalid month
('2024-02-30', 'YYYY-MM-DD'),  -- Invalid day
('15-Mar-2024', 'DD-Mon-YYYY'),
('not a date', 'YYYY-MM-DD');

SELECT
    id,
    user_input,
    expected_format,

    -- Attempt to parse
    STR_TO_DATE(user_input, '%Y-%m-%d') AS parsed_date,

    -- Validation result
    CASE
        WHEN STR_TO_DATE(user_input, '%Y-%m-%d') IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS validation_status,

    -- Error message
    CASE
        WHEN STR_TO_DATE(user_input, '%Y-%m-%d') IS NULL
            THEN CONCAT('Cannot parse "', user_input, '" as date')
        ELSE 'OK'
    END AS error_message
FROM DateInputs;
/*
Result:
id | user_input  | expected_format | parsed_date | validation_status | error_message
---|-------------|-----------------|-------------|-------------------|-----------------------------------
1  | 2024-03-15  | YYYY-MM-DD      | 2024-03-15  | Valid             | OK
2  | 03/15/2024  | MM/DD/YYYY      | NULL        | Invalid           | Cannot parse "03/15/2024" as date
3  | 2024-13-01  | YYYY-MM-DD      | NULL        | Invalid           | Cannot parse "2024-13-01" as date
4  | 2024-02-30  | YYYY-MM-DD      | NULL        | Invalid           | Cannot parse "2024-02-30" as date
5  | 15-Mar-2024 | DD-Mon-YYYY     | NULL        | Invalid           | Cannot parse "15-Mar-2024" as date
6  | not a date  | YYYY-MM-DD      | NULL        | Invalid           | Cannot parse "not a date" as date

Use Case: Form validation, data quality checks, ETL processes
*/

DROP TEMPORARY TABLE DateInputs;

/*
4.2 Range Validation
━━━━━━━━━━━━━━━━━━━

Validate dates are within acceptable ranges
*/

-- Example 15: Date range validation
SELECT
    employee_name,
    birth_date,
    hire_date,

    -- Age validation (18-70 years old at hire)
    TIMESTAMPDIFF(YEAR, birth_date, hire_date) AS age_at_hire,

    CASE
        WHEN TIMESTAMPDIFF(YEAR, birth_date, hire_date) < 18
            THEN '❌ Too young at hire'
        WHEN TIMESTAMPDIFF(YEAR, birth_date, hire_date) > 70
            THEN '❌ Too old at hire'
        ELSE '✓ Valid age'
    END AS age_validation,

    -- Birth date range validation (born 1940-2010)
    CASE
        WHEN YEAR(birth_date) < 1940 THEN '❌ Birth year too early'
        WHEN YEAR(birth_date) > 2010 THEN '❌ Birth year too recent'
        ELSE '✓ Valid birth year'
    END AS birth_year_validation,

    -- Hire date validation (not in future, not before 2000)
    CASE
        WHEN hire_date > CURDATE() THEN '❌ Hire date in future'
        WHEN YEAR(hire_date) < 2000 THEN '⚠ Very old hire date'
        ELSE '✓ Valid hire date'
    END AS hire_date_validation,

    -- Logical validation (hire after birth)
    CASE
        WHEN hire_date < birth_date THEN '❌ Hired before born!'
        ELSE '✓ Chronologically valid'
    END AS chronology_validation
FROM Employees;
/*
Result:
employee_name | birth_date | hire_date  | age_at_hire | age_validation | birth_year_validation | hire_date_validation | chronology_validation
--------------|------------|------------|-------------|----------------|----------------------|----------------------|----------------------
Alice Smith   | 1990-07-22 | 2020-03-15 | 29          | ✓ Valid age    | ✓ Valid birth year   | ✓ Valid hire date    | ✓ Chronologically valid
Bob Johnson   | 1985-02-14 | 2018-11-01 | 33          | ✓ Valid age    | ✓ Valid birth year   | ✓ Valid hire date    | ✓ Chronologically valid
Carol White   | 1995-09-30 | 2022-06-20 | 26          | ✓ Valid age    | ✓ Valid birth year   | ✓ Valid hire date    | ✓ Chronologically valid
David Brown   | 1988-12-05 | 2019-09-10 | 30          | ✓ Valid age    | ✓ Valid birth year   | ✓ Valid hire date    | ✓ Chronologically valid
Emma Davis    | 1992-04-18 | 2021-01-05 | 28          | ✓ Valid age    | ✓ Valid birth year   | ✓ Valid hire date    | ✓ Chronologically valid

Use Case: Data quality checks, compliance validation, business rules
*/

/*
4.3 Business Day Validation
━━━━━━━━━━━━━━━━━━━━━━━━━

Check if dates fall on weekdays/weekends
*/

-- Example 16: Weekend/weekday validation
SELECT
    id,
    order_date,
    ship_date,

    -- Day of week (1=Sunday, 7=Saturday)
    DAYOFWEEK(order_date) AS order_dow,
    DAYNAME(order_date) AS order_day_name,

    -- Weekend check
    CASE
        WHEN DAYOFWEEK(order_date) IN (1, 7) THEN '⚠ Weekend Order'
        ELSE '✓ Weekday Order'
    END AS order_day_type,

    -- Validate ship date is weekday
    CASE
        WHEN ship_date IS NULL THEN 'Not yet shipped'
        WHEN DAYOFWEEK(ship_date) IN (1, 7) THEN '❌ Shipped on weekend!'
        ELSE '✓ Shipped on weekday'
    END AS ship_day_validation,

    -- Next business day (if ordered on weekend)
    CASE
        WHEN DAYOFWEEK(order_date) = 1 THEN order_date + INTERVAL 1 DAY  -- Sunday -> Monday
        WHEN DAYOFWEEK(order_date) = 7 THEN order_date + INTERVAL 2 DAY  -- Saturday -> Monday
        ELSE order_date
    END AS next_business_day
FROM Orders;
/*
Result:
id | order_date | ship_date  | order_dow | order_day_name | order_day_type  | ship_day_validation  | next_business_day
---|------------|------------|-----------|----------------|-----------------|----------------------|-------------------
1  | 2024-03-01 | 2024-03-02 | 6         | Friday         | ✓ Weekday Order | ✓ Shipped on weekday | 2024-03-01
2  | 2024-03-10 | 2024-03-11 | 1         | Sunday         | ⚠ Weekend Order | ✓ Shipped on weekday | 2024-03-11
3  | 2024-03-05 | 2024-03-06 | 3         | Tuesday        | ✓ Weekday Order | ✓ Shipped on weekday | 2024-03-05
4  | 2024-03-12 | NULL       | 3         | Tuesday        | ✓ Weekday Order | Not yet shipped      | 2024-03-12
5  | 2024-03-08 | 2024-03-09 | 6         | Friday         | ✓ Weekday Order | ✓ Shipped on weekday | 2024-03-08

Use Case: Business hours validation, SLA calculations, scheduling
*/

/*
=================================================================
SECTION 5: SQL SERVER SPECIFIC FUNCTIONS
=================================================================

Note: These examples show SQL Server syntax for reference
MySQL equivalents are shown in comments
*/

-- Example 17: DATEADD (SQL Server) vs DATE_ADD (MySQL)
/*
-- SQL Server:
SELECT
    hire_date,
    DATEADD(DAY, 90, hire_date) AS plus_90_days,
    DATEADD(MONTH, 6, hire_date) AS plus_6_months,
    DATEADD(YEAR, 1, hire_date) AS plus_1_year
FROM Employees;

-- MySQL equivalent:
*/
SELECT
    hire_date,
    DATE_ADD(hire_date, INTERVAL 90 DAY) AS plus_90_days,
    DATE_ADD(hire_date, INTERVAL 6 MONTH) AS plus_6_months,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS plus_1_year
FROM Employees
LIMIT 2;

-- Example 18: DATEDIFF variations
/*
-- SQL Server DATEDIFF (returns int, different units):
SELECT
    DATEDIFF(DAY, hire_date, GETDATE()) AS days_diff,
    DATEDIFF(MONTH, hire_date, GETDATE()) AS months_diff,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS years_diff
FROM Employees;

-- MySQL DATEDIFF (returns days only):
*/
SELECT
    employee_name,
    DATEDIFF(CURDATE(), hire_date) AS days_diff,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS months_diff,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_diff
FROM Employees
LIMIT 2;

-- Example 19: ISDATE (SQL Server) vs STR_TO_DATE (MySQL)
/*
-- SQL Server ISDATE:
SELECT
    ISDATE('2024-03-15') AS valid_date,    -- Returns 1
    ISDATE('2024-13-01') AS invalid_date,  -- Returns 0
    ISDATE('not a date') AS invalid_string -- Returns 0

-- MySQL equivalent using STR_TO_DATE:
*/
SELECT
    STR_TO_DATE('2024-03-15', '%Y-%m-%d') IS NOT NULL AS valid_date,
    STR_TO_DATE('2024-13-01', '%Y-%m-%d') IS NOT NULL AS invalid_date,
    STR_TO_DATE('not a date', '%Y-%m-%d') IS NOT NULL AS invalid_string;
/*
Result:
valid_date | invalid_date | invalid_string
-----------|--------------|----------------
1          | 0            | 0
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLE
=================================================================
*/

-- Example 20: Complete Employee Analytics Dashboard
SELECT
    employee_name,
    birth_date,
    hire_date,
    last_promotion,
    contract_end,
    dept,

    -- === AGE CALCULATIONS ===
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS current_age,
    DATE_FORMAT(birth_date, '%M %d') AS birthday,
    DATEDIFF(
        birth_date + INTERVAL (TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) + 1) YEAR,
        CURDATE()
    ) AS days_to_birthday,

    -- === TENURE CALCULATIONS ===
    CONCAT(
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()), ' years, ',
        TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12, ' months'
    ) AS tenure,

    DATE_FORMAT(hire_date, '%M %d') AS hire_anniversary,
    DATEDIFF(
        hire_date + INTERVAL (TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1) YEAR,
        CURDATE()
    ) AS days_to_anniversary,

    -- === PROMOTION TRACKING ===
    TIMESTAMPDIFF(MONTH, last_promotion, CURDATE()) AS months_since_promotion,

    CASE
        WHEN last_promotion IS NULL THEN 'Never promoted'
        WHEN TIMESTAMPDIFF(MONTH, last_promotion, CURDATE()) >= 24 THEN 'Due for review'
        ELSE CONCAT('Last promoted ', TIMESTAMPDIFF(MONTH, last_promotion, CURDATE()), ' months ago')
    END AS promotion_status,

    -- === CONTRACT MANAGEMENT ===
    CASE
        WHEN contract_end IS NULL THEN 'Permanent'
        ELSE CONCAT(DATEDIFF(contract_end, CURDATE()), ' days remaining')
    END AS contract_remaining,

    CASE
        WHEN contract_end IS NULL THEN 'N/A'
        WHEN DATEDIFF(contract_end, CURDATE()) < 0 THEN '🚨 EXPIRED'
        WHEN DATEDIFF(contract_end, CURDATE()) <= 30 THEN '⚠ Renew urgently'
        WHEN DATEDIFF(contract_end, CURDATE()) <= 90 THEN '⏰ Renew soon'
        ELSE '✓ Active'
    END AS contract_alert,

    -- === UPCOMING MILESTONES ===
    CASE
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1 IN (5, 10, 15, 20, 25, 30)
            THEN CONCAT((TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1), '-year anniversary in ',
                       DATEDIFF(hire_date + INTERVAL (TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 1) YEAR, CURDATE()),
                       ' days')
        ELSE NULL
    END AS upcoming_milestone,

    -- === RETIREMENT PLANNING ===
    CASE
        WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) >= 62 THEN 'Eligible for retirement'
        WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) >= 58 THEN 'Pre-retirement planning'
        ELSE CONCAT('Retirement in ', 62 - TIMESTAMPDIFF(YEAR, birth_date, CURDATE()), ' years')
    END AS retirement_status,

    -- === VALIDATION ===
    CASE
        WHEN hire_date < birth_date + INTERVAL 16 YEAR THEN '❌ Hired too young'
        WHEN hire_date > CURDATE() THEN '❌ Future hire date'
        WHEN contract_end IS NOT NULL AND contract_end < hire_date THEN '❌ Contract ends before hire'
        ELSE '✓ Valid'
    END AS data_validation

FROM Employees
ORDER BY
    CASE
        WHEN contract_end IS NOT NULL AND DATEDIFF(contract_end, CURDATE()) <= 30 THEN 1
        ELSE 2
    END,
    days_to_anniversary;
/*
Comprehensive employee dashboard with all date calculations

Use Case: HR dashboards, employee management, compliance tracking
*/

/*
=================================================================
COMMON MISTAKES AND BEST PRACTICES
=================================================================
*/

-- ❌ MISTAKE 1: Not handling NULL dates
SELECT DATEDIFF(contract_end, hire_date) FROM Employees;  -- Returns NULL if contract_end is NULL

-- ✓ CORRECT: Handle NULL explicitly
SELECT DATEDIFF(COALESCE(contract_end, CURDATE()), hire_date) FROM Employees;

-- ❌ MISTAKE 2: Integer division for age
SELECT DATEDIFF(CURDATE(), birth_date) / 365 AS age;  -- Not accurate (leap years)

-- ✓ CORRECT: Use TIMESTAMPDIFF for years
SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age FROM Employees;

-- ❌ MISTAKE 3: Comparing dates with different formats
SELECT * FROM Employees WHERE hire_date = '03/15/2020';  -- May not work

-- ✓ CORRECT: Use ISO format
SELECT * FROM Employees WHERE hire_date = '2020-03-15';

-- ❌ MISTAKE 4: Not considering time component
SELECT * FROM Orders WHERE order_date = '2024-03-15';
-- Won't match '2024-03-15 14:30:00'

-- ✓ CORRECT: Use DATE() function or range
SELECT * FROM Orders WHERE DATE(order_date) = '2024-03-15';
-- Or:
SELECT * FROM Orders WHERE order_date >= '2024-03-15' AND order_date < '2024-03-16';

/*
=================================================================
HINGLISH SUMMARY
=================================================================

Date/Time calculations aur validation functions temporal data ke saath
kaam karne ke essential tools hain.

1. DATE DIFFERENCE - Dates ke beech difference

   DATEDIFF(date1, date2) - MySQL
   - Days mein difference
   - DATEDIFF(CURDATE(), birth_date) → age in days
   - Positive = date1 after date2

   TIMESTAMPDIFF(unit, date1, date2) - MySQL
   - Specific units mein: YEAR, MONTH, DAY, HOUR, etc.
   - TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) → exact age
   - Leap years handle karta hai

2. DATE ADDITION/SUBTRACTION - Dates add/subtract karna

   DATE_ADD(date, INTERVAL value unit) - MySQL
   - DATE_ADD(hire_date, INTERVAL 90 DAY) → 90 days baad
   - DATE_ADD(hire_date, INTERVAL 1 YEAR) → 1 year baad

   DATE_SUB(date, INTERVAL value unit) - MySQL
   - DATE_SUB(CURDATE(), INTERVAL 30 DAY) → 30 days pehle

   Direct operators:
   - hire_date + INTERVAL 6 MONTH
   - hire_date - INTERVAL 1 YEAR

3. VALIDATION - Dates validate karna

   STR_TO_DATE(string, format) - MySQL
   - String ko date mein parse kare
   - Invalid dates → NULL return
   - STR_TO_DATE('2024-13-01', '%Y-%m-%d') → NULL (invalid month)

   Range validation:
   - Age checks: TIMESTAMPDIFF(YEAR, birth, hire) BETWEEN 18 AND 70
   - Future dates: hire_date <= CURDATE()
   - Logical: hire_date >= birth_date

Real-world use cases:

Age calculation:
TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age

Tenure:
CONCAT(
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()), ' years, ',
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12, ' months'
)

Days until event:
DATEDIFF(event_date, CURDATE()) AS days_remaining

Expiration checking:
CASE
    WHEN contract_end < CURDATE() THEN 'Expired'
    WHEN DATEDIFF(contract_end, CURDATE()) <= 30 THEN 'Expiring Soon'
    ELSE 'Active'
END

Future date:
hire_date + INTERVAL 90 DAY AS probation_end

Past period:
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)

Database differences:
- MySQL: DATEDIFF (days only), TIMESTAMPDIFF, DATE_ADD, DATE_SUB
- SQL Server: DATEDIFF (any unit), DATEADD, ISDATE
- PostgreSQL: AGE, EXTRACT, date + INTERVAL
- Oracle: MONTHS_BETWEEN, ADD_MONTHS

Common patterns:
- Age: TIMESTAMPDIFF(YEAR, birth, CURDATE())
- Tenure: TIMESTAMPDIFF(MONTH, hire, CURDATE())
- Days remaining: DATEDIFF(end_date, CURDATE())
- Future dates: date + INTERVAL n UNIT
- Past dates: date - INTERVAL n UNIT
- Validation: STR_TO_DATE(...) IS NOT NULL

Common mistakes:
❌ DATEDIFF/365 for years (leap years ignored)
❌ NULL dates unhandled
❌ Wrong date format in comparisons
❌ Time component ignored in date comparisons
❌ Using = for date ranges instead of >=,

Best practices:
✓ Use TIMESTAMPDIFF for accurate year/month calculations
✓ Handle NULL dates with COALESCE
✓ Use ISO format (YYYY-MM-DD) for consistency
✓ Use DATE() function or ranges for date comparisons
✓ Validate dates before storing
✓ Consider leap years in calculations
✓ Use business day logic where needed
✓ Test edge cases (month-end, leap years, etc.)

Performance tips:
✓ Functions on columns prevent index usage
✓ Better: WHERE date >= '2024-01-01' AND date < '2024-02-01'
✓ Avoid: WHERE YEAR(date) = 2024
✓ Pre-calculate frequently used date ranges

Remember:
- DATEDIFF for days (MySQL)
- TIMESTAMPDIFF for any unit (more accurate)
- DATE_ADD/DATE_SUB or + INTERVAL for arithmetic
- STR_TO_DATE for validation (returns NULL if invalid)
- Handle NULLs explicitly
- Use ISO date format
- Test edge cases
- Consider time zones if needed

KEY TAKEAWAYS:
✓ DATEDIFF calculates days between dates
✓ TIMESTAMPDIFF for accurate year/month/day differences
✓ DATE_ADD/DATE_SUB for date arithmetic
✓ + INTERVAL and - INTERVAL for cleaner syntax
✓ STR_TO_DATE validates and parses dates
✓ NULL handling critical in date calculations
✓ Always use ISO format (YYYY-MM-DD)
✓ TIMESTAMPDIFF accounts for leap years
✓ Validate age, tenure, and date ranges
✓ Check for weekends/business days when needed
✓ Different databases have different functions
✓ Test with edge cases (month-end, leap years)
✓ Consider time component in datetime comparisons
✓ Use COALESCE for NULL safety
✓ Performance: avoid functions in WHERE on indexed columns

=================================================================
*/
