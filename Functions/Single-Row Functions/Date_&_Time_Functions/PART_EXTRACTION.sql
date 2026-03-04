/*
=================================================================
QUERY PURPOSE: Extract and manipulate date/time components
=================================================================

CONCEPT EXPLANATION (English):
Date and time functions are built-in SQL functions that allow you to work
with temporal data (dates, times, timestamps). Part extraction functions
specifically focus on extracting individual components from date/time values.

Date/time data is crucial for:
- Tracking when events occurred (orders, registrations, logins)
- Scheduling and planning (appointments, deadlines, shifts)
- Reporting and analytics (monthly sales, yearly trends)
- Age calculations (customer age, account tenure)
- Time-based filtering (recent orders, upcoming events)

Part Extraction Functions allow you to:
- Extract specific components (day, month, year, hour, etc.)
- Get readable names (Monday, January, etc.)
- Truncate to specific precision (start of month, year, etc.)
- Calculate end dates (last day of month, quarter, year)
- Format dates for display and grouping

Categories of Date Part Extraction Functions:

1. BASIC EXTRACTION Functions
   - DAY/DAYOFMONTH: Extract day number (1-31)
   - MONTH: Extract month number (1-12)
   - YEAR: Extract year (2024, etc.)
   - HOUR: Extract hour (0-23)
   - MINUTE: Extract minute (0-59)
   - SECOND: Extract second (0-59)

2. NAMED EXTRACTION Functions
   - DAYNAME/DATENAME: Get day name (Monday, Tuesday, etc.)
   - MONTHNAME: Get month name (January, February, etc.)
   - WEEKDAY/DAYOFWEEK: Get day of week number

3. ADVANCED EXTRACTION Functions
   - DATEPART: Extract any date component (SQL Server)
   - EXTRACT: ISO standard extraction
   - WEEK/WEEKOFYEAR: Get week number
   - QUARTER: Get quarter (1-4)
   - DAYOFYEAR: Day number in year (1-365/366)

4. TRUNCATION Functions
   - DATE_TRUNC: Truncate to specific unit (PostgreSQL)
   - DATETRUNC: Truncate date (SQL Server)
   - DATE: Extract date part only (remove time)
   - LAST_DAY: Get last day of month
   - EOMONTH: End of month (SQL Server)

CONCEPT EXPLANATION (Hinglish):
Date aur time functions built-in SQL functions hain jo temporal data
(dates, times, timestamps) ke saath kaam karne dete hain. Part extraction
functions specifically date/time values se individual components extract
karne pe focus karte hain.

Date/time data crucial hai:
- Events track karne ke liye (orders, registrations, logins)
- Scheduling aur planning ke liye (appointments, deadlines, shifts)
- Reporting aur analytics ke liye (monthly sales, yearly trends)
- Age calculations ke liye (customer age, account tenure)
- Time-based filtering ke liye (recent orders, upcoming events)

Part Extraction Functions aapko allow karte hain:
- Specific components extract karna (day, month, year, hour, etc.)
- Readable names nikalna (Monday, January, etc.)
- Specific precision tak truncate karna (month start, year start, etc.)
- End dates calculate karna (month ka last day, quarter, year)
- Display aur grouping ke liye dates format karna

Date Part Extraction Functions ki categories:

1. BASIC EXTRACTION Functions
   - DAY/DAYOFMONTH: Day number nikalna (1-31)
   - MONTH: Month number nikalna (1-12)
   - YEAR: Year nikalna (2024, etc.)
   - HOUR: Hour nikalna (0-23)
   - MINUTE: Minute nikalna (0-59)
   - SECOND: Second nikalna (0-59)

2. NAMED EXTRACTION Functions
   - DAYNAME/DATENAME: Day ka naam (Monday, Tuesday, etc.)
   - MONTHNAME: Month ka naam (January, February, etc.)
   - WEEKDAY/DAYOFWEEK: Week ke day ka number

3. ADVANCED EXTRACTION Functions
   - DATEPART: Koi bhi date component extract karna (SQL Server)
   - EXTRACT: ISO standard extraction
   - WEEK/WEEKOFYEAR: Week number nikalna
   - QUARTER: Quarter nikalna (1-4)
   - DAYOFYEAR: Year mein day number (1-365/366)

4. TRUNCATION Functions
   - DATE_TRUNC: Specific unit tak truncate (PostgreSQL)
   - DATETRUNC: Date truncate (SQL Server)
   - DATE: Sirf date part (time remove)
   - LAST_DAY: Month ka last day
   - EOMONTH: Month ka end (SQL Server)

USE CASES:
- E-commerce: Order date analysis, seasonal trends
- HR: Employee tenure, birthday tracking, anniversary dates
- Finance: Monthly reports, quarterly earnings, fiscal year analysis
- Healthcare: Appointment scheduling, patient age calculation
- Education: Academic year tracking, semester dates, exam schedules
- Subscription: Renewal dates, trial periods, expiration tracking
- Analytics: Time-series analysis, trend identification
- Reporting: Group by month/year, period comparisons
- Scheduling: Shift planning, resource allocation by time
- Compliance: Data retention periods, audit trails

SAMPLE DATA (Orders table):

id | customer_name | order_date          | delivery_date       | amount  | status
---|---------------|---------------------|---------------------|---------|----------
1  | John Doe      | 2024-01-15 14:30:00 | 2024-01-18 10:00:00 | 299.99  | Delivered
2  | Jane Smith    | 2024-02-20 09:15:00 | 2024-02-23 15:30:00 | 450.50  | Delivered
3  | Bob Johnson   | 2024-03-10 16:45:00 | 2024-03-13 11:20:00 | 125.75  | Delivered
4  | Alice Brown   | 2024-03-25 11:00:00 | 2024-03-28 14:00:00 | 680.00  | In Transit
5  | Mike Davis    | 2024-04-05 08:30:00 | NULL                | 320.25  | Processing

Additional sample (Employees table):

id | employee_name | hire_date   | birth_date  | department | salary
---|---------------|-------------|-------------|------------|--------
1  | Sarah Connor  | 2020-03-15  | 1985-07-12  | IT         | 75000
2  | John Smith    | 2018-11-01  | 1990-02-28  | Sales      | 65000
3  | Emma Wilson   | 2022-06-20  | 1988-12-05  | HR         | 60000
4  | Tom Anderson  | 2019-09-10  | 1992-04-18  | IT         | 70000

=================================================================
SECTION 1: BASIC EXTRACTION FUNCTIONS
=================================================================

1.1 DAY / DAYOFMONTH - Extract Day Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  DAY(date) - Standard (MySQL, SQL Server)
  DAYOFMONTH(date) - MySQL alternative
  EXTRACT(DAY FROM date) - PostgreSQL, Oracle
Purpose: Extracts day of month (1-31)
Returns: Integer (1-31)
*/

-- Example 1: Extract day from order dates
SELECT
    customer_name,
    order_date,
    DAY(order_date) AS order_day,
    DAYOFMONTH(order_date) AS order_day_alt  -- MySQL
FROM Orders;
/*
Result:
customer_name | order_date          | order_day | order_day_alt
--------------|---------------------|-----------|---------------
John Doe      | 2024-01-15 14:30:00 | 15        | 15
Jane Smith    | 2024-02-20 09:15:00 | 20        | 20
Bob Johnson   | 2024-03-10 16:45:00 | 10        | 10
Alice Brown   | 2024-03-25 11:00:00 | 25        | 25
Mike Davis    | 2024-04-05 08:30:00 | 5         | 5

Explanation:
- 2024-01-15 → DAY extracts 15
- 2024-02-20 → DAY extracts 20
- 2024-04-05 → DAY extracts 5

Use Case: Day-of-month analysis, billing cycles, payment dates
*/

-- Example 2: Find orders placed in first half of month
SELECT
    customer_name,
    order_date,
    DAY(order_date) AS day_of_month
FROM Orders
WHERE DAY(order_date) <= 15;
/*
Result:
customer_name | order_date          | day_of_month
--------------|---------------------|-------------
John Doe      | 2024-01-15 14:30:00 | 15
Bob Johnson   | 2024-03-10 16:45:00 | 10
Mike Davis    | 2024-04-05 08:30:00 | 5

Use Case: First half vs second half analysis, payment period tracking
*/

-- Example 3: Group orders by day of month
SELECT
    DAY(order_date) AS day_of_month,
    COUNT(*) AS order_count,
    SUM(amount) AS total_amount
FROM Orders
GROUP BY DAY(order_date)
ORDER BY day_of_month;
/*
Result:
day_of_month | order_count | total_amount
-------------|-------------|-------------
5            | 1           | 320.25
10           | 1           | 125.75
15           | 1           | 299.99
20           | 1           | 450.50
25           | 1           | 680.00

Use Case: Daily pattern analysis, peak ordering days
*/

/*
1.2 MONTH - Extract Month Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: MONTH(date)
Purpose: Extracts month number (1-12)
Returns: Integer (1-12)
  1 = January, 2 = February, ..., 12 = December
*/

-- Example 4: Extract month from dates
SELECT
    customer_name,
    order_date,
    MONTH(order_date) AS order_month,
    CASE MONTH(order_date)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name
FROM Orders;
/*
Result:
customer_name | order_date          | order_month | month_name
--------------|---------------------|-------------|------------
John Doe      | 2024-01-15 14:30:00 | 1           | January
Jane Smith    | 2024-02-20 09:15:00 | 2           | February
Bob Johnson   | 2024-03-10 16:45:00 | 3           | March
Alice Brown   | 2024-03-25 11:00:00 | 3           | March
Mike Davis    | 2024-04-05 08:30:00 | 4           | April

Explanation:
- 2024-01-15 → MONTH extracts 1 (January)
- 2024-02-20 → MONTH extracts 2 (February)
- 2024-03-10 → MONTH extracts 3 (March)

Use Case: Monthly reporting, seasonal analysis, fiscal period tracking
*/

-- Example 5: Monthly sales report
SELECT
    MONTH(order_date) AS month_number,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM Orders
WHERE status = 'Delivered'
GROUP BY MONTH(order_date)
ORDER BY month_number;
/*
Result:
month_number | total_orders | total_revenue | avg_order_value
-------------|--------------|---------------|----------------
1            | 1            | 299.99        | 299.99
2            | 1            | 450.50        | 450.50
3            | 2            | 805.75        | 402.88

Use Case: Monthly performance tracking, trend analysis
*/

-- Example 6: Find orders in Q1 (January-March)
SELECT
    customer_name,
    order_date,
    MONTH(order_date) AS month_num
FROM Orders
WHERE MONTH(order_date) BETWEEN 1 AND 3;
/*
Result:
customer_name | order_date          | month_num
--------------|---------------------|----------
John Doe      | 2024-01-15 14:30:00 | 1
Jane Smith    | 2024-02-20 09:15:00 | 2
Bob Johnson   | 2024-03-10 16:45:00 | 3
Alice Brown   | 2024-03-25 11:00:00 | 3

Use Case: Quarterly filtering, seasonal campaigns
*/

/*
1.3 YEAR - Extract Year
━━━━━━━━━━━━━━━━━━━━━━

Syntax: YEAR(date)
Purpose: Extracts 4-digit year
Returns: Integer (e.g., 2024, 2023)
*/

-- Example 7: Extract year from dates
SELECT
    customer_name,
    order_date,
    YEAR(order_date) AS order_year
FROM Orders;
/*
Result:
customer_name | order_date          | order_year
--------------|---------------------|------------
John Doe      | 2024-01-15 14:30:00 | 2024
Jane Smith    | 2024-02-20 09:15:00 | 2024
Bob Johnson   | 2024-03-10 16:45:00 | 2024
Alice Brown   | 2024-03-25 11:00:00 | 2024
Mike Davis    | 2024-04-05 08:30:00 | 2024

Use Case: Year-over-year analysis, annual reports
*/

-- Example 8: Calculate employee tenure
SELECT
    employee_name,
    hire_date,
    YEAR(CURDATE()) AS current_year,
    YEAR(hire_date) AS hire_year,
    YEAR(CURDATE()) - YEAR(hire_date) AS years_with_company
FROM Employees;
/*
Result (assuming current year is 2024):
employee_name | hire_date  | current_year | hire_year | years_with_company
--------------|------------|--------------|-----------|-------------------
Sarah Connor  | 2020-03-15 | 2024         | 2020      | 4
John Smith    | 2018-11-01 | 2024         | 2018      | 6
Emma Wilson   | 2022-06-20 | 2024         | 2022      | 2
Tom Anderson  | 2019-09-10 | 2024         | 2019      | 5

Note: This is approximate tenure (doesn't account for exact months/days)

Use Case: Tenure tracking, anniversary identification
*/

-- Example 9: Yearly revenue comparison
SELECT
    YEAR(order_date) AS year,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue
FROM Orders
GROUP BY YEAR(order_date)
ORDER BY year;
/*
Result:
year | total_orders | total_revenue
-----|--------------|---------------
2024 | 5            | 1876.49

If data spans multiple years:
year | total_orders | total_revenue
-----|--------------|---------------
2022 | 150          | 45000.00
2023 | 200          | 62000.00
2024 | 5            | 1876.49

Use Case: Year-over-year growth analysis, annual reporting
*/

/*
1.4 HOUR, MINUTE, SECOND - Extract Time Components
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  HOUR(datetime) - Extract hour (0-23)
  MINUTE(datetime) - Extract minute (0-59)
  SECOND(datetime) - Extract second (0-59)
Purpose: Extract time components from datetime
Returns: Integer
*/

-- Example 10: Extract time components
SELECT
    customer_name,
    order_date,
    HOUR(order_date) AS order_hour,
    MINUTE(order_date) AS order_minute,
    SECOND(order_date) AS order_second
FROM Orders;
/*
Result:
customer_name | order_date          | order_hour | order_minute | order_second
--------------|---------------------|------------|--------------|-------------
John Doe      | 2024-01-15 14:30:00 | 14         | 30           | 0
Jane Smith    | 2024-02-20 09:15:00 | 9          | 15           | 0
Bob Johnson   | 2024-03-10 16:45:00 | 16         | 45           | 0
Alice Brown   | 2024-03-25 11:00:00 | 11         | 0            | 0
Mike Davis    | 2024-04-05 08:30:00 | 8          | 30           | 0

Explanation:
- 14:30:00 → HOUR=14, MINUTE=30, SECOND=0
- 09:15:00 → HOUR=9, MINUTE=15, SECOND=0

Use Case: Time-of-day analysis, peak hour identification
*/

-- Example 11: Orders by time of day
SELECT
    customer_name,
    order_date,
    HOUR(order_date) AS hour,
    CASE
        WHEN HOUR(order_date) BETWEEN 0 AND 5 THEN 'Night (12AM-6AM)'
        WHEN HOUR(order_date) BETWEEN 6 AND 11 THEN 'Morning (6AM-12PM)'
        WHEN HOUR(order_date) BETWEEN 12 AND 17 THEN 'Afternoon (12PM-6PM)'
        ELSE 'Evening (6PM-12AM)'
    END AS time_of_day
FROM Orders;
/*
Result:
customer_name | order_date          | hour | time_of_day
--------------|---------------------|------|---------------------
John Doe      | 2024-01-15 14:30:00 | 14   | Afternoon (12PM-6PM)
Jane Smith    | 2024-02-20 09:15:00 | 9    | Morning (6AM-12PM)
Bob Johnson   | 2024-03-10 16:45:00 | 16   | Afternoon (12PM-6PM)
Alice Brown   | 2024-03-25 11:00:00 | 11   | Morning (6AM-12PM)
Mike Davis    | 2024-04-05 08:30:00 | 8    | Morning (6AM-12PM)

Use Case: Peak hour analysis, staffing optimization
*/

-- Example 12: Business hours vs after-hours orders
SELECT
    CASE
        WHEN HOUR(order_date) BETWEEN 9 AND 17 THEN 'Business Hours (9AM-5PM)'
        ELSE 'After Hours'
    END AS period,
    COUNT(*) AS order_count,
    ROUND(AVG(amount), 2) AS avg_amount
FROM Orders
GROUP BY
    CASE
        WHEN HOUR(order_date) BETWEEN 9 AND 17 THEN 'Business Hours (9AM-5PM)'
        ELSE 'After Hours'
    END;
/*
Result:
period                    | order_count | avg_amount
--------------------------|-------------|------------
Business Hours (9AM-5PM)  | 4           | 388.81
After Hours               | 1           | 320.25

Use Case: Customer behavior analysis, support staffing
*/

/*
=================================================================
SECTION 2: NAMED EXTRACTION FUNCTIONS
=================================================================

2.1 DAYNAME / DATENAME - Get Day Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  DAYNAME(date) - MySQL
  DATENAME(weekday, date) - SQL Server
  TO_CHAR(date, 'Day') - Oracle, PostgreSQL
Purpose: Returns name of day (Monday, Tuesday, etc.)
Returns: String
*/

-- Example 13: Get day names (MySQL)
SELECT
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    DATE_FORMAT(order_date, '%W') AS day_name_alt  -- MySQL alternative
FROM Orders;
/*
Result:
customer_name | order_date          | day_name  | day_name_alt
--------------|---------------------|-----------|-------------
John Doe      | 2024-01-15 14:30:00 | Monday    | Monday
Jane Smith    | 2024-02-20 09:15:00 | Tuesday   | Tuesday
Bob Johnson   | 2024-03-10 16:45:00 | Sunday    | Sunday
Alice Brown   | 2024-03-25 11:00:00 | Monday    | Monday
Mike Davis    | 2024-04-05 08:30:00 | Friday    | Friday

Explanation:
- 2024-01-15 falls on Monday
- 2024-02-20 falls on Tuesday
- 2024-03-10 falls on Sunday

Use Case: Weekday analysis, weekend vs weekday performance
*/

-- Example 14: Orders by day of week
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS order_count,
    SUM(amount) AS total_revenue
FROM Orders
GROUP BY DAYNAME(order_date)
ORDER BY
    CASE DAYNAME(order_date)
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;
/*
Result:
day_of_week | order_count | total_revenue
------------|-------------|---------------
Monday      | 2           | 979.99
Tuesday     | 1           | 450.50
Friday      | 1           | 320.25
Sunday      | 1           | 125.75

Use Case: Weekly pattern analysis, marketing campaign timing
*/

-- Example 15: Weekend vs Weekday analysis
SELECT
    CASE
        WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS orders,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM Orders
GROUP BY
    CASE
        WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END;
/*
Result:
day_type | orders | avg_order_value
---------|--------|----------------
Weekday  | 4      | 437.62
Weekend  | 1      | 125.75

Use Case: Weekend promotions, staffing decisions
*/

/*
2.2 MONTHNAME - Get Month Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  MONTHNAME(date) - MySQL
  DATENAME(month, date) - SQL Server
  TO_CHAR(date, 'Month') - Oracle, PostgreSQL
Purpose: Returns name of month (January, February, etc.)
Returns: String
*/

-- Example 16: Get month names
SELECT
    customer_name,
    order_date,
    MONTHNAME(order_date) AS month_name,
    DATE_FORMAT(order_date, '%M') AS month_name_alt  -- MySQL alternative
FROM Orders;
/*
Result:
customer_name | order_date          | month_name | month_name_alt
--------------|---------------------|------------|---------------
John Doe      | 2024-01-15 14:30:00 | January    | January
Jane Smith    | 2024-02-20 09:15:00 | February   | February
Bob Johnson   | 2024-03-10 16:45:00 | March      | March
Alice Brown   | 2024-03-25 11:00:00 | March      | March
Mike Davis    | 2024-04-05 08:30:00 | April      | April

Use Case: Monthly reports with readable names, seasonal analysis
*/

-- Example 17: Monthly summary with names
SELECT
    MONTHNAME(order_date) AS month,
    MONTH(order_date) AS month_num,
    COUNT(*) AS total_orders,
    SUM(amount) AS revenue
FROM Orders
GROUP BY MONTHNAME(order_date), MONTH(order_date)
ORDER BY month_num;
/*
Result:
month    | month_num | total_orders | revenue
---------|-----------|--------------|--------
January  | 1         | 1            | 299.99
February | 2         | 1            | 450.50
March    | 3         | 2            | 805.75
April    | 4         | 1            | 320.25

Use Case: Readable monthly reports, presentation-ready data
*/

/*
2.3 WEEKDAY / DAYOFWEEK - Get Day Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  DAYOFWEEK(date) - MySQL (1=Sunday, 7=Saturday)
  WEEKDAY(date) - MySQL (0=Monday, 6=Sunday)
  DATEPART(weekday, date) - SQL Server (1=Sunday, configurable)
Purpose: Returns day of week as number
Returns: Integer
*/

-- Example 18: Get day of week numbers
SELECT
    customer_name,
    order_date,
    DAYOFWEEK(order_date) AS day_num_sun_based,  -- 1=Sun, 7=Sat
    WEEKDAY(order_date) AS day_num_mon_based     -- 0=Mon, 6=Sun
FROM Orders;
/*
Result:
customer_name | order_date          | day_num_sun | day_num_mon
--------------|---------------------|-------------|-------------
John Doe      | 2024-01-15 14:30:00 | 2           | 0
Jane Smith    | 2024-02-20 09:15:00 | 3           | 1
Bob Johnson   | 2024-03-10 16:45:00 | 1           | 6
Alice Brown   | 2024-03-25 11:00:00 | 2           | 0
Mike Davis    | 2024-04-05 08:30:00 | 6           | 4

Explanation:
DAYOFWEEK (1=Sunday):
- Monday = 2, Tuesday = 3, ..., Sunday = 1

WEEKDAY (0=Monday):
- Monday = 0, Tuesday = 1, ..., Sunday = 6

Use Case: Numeric day sorting, calculations based on weekday
*/

-- Example 19: Filter orders on weekdays only (Mon-Fri)
SELECT
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name
FROM Orders
WHERE WEEKDAY(order_date) BETWEEN 0 AND 4;  -- 0=Mon, 4=Fri
/*
Result:
customer_name | order_date          | day_name
--------------|---------------------|----------
John Doe      | 2024-01-15 14:30:00 | Monday
Jane Smith    | 2024-02-20 09:15:00 | Tuesday
Alice Brown   | 2024-03-25 11:00:00 | Monday
Mike Davis    | 2024-04-05 08:30:00 | Friday

Use Case: Business day filtering, workday analysis
*/

/*
=================================================================
SECTION 3: ADVANCED EXTRACTION FUNCTIONS
=================================================================

3.1 DATEPART / EXTRACT - Extract Any Component
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  DATEPART(part, date) - SQL Server
  EXTRACT(part FROM date) - PostgreSQL, MySQL 8.0+, Oracle
Purpose: Extract any date/time component
Returns: Integer
Parts: YEAR, QUARTER, MONTH, WEEK, DAY, HOUR, MINUTE, SECOND, etc.
*/

-- Example 20: EXTRACT in MySQL/PostgreSQL
SELECT
    customer_name,
    order_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day,
    EXTRACT(HOUR FROM order_date) AS hour
FROM Orders;
/*
Result:
customer_name | order_date          | year | month | day | hour
--------------|---------------------|------|-------|-----|------
John Doe      | 2024-01-15 14:30:00 | 2024 | 1     | 15  | 14
Jane Smith    | 2024-02-20 09:15:00 | 2024 | 2     | 20  | 9
Bob Johnson   | 2024-03-10 16:45:00 | 2024 | 3     | 10  | 16
Alice Brown   | 2024-03-25 11:00:00 | 2024 | 3     | 25  | 11
Mike Davis    | 2024-04-05 08:30:00 | 2024 | 4     | 5   | 8

Use Case: Flexible component extraction, ISO standard syntax
*/

-- Example 21: SQL Server DATEPART syntax
/*
-- SQL Server example:
SELECT
    customer_name,
    order_date,
    DATEPART(year, order_date) AS year,
    DATEPART(quarter, order_date) AS quarter,
    DATEPART(month, order_date) AS month,
    DATEPART(week, order_date) AS week,
    DATEPART(day, order_date) AS day,
    DATEPART(hour, order_date) AS hour
FROM Orders;

Result would be similar to EXTRACT above
*/

/*
3.2 WEEK / WEEKOFYEAR - Get Week Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  WEEK(date) - MySQL (week of year, 0-53)
  WEEKOFYEAR(date) - MySQL alternative
  DATEPART(week, date) - SQL Server
Purpose: Returns week number in year
Returns: Integer (0-53 or 1-53 depending on mode)
*/

-- Example 22: Get week numbers
SELECT
    customer_name,
    order_date,
    WEEK(order_date) AS week_number,
    WEEKOFYEAR(order_date) AS week_of_year
FROM Orders;
/*
Result:
customer_name | order_date          | week_number | week_of_year
--------------|---------------------|-------------|-------------
John Doe      | 2024-01-15 14:30:00 | 3           | 3
Jane Smith    | 2024-02-20 09:15:00 | 8           | 8
Bob Johnson   | 2024-03-10 16:45:00 | 10          | 10
Alice Brown   | 2024-03-25 11:00:00 | 13          | 13
Mike Davis    | 2024-04-05 08:30:00 | 14          | 14

Explanation:
- Jan 15, 2024 is in week 3 of the year
- Feb 20, 2024 is in week 8
- Weeks typically start on Sunday or Monday (configurable)

Use Case: Weekly reporting, trend analysis by week
*/

-- Example 23: Weekly sales summary
SELECT
    WEEK(order_date) AS week_num,
    MIN(order_date) AS week_start,
    COUNT(*) AS orders_this_week,
    SUM(amount) AS weekly_revenue
FROM Orders
GROUP BY WEEK(order_date)
ORDER BY week_num;
/*
Result:
week_num | week_start          | orders_this_week | weekly_revenue
---------|---------------------|------------------|---------------
3        | 2024-01-15 14:30:00 | 1                | 299.99
8        | 2024-02-20 09:15:00 | 1                | 450.50
10       | 2024-03-10 16:45:00 | 1                | 125.75
13       | 2024-03-25 11:00:00 | 1                | 680.00
14       | 2024-04-05 08:30:00 | 1                | 320.25

Use Case: Weekly performance tracking, weekly KPIs
*/

/*
3.3 QUARTER - Get Quarter Number
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: QUARTER(date)
Purpose: Returns quarter number (1-4)
  Q1 = Jan-Mar (months 1-3)
  Q2 = Apr-Jun (months 4-6)
  Q3 = Jul-Sep (months 7-9)
  Q4 = Oct-Dec (months 10-12)
Returns: Integer (1-4)
*/

-- Example 24: Get quarter from dates
SELECT
    customer_name,
    order_date,
    MONTH(order_date) AS month,
    QUARTER(order_date) AS quarter,
    CONCAT('Q', QUARTER(order_date), ' ', YEAR(order_date)) AS quarter_label
FROM Orders;
/*
Result:
customer_name | order_date          | month | quarter | quarter_label
--------------|---------------------|-------|---------|---------------
John Doe      | 2024-01-15 14:30:00 | 1     | 1       | Q1 2024
Jane Smith    | 2024-02-20 09:15:00 | 2     | 1       | Q1 2024
Bob Johnson   | 2024-03-10 16:45:00 | 3     | 1       | Q1 2024
Alice Brown   | 2024-03-25 11:00:00 | 3     | 1       | Q1 2024
Mike Davis    | 2024-04-05 08:30:00 | 4     | 2       | Q2 2024

Explanation:
- Months 1-3 (Jan-Mar) → Q1
- Month 4 (Apr) → Q2

Use Case: Quarterly reporting, fiscal quarter analysis
*/

-- Example 25: Quarterly sales summary
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    CONCAT('Q', QUARTER(order_date), ' ', YEAR(order_date)) AS period,
    COUNT(*) AS total_orders,
    SUM(amount) AS quarterly_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM Orders
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY year, quarter;
/*
Result:
year | quarter | period  | total_orders | quarterly_revenue | avg_order_value
-----|---------|---------|--------------|-------------------|----------------
2024 | 1       | Q1 2024 | 4            | 1556.24           | 389.06
2024 | 2       | Q2 2024 | 1            | 320.25            | 320.25

Use Case: Quarterly earnings reports, board presentations
*/

/*
3.4 DAYOFYEAR - Get Day Number in Year
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: DAYOFYEAR(date)
Purpose: Returns day number within year (1-365/366)
  Jan 1 = 1, Dec 31 = 365 (or 366 in leap year)
Returns: Integer (1-366)
*/

-- Example 26: Get day of year
SELECT
    customer_name,
    order_date,
    DAYOFYEAR(order_date) AS day_of_year,
    366 - DAYOFYEAR(order_date) AS days_remaining_in_year
FROM Orders;
/*
Result (2024 is a leap year with 366 days):
customer_name | order_date          | day_of_year | days_remaining
--------------|---------------------|-------------|----------------
John Doe      | 2024-01-15 14:30:00 | 15          | 351
Jane Smith    | 2024-02-20 09:15:00 | 51          | 315
Bob Johnson   | 2024-03-10 16:45:00 | 70          | 296
Alice Brown   | 2024-03-25 11:00:00 | 85          | 281
Mike Davis    | 2024-04-05 08:30:00 | 96          | 270

Explanation:
- Jan 15 is the 15th day of the year
- Feb 20 is day 51 (31 days in Jan + 20 days in Feb)
- Mar 10 is day 70 (31+29+10, 2024 is leap year)

Use Case: Days-since-year-start analysis, seasonal patterns
*/

/*
=================================================================
SECTION 4: TRUNCATION & END-OF-PERIOD FUNCTIONS
=================================================================

4.1 DATE - Extract Date Part Only
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: DATE(datetime)
Purpose: Extracts date part, removes time component
Returns: Date (without time)
*/

-- Example 27: Extract date without time
SELECT
    customer_name,
    order_date AS full_datetime,
    DATE(order_date) AS date_only,
    TIME(order_date) AS time_only
FROM Orders;
/*
Result:
customer_name | full_datetime       | date_only  | time_only
--------------|---------------------|------------|----------
John Doe      | 2024-01-15 14:30:00 | 2024-01-15 | 14:30:00
Jane Smith    | 2024-02-20 09:15:00 | 2024-02-20 | 09:15:00
Bob Johnson   | 2024-03-10 16:45:00 | 2024-03-10 | 16:45:00
Alice Brown   | 2024-03-25 11:00:00 | 2024-03-25 | 11:00:00
Mike Davis    | 2024-04-05 08:30:00 | 2024-04-05 | 08:30:00

Use Case: Date-only comparisons, grouping by date
*/

-- Example 28: Group orders by date (ignoring time)
SELECT
    DATE(order_date) AS order_date,
    COUNT(*) AS orders_per_day,
    SUM(amount) AS daily_revenue
FROM Orders
GROUP BY DATE(order_date)
ORDER BY order_date;
/*
Result:
order_date | orders_per_day | daily_revenue
-----------|----------------|---------------
2024-01-15 | 1              | 299.99
2024-02-20 | 1              | 450.50
2024-03-10 | 1              | 125.75
2024-03-25 | 1              | 680.00
2024-04-05 | 1              | 320.25

Use Case: Daily aggregations, date-based grouping
*/

/*
4.2 DATE_TRUNC - Truncate to Specific Unit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: DATE_TRUNC('unit', date) - PostgreSQL
Purpose: Truncates date to beginning of specified unit
Units: year, quarter, month, week, day, hour, minute, second
Returns: Timestamp truncated to unit
Note: PostgreSQL specific; other databases have alternatives
*/

-- Example 29: DATE_TRUNC examples (PostgreSQL)
/*
-- PostgreSQL syntax:
SELECT
    order_date,
    DATE_TRUNC('year', order_date) AS year_start,
    DATE_TRUNC('quarter', order_date) AS quarter_start,
    DATE_TRUNC('month', order_date) AS month_start,
    DATE_TRUNC('week', order_date) AS week_start,
    DATE_TRUNC('day', order_date) AS day_start
FROM Orders;

Result:
order_date          | year_start          | quarter_start       | month_start         | week_start          | day_start
--------------------|---------------------|---------------------|---------------------|---------------------|--------------------
2024-01-15 14:30:00 | 2024-01-01 00:00:00 | 2024-01-01 00:00:00 | 2024-01-01 00:00:00 | 2024-01-15 00:00:00 | 2024-01-15 00:00:00
2024-02-20 09:15:00 | 2024-01-01 00:00:00 | 2024-01-01 00:00:00 | 2024-02-01 00:00:00 | 2024-02-19 00:00:00 | 2024-02-20 00:00:00
2024-03-10 16:45:00 | 2024-01-01 00:00:00 | 2024-01-01 00:00:00 | 2024-03-01 00:00:00 | 2024-03-04 00:00:00 | 2024-03-10 00:00:00

Use Case: Start-of-period calculations, period-based grouping
*/

-- MySQL equivalent using DATE_FORMAT
SELECT
    order_date,
    DATE_FORMAT(order_date, '%Y-01-01') AS year_start,
    DATE_FORMAT(order_date, '%Y-%m-01') AS month_start,
    DATE(order_date) AS day_start
FROM Orders;

/*
4.3 LAST_DAY - Get Last Day of Month
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: LAST_DAY(date) - MySQL
Purpose: Returns last day of the month for given date
Returns: Date (last day of month)
*/

-- Example 30: Get last day of month
SELECT
    customer_name,
    order_date,
    DATE(order_date) AS order_day,
    LAST_DAY(order_date) AS month_end,
    DAY(LAST_DAY(order_date)) AS days_in_month
FROM Orders;
/*
Result:
customer_name | order_date          | order_day  | month_end  | days_in_month
--------------|---------------------|------------|------------|---------------
John Doe      | 2024-01-15 14:30:00 | 2024-01-15 | 2024-01-31 | 31
Jane Smith    | 2024-02-20 09:15:00 | 2024-02-20 | 2024-02-29 | 29 (leap year)
Bob Johnson   | 2024-03-10 16:45:00 | 2024-03-10 | 2024-03-31 | 31
Alice Brown   | 2024-03-25 11:00:00 | 2024-03-25 | 2024-03-31 | 31
Mike Davis    | 2024-04-05 08:30:00 | 2024-04-05 | 2024-04-30 | 30

Explanation:
- January has 31 days → 2024-01-31
- February 2024 has 29 days (leap year) → 2024-02-29
- March has 31 days → 2024-03-31
- April has 30 days → 2024-04-30

Use Case: End-of-month calculations, billing cycles, reporting periods
*/

-- Example 31: Calculate days remaining in month
SELECT
    customer_name,
    order_date,
    LAST_DAY(order_date) AS month_end,
    DATEDIFF(LAST_DAY(order_date), DATE(order_date)) AS days_until_month_end
FROM Orders;
/*
Result:
customer_name | order_date          | month_end  | days_until_month_end
--------------|---------------------|------------|---------------------
John Doe      | 2024-01-15 14:30:00 | 2024-01-31 | 16
Jane Smith    | 2024-02-20 09:15:00 | 2024-02-29 | 9
Bob Johnson   | 2024-03-10 16:45:00 | 2024-03-31 | 21
Alice Brown   | 2024-03-25 11:00:00 | 2024-03-31 | 6
Mike Davis    | 2024-04-05 08:30:00 | 2024-04-30 | 25

Use Case: Deadline calculations, month-end reminders
*/

/*
4.4 EOMONTH - End of Month (SQL Server)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: EOMONTH(date, [months_to_add])
Purpose: Returns last day of month, with optional offset
Returns: Date
Note: SQL Server specific
*/

-- Example 32: EOMONTH with offset (SQL Server)
/*
-- SQL Server syntax:
SELECT
    order_date,
    EOMONTH(order_date) AS current_month_end,
    EOMONTH(order_date, 1) AS next_month_end,
    EOMONTH(order_date, -1) AS previous_month_end,
    EOMONTH(order_date, 3) AS three_months_later_end
FROM Orders;

Result:
order_date          | current_month_end | next_month_end | prev_month_end | three_months_end
--------------------|-------------------|----------------|----------------|------------------
2024-01-15 14:30:00 | 2024-01-31        | 2024-02-29     | 2023-12-31     | 2024-04-30
2024-02-20 09:15:00 | 2024-02-29        | 2024-03-31     | 2024-01-31     | 2024-05-31

Use Case: Future end-of-month calculations, subscription renewals
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 33: Complete Date Analysis Dashboard
SELECT
    order_date,
    customer_name,

    -- Date components
    DATE(order_date) AS order_day,
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    MONTH(order_date) AS month_num,
    MONTHNAME(order_date) AS month_name,
    WEEK(order_date) AS week_num,
    DAY(order_date) AS day_num,
    DAYNAME(order_date) AS day_name,
    DAYOFYEAR(order_date) AS day_of_year,

    -- Time components
    HOUR(order_date) AS hour,
    MINUTE(order_date) AS minute,

    -- Periods
    CONCAT('Q', QUARTER(order_date), ' ', YEAR(order_date)) AS quarter_label,
    CONCAT(MONTHNAME(order_date), ' ', YEAR(order_date)) AS month_label,

    -- Classification
    CASE
        WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    CASE
        WHEN HOUR(order_date) BETWEEN 9 AND 17 THEN 'Business Hours'
        ELSE 'After Hours'
    END AS business_hours,

    -- End of period
    LAST_DAY(order_date) AS month_end_date,
    DATEDIFF(LAST_DAY(order_date), DATE(order_date)) AS days_to_month_end

FROM Orders;
/*
Use Case: Comprehensive date analysis for BI dashboards
*/

-- Example 34: Employee Anniversary Report
SELECT
    employee_name,
    hire_date,
    YEAR(CURDATE()) - YEAR(hire_date) AS years_employed,
    MONTH(hire_date) AS hire_month,
    MONTHNAME(hire_date) AS hire_month_name,
    DAY(hire_date) AS hire_day,

    -- Anniversary this year
    DATE_FORMAT(
        CONCAT(YEAR(CURDATE()), '-',
               LPAD(MONTH(hire_date), 2, '0'), '-',
               LPAD(DAY(hire_date), 2, '0')),
        '%Y-%m-%d'
    ) AS anniversary_date_this_year,

    -- Is anniversary coming soon?
    CASE
        WHEN DATE_FORMAT(
                CONCAT(YEAR(CURDATE()), '-',
                       LPAD(MONTH(hire_date), 2, '0'), '-',
                       LPAD(DAY(hire_date), 2, '0')),
                '%Y-%m-%d'
             ) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
        THEN 'Anniversary within 30 days!'
        ELSE 'Not soon'
    END AS anniversary_alert

FROM Employees
ORDER BY MONTH(hire_date), DAY(hire_date);
/*
Use Case: HR anniversary tracking, employee recognition programs
*/

-- Example 35: Sales Performance by Time Period
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    MONTHNAME(order_date) AS month,
    DAYNAME(order_date) AS weekday,

    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value,
    MIN(amount) AS min_order,
    MAX(amount) AS max_order

FROM Orders
WHERE status = 'Delivered'
GROUP BY
    YEAR(order_date),
    QUARTER(order_date),
    MONTHNAME(order_date),
    MONTH(order_date),
    DAYNAME(order_date)
ORDER BY
    year,
    quarter,
    MONTH(order_date);
/*
Use Case: Multi-dimensional sales analysis, trend identification
*/

-- Example 36: Birthday/Anniversary Month Analysis
SELECT
    MONTHNAME(birth_date) AS birth_month,
    MONTH(birth_date) AS month_num,
    COUNT(*) AS employees_with_birthday,
    GROUP_CONCAT(employee_name ORDER BY DAY(birth_date)) AS birthday_employees
FROM Employees
GROUP BY MONTHNAME(birth_date), MONTH(birth_date)
ORDER BY month_num;
/*
Result:
birth_month | month_num | employees_with_birthday | birthday_employees
------------|-----------|-------------------------|--------------------
February    | 2         | 1                       | John Smith
April       | 4         | 1                       | Tom Anderson
July        | 7         | 1                       | Sarah Connor
December    | 12        | 1                       | Emma Wilson

Use Case: Birthday celebrations, employee engagement
*/

-- Example 37: First Day of Month/Quarter/Year
SELECT
    order_date,

    -- First day of month
    DATE_FORMAT(order_date, '%Y-%m-01') AS first_day_of_month,

    -- First day of quarter
    CASE QUARTER(order_date)
        WHEN 1 THEN CONCAT(YEAR(order_date), '-01-01')
        WHEN 2 THEN CONCAT(YEAR(order_date), '-04-01')
        WHEN 3 THEN CONCAT(YEAR(order_date), '-07-01')
        WHEN 4 THEN CONCAT(YEAR(order_date), '-10-01')
    END AS first_day_of_quarter,

    -- First day of year
    CONCAT(YEAR(order_date), '-01-01') AS first_day_of_year

FROM Orders;
/*
Use Case: Period-to-date calculations, YTD/QTD/MTD metrics
*/

/*
=================================================================
DATE EXTRACTION IN WHERE CLAUSE
=================================================================
*/

-- Example 38: Filter by specific month
SELECT *
FROM Orders
WHERE MONTH(order_date) = 3  -- March orders
  AND YEAR(order_date) = 2024;

-- Example 39: Filter by quarter
SELECT *
FROM Orders
WHERE QUARTER(order_date) = 1  -- Q1 orders
  AND YEAR(order_date) = 2024;

-- Example 40: Filter by weekday
SELECT *
FROM Orders
WHERE DAYNAME(order_date) IN ('Monday', 'Friday');

-- Example 41: Filter by business hours
SELECT *
FROM Orders
WHERE HOUR(order_date) BETWEEN 9 AND 17;

-- Example 42: Filter by first week of month
SELECT *
FROM Orders
WHERE DAY(order_date) <= 7;

/*
=================================================================
PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ⚠️ Avoid functions on indexed date columns in WHERE
-- ❌ Slow (can't use index):
SELECT * FROM Orders WHERE MONTH(order_date) = 3;

-- ✓ Better (can use index):
SELECT * FROM Orders
WHERE order_date >= '2024-03-01'
  AND order_date < '2024-04-01';

-- ⚠️ For frequent queries, consider computed columns
-- MySQL 5.7+:
ALTER TABLE Orders
ADD COLUMN order_month INT GENERATED ALWAYS AS (MONTH(order_date)) STORED,
ADD INDEX idx_order_month (order_month);

-- Then query becomes fast:
SELECT * FROM Orders WHERE order_month = 3;

/*
=================================================================
DATABASE-SPECIFIC VARIATIONS
=================================================================
*/

/*
MySQL:
DAY(), MONTH(), YEAR(), HOUR(), MINUTE(), SECOND()
DAYNAME(), MONTHNAME(), DAYOFWEEK(), WEEKDAY()
WEEK(), QUARTER(), DAYOFYEAR()
DATE(), LAST_DAY()
EXTRACT(unit FROM date)

PostgreSQL:
EXTRACT(unit FROM date)
DATE_PART('unit', date)
DATE_TRUNC('unit', date)
TO_CHAR(date, 'format')

SQL Server:
DATEPART(unit, date)
DATENAME(unit, date)
DAY(), MONTH(), YEAR()
EOMONTH(date, [offset])
DATEFROMPARTS(year, month, day)

Oracle:
EXTRACT(unit FROM date)
TO_CHAR(date, 'format')
TO_NUMBER(TO_CHAR(date, 'format'))
LAST_DAY(date)
TRUNC(date, 'unit')
*/

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: Using functions on indexed columns
SELECT * FROM Orders WHERE YEAR(order_date) = 2024;
-- Can't use index on order_date

-- ✓ CORRECT:
SELECT * FROM Orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2025-01-01';

-- ❌ MISTAKE 2: Forgetting time component
SELECT * FROM Orders WHERE order_date = '2024-03-10';
-- Won't match '2024-03-10 16:45:00'

-- ✓ CORRECT:
SELECT * FROM Orders WHERE DATE(order_date) = '2024-03-10';
-- Or better:
SELECT * FROM Orders
WHERE order_date >= '2024-03-10'
  AND order_date < '2024-03-11';

-- ❌ MISTAKE 3: DAYOFWEEK vs WEEKDAY confusion
-- DAYOFWEEK: 1=Sunday, 7=Saturday
-- WEEKDAY: 0=Monday, 6=Sunday
-- Know which your database uses!

-- ❌ MISTAKE 4: Timezone issues
-- CURDATE(), NOW() use server timezone
-- Be aware when comparing dates from different timezones

-- ❌ MISTAKE 5: Leap year assumptions
-- Not all Februarys have 28 days!
-- Use LAST_DAY() instead of hardcoding '02-28'

/*
=================================================================
HINGLISH SUMMARY
=================================================================

Date Part Extraction functions dates se specific components nikalne ke liye hain.

Main categories:

1. BASIC EXTRACTION - Simple components nikalna

   DAY(order_date) → 15
   - Date se day number (1-31)

   MONTH(order_date) → 3
   - Month number (1-12)

   YEAR(order_date) → 2024
   - 4-digit year

   HOUR(datetime) → 14, MINUTE → 30, SECOND → 0
   - Time components

2. NAMED EXTRACTION - Readable names

   DAYNAME('2024-03-10') → 'Sunday'
   - Din ka naam

   MONTHNAME('2024-03-10') → 'March'
   - Mahine ka naam

   DAYOFWEEK / WEEKDAY → Number
   - Week ke din ka number

3. ADVANCED EXTRACTION - Complex components

   EXTRACT(QUARTER FROM date) → 1 to 4
   - ISO standard syntax

   WEEK(date) → 1 to 53
   - Week number in year

   QUARTER(date) → 1 to 4
   - Q1, Q2, Q3, Q4

   DAYOFYEAR(date) → 1 to 366
   - Year mein day number

4. TRUNCATION & END DATES

   DATE(datetime) → date only
   - Time component remove

   LAST_DAY(date) → month ka last day
   - Feb: 28/29, Apr: 30, Jan: 31

   DATE_TRUNC('month', date) → month start
   - PostgreSQL mein truncation

Real-world use cases:
- Monthly reports: GROUP BY MONTH(order_date), YEAR(order_date)
- Quarterly analysis: GROUP BY QUARTER(order_date)
- Weekday patterns: WHERE DAYNAME(date) IN ('Monday', 'Friday')
- Business hours: WHERE HOUR(datetime) BETWEEN 9 AND 17
- Anniversaries: WHERE MONTH(hire_date) = MONTH(CURDATE())
- End-of-month: LAST_DAY(date) for billing cycles

Common patterns:
- Date-only comparison: DATE(datetime) = '2024-03-10'
- Month filtering: MONTH(date) = 3 AND YEAR(date) = 2024
- Quarter labels: CONCAT('Q', QUARTER(date), ' ', YEAR(date))
- Weekday/weekend: CASE WHEN DAYNAME(date) IN ('Sat', 'Sun')...
- Period start: DATE_FORMAT(date, '%Y-%m-01') for month start

Important notes:
- Functions in WHERE prevent index usage (slow!)
- Time zones matter (server time vs user time)
- Leap years: Feb can have 29 days
- DAYOFWEEK: 1=Sun in MySQL, configurable in SQL Server
- WEEKDAY: 0=Mon in MySQL
- Different databases have different syntax

Performance tips:
- Avoid: WHERE MONTH(date) = 3
- Use: WHERE date >= '2024-03-01' AND date < '2024-04-01'
- Create computed columns for frequent filters
- Add indexes on computed columns
- Use date ranges instead of functions

Mistakes to avoid:
❌ Functions on indexed columns (slow queries)
❌ Comparing datetime to date without DATE()
❌ Hardcoding month lengths (use LAST_DAY)
❌ Confusing DAYOFWEEK vs WEEKDAY
❌ Ignoring time zones
❌ Assuming February has 28 days

Database differences:
- MySQL: DAYNAME, MONTHNAME, LAST_DAY, WEEK
- PostgreSQL: DATE_TRUNC, EXTRACT, DATE_PART
- SQL Server: DATEPART, DATENAME, EOMONTH
- Oracle: EXTRACT, TO_CHAR, TRUNC, LAST_DAY

Remember:
- DAY/MONTH/YEAR = basic extraction
- DAYNAME/MONTHNAME = readable names
- EXTRACT/DATEPART = flexible extraction
- DATE() = remove time
- LAST_DAY = month end
- Performance matters - avoid functions in WHERE
- Use date ranges instead of extractions
- Know your database's specific syntax

KEY TAKEAWAYS:
✓ DAY, MONTH, YEAR extract basic components
✓ DAYNAME, MONTHNAME give readable names
✓ HOUR, MINUTE, SECOND for time components
✓ QUARTER for quarterly analysis (1-4)
✓ WEEK for weekly tracking (1-53)
✓ DAYOFYEAR for day number in year (1-366)
✓ DATE() removes time component
✓ LAST_DAY() gets end of month
✓ EXTRACT() is ISO standard syntax
✓ Avoid functions on indexed columns in WHERE
✓ Use date ranges for better performance
✓ Be aware of leap years (Feb 29)
✓ Know DAYOFWEEK vs WEEKDAY differences
✓ Different databases have different syntax
✓ Consider time zones in applications

=================================================================
*/

-- Complete example using multiple date extraction functions:
SELECT
    order_date,
    customer_name,
    amount,

    -- Basic extraction
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    MONTH(order_date) AS month_num,
    DAY(order_date) AS day_num,

    -- Named extraction
    MONTHNAME(order_date) AS month_name,
    DAYNAME(order_date) AS day_name,

    -- Advanced
    WEEK(order_date) AS week_num,
    DAYOFYEAR(order_date) AS day_of_year,

    -- Time components
    HOUR(order_date) AS hour,
    MINUTE(order_date) AS minute,

    -- Formatted labels
    CONCAT('Q', QUARTER(order_date), ' ', YEAR(order_date)) AS quarter_label,
    DATE_FORMAT(order_date, '%M %Y') AS month_year,

    -- Truncation
    DATE(order_date) AS date_only,
    LAST_DAY(order_date) AS month_end,

    -- Calculations
    DATEDIFF(LAST_DAY(order_date), DATE(order_date)) AS days_to_month_end,

    -- Classification
    CASE WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday')
         THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    CASE WHEN HOUR(order_date) BETWEEN 9 AND 17
         THEN 'Business Hours' ELSE 'After Hours' END AS time_period

FROM Orders
ORDER BY order_date;
