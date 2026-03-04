/*
=================================================================
QUERY PURPOSE: Format and convert date/time data types
=================================================================

CONCEPT EXPLANATION (English):
Date/time formatting and casting functions allow you to:
- Convert dates to different display formats (MM/DD/YYYY, DD-MM-YYYY, etc.)
- Transform date/time data types (DATE to STRING, STRING to DATE)
- Cast between different data types safely
- Create custom date representations for reports and displays
- Parse dates from text input
- Standardize date formats across systems

These functions are essential for:
- User-facing displays (formatted dates in reports, UIs)
- Data import/export (converting between formats)
- Data type conversions (ensuring proper types in calculations)
- Regional formatting (US vs European date formats)
- Database migrations (converting data types)
- API responses (JSON date formatting)

Categories of Formatting & Casting Functions:

1. FORMAT Functions
   - DATE_FORMAT: Format dates with patterns (MySQL)
   - TO_CHAR: Format dates to string (PostgreSQL, Oracle)
   - FORMAT: General formatting (SQL Server)
   - CONVERT with style: Styled conversion (SQL Server)

2. CASTING Functions
   - CAST: Standard SQL type conversion
   - CONVERT: Type conversion with format (SQL Server, MySQL)
   - STR_TO_DATE: Parse string to date (MySQL)
   - TO_DATE: Parse string to date (PostgreSQL, Oracle)

3. String to Date Parsing
   - STR_TO_DATE: String to date with format (MySQL)
   - TO_DATE: Parse formatted string (PostgreSQL, Oracle)
   - PARSE: Culturally-aware parsing (SQL Server)
   - CONVERT: With format codes (SQL Server)

4. Date to String Conversion
   - DATE_FORMAT: Date to formatted string (MySQL)
   - TO_CHAR: Date to character (PostgreSQL, Oracle)
   - FORMAT: Date to string (SQL Server 2012+)
   - CONVERT: With style parameter (SQL Server)

CONCEPT EXPLANATION (Hinglish):
Date/time formatting aur casting functions aapko allow karte hain:
- Dates ko different display formats mein convert karna (MM/DD/YYYY, DD-MM-YYYY, etc.)
- Date/time data types ko transform karna (DATE to STRING, STRING to DATE)
- Data types ke beech safely cast karna
- Reports aur displays ke liye custom date representations banana
- Text input se dates parse karna
- Systems ke across date formats standardize karna

Yeh functions zaroori hain:
- User-facing displays ke liye (reports, UIs mein formatted dates)
- Data import/export ke liye (formats ke beech convert karna)
- Data type conversions ke liye (calculations mein proper types ensure karna)
- Regional formatting ke liye (US vs European date formats)
- Database migrations ke liye (data types convert karna)
- API responses ke liye (JSON date formatting)

Formatting & Casting Functions ki categories:

1. FORMAT Functions
   - DATE_FORMAT: Patterns ke saath dates format karna (MySQL)
   - TO_CHAR: Dates ko string mein format karna (PostgreSQL, Oracle)
   - FORMAT: General formatting (SQL Server)
   - CONVERT with style: Styled conversion (SQL Server)

2. CASTING Functions
   - CAST: Standard SQL type conversion
   - CONVERT: Format ke saath type conversion (SQL Server, MySQL)
   - STR_TO_DATE: String ko date mein parse karna (MySQL)
   - TO_DATE: String ko date mein parse karna (PostgreSQL, Oracle)

3. String to Date Parsing
   - STR_TO_DATE: Format ke saath string se date (MySQL)
   - TO_DATE: Formatted string parse karna (PostgreSQL, Oracle)
   - PARSE: Culture-aware parsing (SQL Server)
   - CONVERT: Format codes ke saath (SQL Server)

4. Date to String Conversion
   - DATE_FORMAT: Date se formatted string (MySQL)
   - TO_CHAR: Date se character (PostgreSQL, Oracle)
   - FORMAT: Date se string (SQL Server 2012+)
   - CONVERT: Style parameter ke saath (SQL Server)

USE CASES:
- Reports: Display dates in user-friendly formats
- Exports: Convert dates for CSV, Excel, JSON
- Internationalization: Support multiple date formats by region
- Data validation: Parse and validate user input dates
- UI displays: Format dates for web/mobile applications
- Database migrations: Convert between different date types
- API integration: Transform dates for external systems
- Logging: Standardized timestamp formats
- Comparisons: Convert strings to dates for filtering
- Archives: Convert dates to specific storage formats

SAMPLE DATA (Events table):

id | event_name       | event_date          | created_at          | price
---|------------------|---------------------|---------------------|--------
1  | Product Launch   | 2024-03-15 14:30:00 | 2024-01-10 09:00:00 | 299.99
2  | Team Meeting     | 2024-04-20 10:00:00 | 2024-04-01 11:30:00 | 0.00
3  | Conference       | 2024-06-05 09:00:00 | 2024-02-15 16:45:00 | 599.50
4  | Webinar          | 2024-05-12 15:30:00 | 2024-03-20 14:00:00 | 49.99
5  | Workshop         | 2024-07-18 13:00:00 | 2024-05-01 10:15:00 | 199.00

Additional sample data for parsing:

Raw text data to be parsed:
'2024-03-15', '15/03/2024', 'March 15, 2024', '15-Mar-2024', '20240315'

=================================================================
SECTION 1: DATE_FORMAT - MySQL Date Formatting
=================================================================

1.1 DATE_FORMAT - Basic Formatting
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: DATE_FORMAT(date, format_string)
Purpose: Formats date/time according to format string
Returns: Formatted string
Database: MySQL, MariaDB

Common Format Specifiers:
%Y - 4-digit year (2024)
%y - 2-digit year (24)
%M - Full month name (January)
%m - Month number (01-12)
%b - Abbreviated month (Jan)
%d - Day of month (01-31)
%e - Day of month (1-31, no leading zero)
%W - Weekday name (Monday)
%a - Abbreviated weekday (Mon)
%H - Hour (00-23)
%h - Hour (01-12)
%i - Minutes (00-59)
%s - Seconds (00-59)
%p - AM/PM
%T - Time (HH:MM:SS)
*/

-- Example 1: Common date formats
SELECT
    event_name,
    event_date,

    -- US format: MM/DD/YYYY
    DATE_FORMAT(event_date, '%m/%d/%Y') AS us_format,

    -- European format: DD/MM/YYYY
    DATE_FORMAT(event_date, '%d/%m/%Y') AS european_format,

    -- ISO format: YYYY-MM-DD
    DATE_FORMAT(event_date, '%Y-%m-%d') AS iso_format,

    -- Long format: Month DD, YYYY
    DATE_FORMAT(event_date, '%M %d, %Y') AS long_format,

    -- With day name: Monday, March 15, 2024
    DATE_FORMAT(event_date, '%W, %M %e, %Y') AS full_format
FROM Events;
/*
Result:
event_name     | event_date          | us_format  | european   | iso_format | long_format     | full_format
---------------|---------------------|------------|------------|------------|-----------------|---------------------------
Product Launch | 2024-03-15 14:30:00 | 03/15/2024 | 15/03/2024 | 2024-03-15 | March 15, 2024  | Friday, March 15, 2024
Team Meeting   | 2024-04-20 10:00:00 | 04/20/2024 | 20/04/2024 | 2024-04-20 | April 20, 2024  | Saturday, April 20, 2024
Conference     | 2024-06-05 09:00:00 | 06/05/2024 | 05/06/2024 | 2024-06-05 | June 05, 2024   | Wednesday, June 5, 2024

Use Case: Internationalization, user-friendly displays, reports
*/

-- Example 2: Time formatting
SELECT
    event_name,
    event_date,

    -- 24-hour time: 14:30:00
    DATE_FORMAT(event_date, '%H:%i:%s') AS time_24hr,

    -- 12-hour time: 02:30:00 PM
    DATE_FORMAT(event_date, '%h:%i:%s %p') AS time_12hr,

    -- Short time: 14:30
    DATE_FORMAT(event_date, '%H:%i') AS time_short,

    -- Time only (shortcut): 14:30:00
    DATE_FORMAT(event_date, '%T') AS time_default
FROM Events;
/*
Result:
event_name     | event_date          | time_24hr | time_12hr    | time_short | time_default
---------------|---------------------|-----------|--------------|------------|-------------
Product Launch | 2024-03-15 14:30:00 | 14:30:00  | 02:30:00 PM  | 14:30      | 14:30:00
Team Meeting   | 2024-04-20 10:00:00 | 10:00:00  | 10:00:00 AM  | 10:00      | 10:00:00
Conference     | 2024-06-05 09:00:00 | 09:00:00  | 09:00:00 AM  | 09:00      | 09:00:00

Use Case: Scheduling displays, time tracking, appointment systems
*/

-- Example 3: Combined date and time formats
SELECT
    event_name,
    event_date,

    -- US datetime: 03/15/2024 02:30 PM
    DATE_FORMAT(event_date, '%m/%d/%Y %h:%i %p') AS us_datetime,

    -- European datetime: 15/03/2024 14:30
    DATE_FORMAT(event_date, '%d/%m/%Y %H:%i') AS euro_datetime,

    -- ISO 8601: 2024-03-15T14:30:00
    DATE_FORMAT(event_date, '%Y-%m-%dT%H:%i:%s') AS iso8601,

    -- Readable: Friday, March 15, 2024 at 2:30 PM
    DATE_FORMAT(event_date, '%W, %M %e, %Y at %h:%i %p') AS readable
FROM Events;
/*
Result:
event_name     | us_datetime         | euro_datetime    | iso8601             | readable
---------------|---------------------|------------------|---------------------|----------------------------------------
Product Launch | 03/15/2024 02:30 PM | 15/03/2024 14:30 | 2024-03-15T14:30:00 | Friday, March 15, 2024 at 02:30 PM
Team Meeting   | 04/20/2024 10:00 AM | 20/04/2024 10:00 | 2024-04-20T10:00:00 | Saturday, April 20, 2024 at 10:00 AM

Use Case: Event calendars, appointment scheduling, booking systems
*/

-- Example 4: Custom creative formats
SELECT
    event_name,
    event_date,

    -- Abbreviated: Mar 15, '24
    DATE_FORMAT(event_date, '%b %e, ''%y') AS abbreviated,

    -- With ordinal-like: 15th March 2024
    CONCAT(
        DATE_FORMAT(event_date, '%e'),
        CASE
            WHEN DAY(event_date) IN (1, 21, 31) THEN 'st'
            WHEN DAY(event_date) IN (2, 22) THEN 'nd'
            WHEN DAY(event_date) IN (3, 23) THEN 'rd'
            ELSE 'th'
        END,
        DATE_FORMAT(event_date, ' %M %Y')
    ) AS with_ordinal,

    -- File-safe format: 20240315_1430
    DATE_FORMAT(event_date, '%Y%m%d_%H%i') AS filename_safe,

    -- Week format: Week 11, 2024
    CONCAT('Week ', WEEK(event_date), ', ', YEAR(event_date)) AS week_format
FROM Events;
/*
Result:
event_name     | abbreviated | with_ordinal      | filename_safe  | week_format
---------------|-------------|-------------------|----------------|---------------
Product Launch | Mar 15, '24 | 15th March 2024   | 20240315_1430  | Week 11, 2024
Team Meeting   | Apr 20, '24 | 20th April 2024   | 20240420_1000  | Week 16, 2024
Conference     | Jun 5, '24  | 5th June 2024     | 20240605_0900  | Week 23, 2024

Use Case: Filenames, logs, creative displays, social media posts
*/

-- Example 5: Localized month and day names
SELECT
    event_name,
    event_date,

    -- Full names
    DATE_FORMAT(event_date, '%W, %M %e, %Y') AS full_names,

    -- Abbreviated names
    DATE_FORMAT(event_date, '%a, %b %e, %Y') AS abbreviated,

    -- All caps
    UPPER(DATE_FORMAT(event_date, '%W, %M %e')) AS uppercase_names,

    -- First letter caps only
    CONCAT(
        UPPER(LEFT(DATE_FORMAT(event_date, '%W'), 1)),
        LOWER(SUBSTRING(DATE_FORMAT(event_date, '%W'), 2)),
        ', ',
        UPPER(LEFT(DATE_FORMAT(event_date, '%M'), 1)),
        LOWER(SUBSTRING(DATE_FORMAT(event_date, '%M'), 2)),
        DATE_FORMAT(event_date, ' %e, %Y')
    ) AS title_case
FROM Events
LIMIT 2;
/*
Result:
event_name     | full_names                | abbreviated    | uppercase_names       | title_case
---------------|---------------------------|----------------|-----------------------|---------------------------
Product Launch | Friday, March 15, 2024    | Fri, Mar 15, 2024 | FRIDAY, MARCH 15   | Friday, March 15, 2024
Team Meeting   | Saturday, April 20, 2024  | Sat, Apr 20, 2024 | SATURDAY, APRIL 20 | Saturday, April 20, 2024

Use Case: Different capitalization preferences, style guides
*/

/*
=================================================================
SECTION 2: CAST - Standard Type Conversion
=================================================================

2.1 CAST - Basic Type Casting
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CAST(expression AS type)
Purpose: Converts expression to specified data type
Returns: Value as new type
Standard: ANSI SQL (works across most databases)

Common casts:
CAST(value AS CHAR) - to string
CAST(value AS DATE) - to date
CAST(value AS DATETIME) - to datetime
CAST(value AS DECIMAL(10,2)) - to decimal
CAST(value AS SIGNED) - to integer
*/

-- Example 6: Date to string casting
SELECT
    event_name,
    event_date,

    -- Cast datetime to date (removes time)
    CAST(event_date AS DATE) AS date_only,

    -- Cast datetime to time (removes date)
    CAST(event_date AS TIME) AS time_only,

    -- Cast to char (string)
    CAST(event_date AS CHAR) AS as_string,

    -- Type information
    TYPEOF(event_date) AS original_type,
    TYPEOF(CAST(event_date AS CHAR)) AS string_type
FROM Events;
/*
Result:
event_name     | event_date          | date_only  | time_only | as_string           | original_type | string_type
---------------|---------------------|------------|-----------|---------------------|---------------|-------------
Product Launch | 2024-03-15 14:30:00 | 2024-03-15 | 14:30:00  | 2024-03-15 14:30:00 | datetime      | varchar
Team Meeting   | 2024-04-20 10:00:00 | 2024-04-20 | 10:00:00  | 2024-04-20 10:00:00 | datetime      | varchar

Use Case: Type safety, explicit conversions, data cleaning
*/

-- Example 7: String to date casting
SELECT
    '2024-03-15' AS date_string,
    CAST('2024-03-15' AS DATE) AS parsed_date,

    '2024-03-15 14:30:00' AS datetime_string,
    CAST('2024-03-15 14:30:00' AS DATETIME) AS parsed_datetime,

    '14:30:00' AS time_string,
    CAST('14:30:00' AS TIME) AS parsed_time;
/*
Result:
date_string | parsed_date | datetime_string     | parsed_datetime     | time_string | parsed_time
------------|-------------|---------------------|---------------------|-------------|-------------
2024-03-15  | 2024-03-15  | 2024-03-15 14:30:00 | 2024-03-15 14:30:00 | 14:30:00    | 14:30:00

Note: String must be in recognizable format (ISO 8601 works universally)

Use Case: Parsing user input, data imports, API integrations
*/

-- Example 8: Numeric to string and vice versa
SELECT
    price,

    -- Number to string
    CAST(price AS CHAR) AS price_string,

    -- String to number
    CAST('123.45' AS DECIMAL(10,2)) AS parsed_decimal,

    -- Concatenate number in string context
    CONCAT('$', CAST(price AS CHAR)) AS formatted_price
FROM Events
LIMIT 3;
/*
Result:
price  | price_string | parsed_decimal | formatted_price
-------|--------------|----------------|----------------
299.99 | 299.99       | 123.45         | $299.99
0.00   | 0.00         | 123.45         | $0.00
599.50 | 599.50       | 123.45         | $599.50

Use Case: Display formatting, calculations, data validation
*/

-- Example 9: Safe casting with error handling
SELECT
    event_name,

    -- This works
    CAST('2024-03-15' AS DATE) AS valid_cast,

    -- This would error: CAST('invalid' AS DATE)
    -- Use TRY_CAST in SQL Server or CASE for safety:
    CASE
        WHEN '2024-03-15' REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        THEN CAST('2024-03-15' AS DATE)
        ELSE NULL
    END AS safe_cast
FROM Events
LIMIT 1;
/*
Result:
event_name     | valid_cast | safe_cast
---------------|------------|------------
Product Launch | 2024-03-15 | 2024-03-15

Use Case: Data validation, error-tolerant imports
*/

/*
=================================================================
SECTION 3: CONVERT - MySQL Format Conversion
=================================================================

3.1 CONVERT - Type and Format Conversion
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CONVERT(expression, type)
Purpose: Converts expression to specified type
Database: MySQL (different from SQL Server CONVERT)
Returns: Converted value
*/

-- Example 10: CONVERT in MySQL
SELECT
    event_date,

    -- Convert datetime to date
    CONVERT(event_date, DATE) AS date_only,

    -- Convert datetime to time
    CONVERT(event_date, TIME) AS time_only,

    -- Convert to char
    CONVERT(event_date, CHAR) AS as_char,

    -- Convert with character set (advanced)
    CONVERT(event_name USING utf8mb4) AS utf8_name
FROM Events
LIMIT 2;
/*
Result:
event_date          | date_only  | time_only | as_char             | utf8_name
--------------------|------------|-----------|---------------------|---------------
2024-03-15 14:30:00 | 2024-03-15 | 14:30:00  | 2024-03-15 14:30:00 | Product Launch
2024-04-20 10:00:00 | 2024-04-20 | 10:00:00  | 2024-04-20 10:00:00 | Team Meeting

Note: MySQL CONVERT is similar to CAST but with different syntax

Use Case: Type conversions, character set conversions
*/

/*
=================================================================
SECTION 4: STR_TO_DATE - Parse String to Date
=================================================================

4.1 STR_TO_DATE - Parse with Format
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: STR_TO_DATE(string, format)
Purpose: Parses string to date using specified format
Database: MySQL
Returns: DATE or DATETIME
Format specifiers: Same as DATE_FORMAT (%Y, %m, %d, etc.)
*/

-- Example 11: Parse different date formats
SELECT
    -- ISO format
    STR_TO_DATE('2024-03-15', '%Y-%m-%d') AS iso_format,

    -- US format: MM/DD/YYYY
    STR_TO_DATE('03/15/2024', '%m/%d/%Y') AS us_format,

    -- European format: DD/MM/YYYY
    STR_TO_DATE('15/03/2024', '%d/%m/%Y') AS euro_format,

    -- With month name
    STR_TO_DATE('March 15, 2024', '%M %d, %Y') AS month_name,

    -- Abbreviated month
    STR_TO_DATE('15-Mar-2024', '%d-%b-%Y') AS abbrev_month,

    -- Compact format
    STR_TO_DATE('20240315', '%Y%m%d') AS compact;
/*
Result:
iso_format | us_format  | euro_format | month_name | abbrev_month | compact
-----------|------------|-------------|------------|--------------|------------
2024-03-15 | 2024-03-15 | 2024-03-15  | 2024-03-15 | 2024-03-15   | 2024-03-15

All parse to the same date, just from different string formats

Use Case: Data imports, user input parsing, file processing
*/

-- Example 12: Parse datetime with time
SELECT
    -- ISO datetime
    STR_TO_DATE('2024-03-15 14:30:00', '%Y-%m-%d %H:%i:%s') AS iso_datetime,

    -- US datetime with AM/PM
    STR_TO_DATE('03/15/2024 02:30 PM', '%m/%d/%Y %h:%i %p') AS us_datetime,

    -- European datetime
    STR_TO_DATE('15/03/2024 14:30', '%d/%m/%Y %H:%i') AS euro_datetime,

    -- Long format
    STR_TO_DATE('March 15, 2024 at 2:30 PM', '%M %d, %Y at %h:%i %p') AS long_format;
/*
Result:
iso_datetime        | us_datetime         | euro_datetime       | long_format
--------------------|---------------------|---------------------|--------------------
2024-03-15 14:30:00 | 2024-03-15 14:30:00 | 2024-03-15 14:30:00 | 2024-03-15 14:30:00

Use Case: Parsing timestamps, log file processing, API data
*/

-- Example 13: Parse partial dates (defaults)
SELECT
    -- Just year and month (defaults to 1st day)
    STR_TO_DATE('2024-03', '%Y-%m') AS year_month,

    -- Just year (defaults to Jan 1)
    STR_TO_DATE('2024', '%Y') AS year_only,

    -- Month and day (assumes current year - may not work in all cases)
    STR_TO_DATE('03-15', '%m-%d') AS month_day;
/*
Result:
year_month | year_only  | month_day
-----------|------------|------------
2024-03-01 | 2024-01-01 | 0000-03-15 (or current year-03-15)

Note: Partial dates may behave differently across MySQL versions

Use Case: Flexible date parsing, month-only data
*/

-- Example 14: Real-world import scenario
-- Imagine importing data from CSV with various date formats
CREATE TEMPORARY TABLE import_data (
    id INT,
    date_us VARCHAR(20),
    date_euro VARCHAR(20),
    date_iso VARCHAR(20)
);

INSERT INTO import_data VALUES
(1, '03/15/2024', '15/03/2024', '2024-03-15'),
(2, '04/20/2024', '20/04/2024', '2024-04-20'),
(3, '06/05/2024', '05/06/2024', '2024-06-05');

SELECT
    id,
    date_us AS us_original,
    STR_TO_DATE(date_us, '%m/%d/%Y') AS us_parsed,

    date_euro AS euro_original,
    STR_TO_DATE(date_euro, '%d/%m/%Y') AS euro_parsed,

    date_iso AS iso_original,
    STR_TO_DATE(date_iso, '%Y-%m-%d') AS iso_parsed,

    -- Verify they're all the same date
    CASE
        WHEN STR_TO_DATE(date_us, '%m/%d/%Y') = STR_TO_DATE(date_euro, '%d/%m/%Y')
         AND STR_TO_DATE(date_us, '%m/%d/%Y') = STR_TO_DATE(date_iso, '%Y-%m-%d')
        THEN 'Match'
        ELSE 'Mismatch'
    END AS validation
FROM import_data;
/*
Result:
id | us_original | us_parsed  | euro_original | euro_parsed | iso_original | iso_parsed | validation
---|-------------|------------|---------------|-------------|--------------|------------|------------
1  | 03/15/2024  | 2024-03-15 | 15/03/2024    | 2024-03-15  | 2024-03-15   | 2024-03-15 | Match
2  | 04/20/2024  | 2024-04-20 | 20/04/2024    | 2024-04-20  | 2024-04-20   | 2024-04-20 | Match
3  | 06/05/2024  | 2024-06-05 | 05/06/2024    | 2024-06-05  | 2024-06-05   | 2024-06-05 | Match

Use Case: Data validation during import, format standardization
*/

DROP TEMPORARY TABLE import_data;

/*
=================================================================
SECTION 5: SQL Server FORMAT and CONVERT
=================================================================

5.1 FORMAT - Culture-Aware Formatting (SQL Server 2012+)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: FORMAT(value, format_string, [culture])
Purpose: Formats value using .NET format strings
Database: SQL Server, Azure SQL
Returns: Formatted string
*/

-- Example 15: SQL Server FORMAT examples
/*
-- SQL Server syntax:
SELECT
    event_date,

    -- Standard date formats
    FORMAT(event_date, 'd') AS short_date,           -- 3/15/2024
    FORMAT(event_date, 'D') AS long_date,            -- Friday, March 15, 2024
    FORMAT(event_date, 'M') AS month_day,            -- March 15
    FORMAT(event_date, 'Y') AS year_month,           -- March 2024

    -- Standard time formats
    FORMAT(event_date, 't') AS short_time,           -- 2:30 PM
    FORMAT(event_date, 'T') AS long_time,            -- 2:30:00 PM

    -- Custom formats
    FORMAT(event_date, 'yyyy-MM-dd') AS custom_date,
    FORMAT(event_date, 'MMM dd, yyyy') AS custom_abbrev,

    -- Culture-specific (requires culture parameter)
    FORMAT(event_date, 'd', 'en-US') AS us_format,
    FORMAT(event_date, 'd', 'de-DE') AS german_format,
    FORMAT(event_date, 'd', 'ja-JP') AS japanese_format
FROM Events;

Result:
event_date          | short_date | long_date                  | month_day  | year_month   | short_time | long_time  | custom_date | custom_abbrev
--------------------|------------|----------------------------|------------|--------------|------------|------------|-------------|---------------
2024-03-15 14:30:00 | 3/15/2024  | Friday, March 15, 2024     | March 15   | March 2024   | 2:30 PM    | 2:30:00 PM | 2024-03-15  | Mar 15, 2024

us_format  | german_format | japanese_format
-----------|---------------|----------------
3/15/2024  | 15.03.2024    | 2024/03/15

Use Case: Internationalization, culture-specific displays, .NET integration
*/

/*
5.2 CONVERT with Style - SQL Server Styled Conversion
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CONVERT(data_type, expression, [style])
Purpose: Converts data type with optional style code
Database: SQL Server
Returns: Converted value in specified format

Common style codes:
1   - MM/DD/YY
101 - MM/DD/YYYY (US)
3   - DD/MM/YY
103 - DD/MM/YYYY (European)
112 - YYYYMMDD (ISO)
120 - YYYY-MM-DD HH:MI:SS (ODBC)
*/

-- Example 16: SQL Server CONVERT with styles
/*
-- SQL Server syntax:
SELECT
    event_date,

    -- US formats
    CONVERT(VARCHAR, event_date, 1) AS style_1,      -- MM/DD/YY
    CONVERT(VARCHAR, event_date, 101) AS style_101,  -- MM/DD/YYYY

    -- European formats
    CONVERT(VARCHAR, event_date, 3) AS style_3,      -- DD/MM/YY
    CONVERT(VARCHAR, event_date, 103) AS style_103,  -- DD/MM/YYYY

    -- ISO formats
    CONVERT(VARCHAR, event_date, 112) AS style_112,  -- YYYYMMDD
    CONVERT(VARCHAR, event_date, 120) AS style_120,  -- YYYY-MM-DD HH:MI:SS

    -- Other formats
    CONVERT(VARCHAR, event_date, 106) AS style_106,  -- DD Mon YYYY
    CONVERT(VARCHAR, event_date, 107) AS style_107   -- Mon DD, YYYY
FROM Events;

Result:
event_date          | style_1   | style_101  | style_3   | style_103  | style_112 | style_120           | style_106    | style_107
--------------------|-----------|------------|-----------|------------|-----------|---------------------|--------------|---------------
2024-03-15 14:30:00 | 03/15/24  | 03/15/2024 | 15/03/24  | 15/03/2024 | 20240315  | 2024-03-15 14:30:00 | 15 Mar 2024  | Mar 15, 2024

Use Case: Legacy system compatibility, specific format requirements
*/

/*
=================================================================
SECTION 6: PostgreSQL TO_CHAR and TO_DATE
=================================================================

6.1 TO_CHAR - Format Date to String
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: TO_CHAR(timestamp, format)
Purpose: Converts timestamp to formatted string
Database: PostgreSQL, Oracle
Returns: Formatted string

Common format patterns:
YYYY - 4-digit year
MM   - Month number (01-12)
DD   - Day of month (01-31)
HH24 - Hour (00-23)
HH12 - Hour (01-12)
MI   - Minute (00-59)
SS   - Second (00-59)
Day  - Full day name
Mon  - Abbreviated month
*/

-- Example 17: PostgreSQL TO_CHAR examples
/*
-- PostgreSQL syntax:
SELECT
    event_date,

    -- Basic formats
    TO_CHAR(event_date, 'YYYY-MM-DD') AS iso_date,
    TO_CHAR(event_date, 'MM/DD/YYYY') AS us_date,
    TO_CHAR(event_date, 'DD/MM/YYYY') AS euro_date,

    -- With month names
    TO_CHAR(event_date, 'Mon DD, YYYY') AS abbrev_month,
    TO_CHAR(event_date, 'Month DD, YYYY') AS full_month,

    -- With day names
    TO_CHAR(event_date, 'Day, Month DD, YYYY') AS full_format,
    TO_CHAR(event_date, 'Dy, Mon DD, YYYY') AS abbrev_format,

    -- Time formats
    TO_CHAR(event_date, 'HH24:MI:SS') AS time_24hr,
    TO_CHAR(event_date, 'HH12:MI:SS AM') AS time_12hr,

    -- Combined
    TO_CHAR(event_date, 'YYYY-MM-DD HH24:MI:SS') AS full_timestamp
FROM Events;

Result:
event_date          | iso_date   | us_date    | euro_date  | abbrev_month | full_month      | full_format
--------------------|------------|------------|------------|--------------|-----------------|---------------------------
2024-03-15 14:30:00 | 2024-03-15 | 03/15/2024 | 15/03/2024 | Mar 15, 2024 | March 15, 2024  | Friday  , March 15, 2024

abbrev_format    | time_24hr | time_12hr    | full_timestamp
-----------------|-----------|--------------|--------------------
Fri, Mar 15, 2024| 14:30:00  | 02:30:00 PM  | 2024-03-15 14:30:00

Use Case: PostgreSQL reporting, flexible formatting
*/

/*
6.2 TO_DATE - Parse String to Date
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: TO_DATE(string, format)
Purpose: Parses string to date using format
Database: PostgreSQL, Oracle
Returns: DATE
*/

-- Example 18: PostgreSQL TO_DATE examples
/*
-- PostgreSQL syntax:
SELECT
    -- Various input formats
    TO_DATE('2024-03-15', 'YYYY-MM-DD') AS iso_format,
    TO_DATE('03/15/2024', 'MM/DD/YYYY') AS us_format,
    TO_DATE('15/03/2024', 'DD/MM/YYYY') AS euro_format,
    TO_DATE('15-Mar-2024', 'DD-Mon-YYYY') AS month_abbrev,
    TO_DATE('March 15, 2024', 'Month DD, YYYY') AS month_full,
    TO_DATE('20240315', 'YYYYMMDD') AS compact_format;

Result:
iso_format | us_format  | euro_format | month_abbrev | month_full | compact_format
-----------|------------|-------------|--------------|------------|---------------
2024-03-15 | 2024-03-15 | 2024-03-15  | 2024-03-15   | 2024-03-15 | 2024-03-15

Use Case: PostgreSQL data imports, format parsing
*/

/*
=================================================================
SECTION 7: COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 19: Multi-format date display for different regions
SELECT
    event_name,
    event_date,

    -- For US users
    DATE_FORMAT(event_date, '%m/%d/%Y %h:%i %p') AS us_display,

    -- For European users
    DATE_FORMAT(event_date, '%d/%m/%Y %H:%i') AS euro_display,

    -- For Asian users (ISO format preferred)
    DATE_FORMAT(event_date, '%Y-%m-%d %H:%i') AS asia_display,

    -- Universal readable format
    DATE_FORMAT(event_date, '%W, %M %e, %Y at %h:%i %p') AS universal_display,

    -- For sorting/technical use
    DATE_FORMAT(event_date, '%Y%m%d%H%i%s') AS sortable_format
FROM Events;
/*
Result:
event_name     | event_date          | us_display          | euro_display     | asia_display     | universal_display                       | sortable_format
---------------|---------------------|---------------------|------------------|------------------|-----------------------------------------|----------------
Product Launch | 2024-03-15 14:30:00 | 03/15/2024 02:30 PM | 15/03/2024 14:30 | 2024-03-15 14:30 | Friday, March 15, 2024 at 02:30 PM      | 20240315143000
Team Meeting   | 2024-04-20 10:00:00 | 04/20/2024 10:00 AM | 20/04/2024 10:00 | 2024-04-20 10:00 | Saturday, April 20, 2024 at 10:00 AM    | 20240420100000

Use Case: International applications, user preference settings
*/

-- Example 20: Calendar/scheduling application format
SELECT
    event_name,
    event_date,

    -- Calendar title format
    DATE_FORMAT(event_date, '%M %Y') AS calendar_month,

    -- Event list format (short)
    DATE_FORMAT(event_date, '%a, %b %e') AS event_list_short,

    -- Event detail format (full)
    CONCAT(
        DATE_FORMAT(event_date, '%W, %M %e, %Y'),
        ' from ',
        DATE_FORMAT(event_date, '%h:%i %p'),
        ' to ',
        DATE_FORMAT(DATE_ADD(event_date, INTERVAL 2 HOUR), '%h:%i %p')
    ) AS event_detail,

    -- iCalendar format (RFC 5545)
    DATE_FORMAT(event_date, '%Y%m%dT%H%i%s') AS icalendar_format
FROM Events;
/*
Result:
event_name     | calendar_month | event_list_short | event_detail                                              | icalendar_format
---------------|----------------|------------------|-----------------------------------------------------------|------------------
Product Launch | March 2024     | Fri, Mar 15      | Friday, March 15, 2024 from 02:30 PM to 04:30 PM          | 20240315T143000
Team Meeting   | April 2024     | Sat, Apr 20      | Saturday, April 20, 2024 from 10:00 AM to 12:00 PM        | 20240420T100000

Use Case: Event management, calendar integrations, .ics file generation
*/

-- Example 21: Export formats for different file types
SELECT
    event_name,
    event_date,
    price,

    -- CSV export (ISO format for safety)
    CONCAT(
        '"', event_name, '",',
        '"', DATE_FORMAT(event_date, '%Y-%m-%d %H:%i:%s'), '",',
        price
    ) AS csv_row,

    -- JSON export
    CONCAT(
        '{"name":"', event_name, '",',
        '"date":"', DATE_FORMAT(event_date, '%Y-%m-%dT%H:%i:%s'), '",',
        '"price":', price, '}'
    ) AS json_object,

    -- XML export
    CONCAT(
        '<event>',
        '<name>', event_name, '</name>',
        '<date>', DATE_FORMAT(event_date, '%Y-%m-%d %H:%i:%s'), '</date>',
        '<price>', price, '</price>',
        '</event>'
    ) AS xml_element
FROM Events
LIMIT 2;
/*
Result:
csv_row
---------------------------------------------------------------
"Product Launch","2024-03-15 14:30:00",299.99
"Team Meeting","2024-04-20 10:00:00",0.00

json_object
---------------------------------------------------------------
{"name":"Product Launch","date":"2024-03-15T14:30:00","price":299.99}
{"name":"Team Meeting","date":"2024-04-20T10:00:00","price":0.00}

xml_element
---------------------------------------------------------------
<event><name>Product Launch</name><date>2024-03-15 14:30:00</date><price>299.99</price></event>

Use Case: Data exports, API responses, file generation
*/

-- Example 22: Filename generation with timestamps
SELECT
    event_name,
    event_date,

    -- Safe filename (no spaces or special chars)
    CONCAT(
        LOWER(REPLACE(event_name, ' ', '_')),
        '_',
        DATE_FORMAT(event_date, '%Y%m%d'),
        '.pdf'
    ) AS filename,

    -- Timestamped filename
    CONCAT(
        'export_',
        DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'),
        '.csv'
    ) AS export_filename,

    -- Log filename with date
    CONCAT(
        'event_log_',
        DATE_FORMAT(event_date, '%Y_%m_%d'),
        '.txt'
    ) AS log_filename
FROM Events;
/*
Result:
event_name     | filename                     | export_filename          | log_filename
---------------|------------------------------|--------------------------|-------------------
Product Launch | product_launch_20240315.pdf  | export_20240304_153045.csv | event_log_2024_03_15.txt
Team Meeting   | team_meeting_20240420.pdf    | export_20240304_153045.csv | event_log_2024_04_20.txt

Use Case: File generation, automated reports, data archiving
*/

-- Example 23: User-friendly relative dates with formatting
SELECT
    event_name,
    event_date,

    -- Formatted date
    DATE_FORMAT(event_date, '%M %e, %Y') AS formatted_date,

    -- Days until event
    DATEDIFF(event_date, CURDATE()) AS days_until,

    -- User-friendly description
    CASE
        WHEN DATEDIFF(event_date, CURDATE()) < 0
        THEN CONCAT('Passed ', ABS(DATEDIFF(event_date, CURDATE())), ' days ago')

        WHEN DATEDIFF(event_date, CURDATE()) = 0
        THEN 'Today!'

        WHEN DATEDIFF(event_date, CURDATE()) = 1
        THEN 'Tomorrow'

        WHEN DATEDIFF(event_date, CURDATE()) <= 7
        THEN CONCAT('In ', DATEDIFF(event_date, CURDATE()), ' days (', DAYNAME(event_date), ')')

        ELSE CONCAT('On ', DATE_FORMAT(event_date, '%M %e, %Y'))
    END AS friendly_description
FROM Events;
/*
Result (assuming current date is 2024-03-04):
event_name     | formatted_date | days_until | friendly_description
---------------|----------------|------------|--------------------------------
Product Launch | March 15, 2024 | 11         | In 11 days (Friday)
Team Meeting   | April 20, 2024 | 47         | On April 20, 2024
Conference     | June 5, 2024   | 93         | On June 5, 2024

Use Case: Event countdown displays, upcoming events lists
*/

-- Example 24: Parsing and validating user input
CREATE TEMPORARY TABLE user_input (
    id INT AUTO_INCREMENT PRIMARY KEY,
    input_date VARCHAR(50),
    input_format VARCHAR(20)
);

INSERT INTO user_input (input_date, input_format) VALUES
('2024-03-15', 'ISO'),
('03/15/2024', 'US'),
('15/03/2024', 'EU'),
('March 15, 2024', 'LONG'),
('20240315', 'COMPACT'),
('invalid date', 'INVALID');

SELECT
    input_date,
    input_format,

    -- Try to parse based on format
    CASE input_format
        WHEN 'ISO' THEN STR_TO_DATE(input_date, '%Y-%m-%d')
        WHEN 'US' THEN STR_TO_DATE(input_date, '%m/%d/%Y')
        WHEN 'EU' THEN STR_TO_DATE(input_date, '%d/%m/%Y')
        WHEN 'LONG' THEN STR_TO_DATE(input_date, '%M %d, %Y')
        WHEN 'COMPACT' THEN STR_TO_DATE(input_date, '%Y%m%d')
        ELSE NULL
    END AS parsed_date,

    -- Validation result
    CASE
        WHEN CASE input_format
            WHEN 'ISO' THEN STR_TO_DATE(input_date, '%Y-%m-%d')
            WHEN 'US' THEN STR_TO_DATE(input_date, '%m/%d/%Y')
            WHEN 'EU' THEN STR_TO_DATE(input_date, '%d/%m/%Y')
            WHEN 'LONG' THEN STR_TO_DATE(input_date, '%M %d, %Y')
            WHEN 'COMPACT' THEN STR_TO_DATE(input_date, '%Y%m%d')
            ELSE NULL
        END IS NOT NULL THEN 'Valid'
        ELSE 'Invalid'
    END AS validation_status
FROM user_input;
/*
Result:
input_date      | input_format | parsed_date | validation_status
----------------|--------------|-------------|------------------
2024-03-15      | ISO          | 2024-03-15  | Valid
03/15/2024      | US           | 2024-03-15  | Valid
15/03/2024      | EU           | 2024-03-15  | Valid
March 15, 2024  | LONG         | 2024-03-15  | Valid
20240315        | COMPACT      | 2024-03-15  | Valid
invalid date    | INVALID      | NULL        | Invalid

Use Case: Form validation, data imports, user input processing
*/

DROP TEMPORARY TABLE user_input;

/*
=================================================================
FORMATTING IN WHERE CLAUSE
=================================================================
*/

-- Example 25: Filter using formatted dates
SELECT *
FROM Events
WHERE DATE_FORMAT(event_date, '%Y-%m') = '2024-03';
-- ⚠️ Not optimal for performance (can't use index)

-- Better approach:
SELECT *
FROM Events
WHERE event_date >= '2024-03-01'
  AND event_date < '2024-04-01';
-- ✓ Can use index on event_date

-- Example 26: Case-insensitive month name search
SELECT *
FROM Events
WHERE UPPER(DATE_FORMAT(event_date, '%M')) = 'MARCH';

/*
=================================================================
UPDATE WITH FORMATTING
=================================================================
*/

-- Example 27: Update dates from string format
UPDATE Events
SET event_date = STR_TO_DATE('03/15/2024 02:30 PM', '%m/%d/%Y %h:%i %p')
WHERE id = 1;

-- Example 28: Standardize date storage format
UPDATE Events
SET event_date = CAST(DATE_FORMAT(event_date, '%Y-%m-%d 00:00:00') AS DATETIME)
WHERE TIME(event_date) != '00:00:00';
-- Sets all times to midnight

/*
=================================================================
PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ⚠️ Avoid formatting in WHERE clause with large tables
-- ❌ Slow:
SELECT * FROM Events
WHERE DATE_FORMAT(event_date, '%Y-%m') = '2024-03';

-- ✓ Better:
SELECT * FROM Events
WHERE event_date >= '2024-03-01' AND event_date < '2024-04-01';

-- ⚠️ For display, format in SELECT, not WHERE
-- Format once at presentation layer, not in filtering

/*
=================================================================
DATABASE-SPECIFIC SUMMARY
=================================================================
*/

/*
MySQL:
- DATE_FORMAT(date, format) - flexible formatting
- STR_TO_DATE(string, format) - parse strings
- CAST(value AS type) - type conversion
- CONVERT(value, type) - alternative casting

PostgreSQL:
- TO_CHAR(timestamp, format) - format to string
- TO_DATE(string, format) - parse to date
- TO_TIMESTAMP(string, format) - parse to timestamp
- CAST(value AS type) - standard casting

SQL Server:
- FORMAT(value, format, culture) - .NET-style formatting
- CONVERT(type, value, style) - styled conversion
- CAST(value AS type) - standard casting
- PARSE(string AS type USING culture) - culture-aware parsing

Oracle:
- TO_CHAR(date, format) - format to string
- TO_DATE(string, format) - parse to date
- CAST(value AS type) - standard casting
- TO_TIMESTAMP(string, format) - parse to timestamp
*/

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: Wrong format specifier
SELECT DATE_FORMAT(event_date, '%Y/%M/%D');
-- %M is month NAME (March), should be %m for number
-- %D is day with suffix (15th), should be %d for number

-- ✓ CORRECT:
SELECT DATE_FORMAT(event_date, '%Y/%m/%d');

-- ❌ MISTAKE 2: Mismatched parsing format
SELECT STR_TO_DATE('15/03/2024', '%m/%d/%Y');
-- Input is DD/MM/YYYY but format expects MM/DD/YYYY
-- Results in: NULL or incorrect date (2024-15-03 is invalid)

-- ✓ CORRECT:
SELECT STR_TO_DATE('15/03/2024', '%d/%m/%Y');

-- ❌ MISTAKE 3: Formatting in WHERE clause
SELECT * FROM Events
WHERE DATE_FORMAT(event_date, '%Y') = '2024';
-- Can't use index, slow on large tables

-- ✓ CORRECT:
SELECT * FROM Events
WHERE event_date >= '2024-01-01' AND event_date < '2025-01-01';

-- ❌ MISTAKE 4: Assuming string is date
SELECT '2024-03-15' + INTERVAL 1 DAY;
-- Treats string as date (works in MySQL by accident)

-- ✓ EXPLICIT:
SELECT DATE('2024-03-15') + INTERVAL 1 DAY;
-- Or:
SELECT STR_TO_DATE('2024-03-15', '%Y-%m-%d') + INTERVAL 1 DAY;

-- ❌ MISTAKE 5: Timezone ignorance
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s');
-- NOW() uses server timezone, may differ from user timezone

-- ✓ BETTER: Be explicit
SELECT DATE_FORMAT(CONVERT_TZ(NOW(), 'UTC', 'America/New_York'), '%Y-%m-%d %H:%i:%s');

/*
=================================================================
HINGLISH SUMMARY
=================================================================

Date/Time Formatting aur Casting functions dates ko format karne aur
convert karne ke liye hain.

Main functions:

1. DATE_FORMAT (MySQL) - Date ko string mein format karna

   DATE_FORMAT(date, '%m/%d/%Y') → '03/15/2024'
   DATE_FORMAT(date, '%d/%m/%Y') → '15/03/2024'
   DATE_FORMAT(date, '%Y-%m-%d') → '2024-03-15'
   DATE_FORMAT(date, '%M %e, %Y') → 'March 15, 2024'

   Common specifiers:
   %Y = year (2024), %m = month (03), %d = day (15)
   %M = month name (March), %W = day name (Monday)
   %H = hour 24hr (14), %h = hour 12hr (02)
   %i = minute (30), %s = second (00)
   %p = AM/PM

2. STR_TO_DATE (MySQL) - String ko date mein parse karna

   STR_TO_DATE('03/15/2024', '%m/%d/%Y') → 2024-03-15
   STR_TO_DATE('15/03/2024', '%d/%m/%Y') → 2024-03-15
   STR_TO_DATE('March 15, 2024', '%M %d, %Y') → 2024-03-15

   Format string ko input ke saath match karna zaroori hai!

3. CAST - Standard type conversion

   CAST('2024-03-15' AS DATE) → 2024-03-15
   CAST(event_date AS CHAR) → '2024-03-15 14:30:00'
   CAST(event_date AS DATE) → 2024-03-15 (time remove)
   CAST(event_date AS TIME) → 14:30:00 (date remove)

4. CONVERT - Type conversion (MySQL aur SQL Server mein alag)

   MySQL: CONVERT(event_date, DATE)
   SQL Server: CONVERT(VARCHAR, date, style_code)

Real-world use cases:
- Reports: Different regions ke liye formats
  US: DATE_FORMAT(date, '%m/%d/%Y')
  Europe: DATE_FORMAT(date, '%d/%m/%Y')
  ISO: DATE_FORMAT(date, '%Y-%m-%d')

- Exports: File formats ke liye
  CSV: ISO format safest
  JSON: ISO 8601 format
  Filename: DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s')

- Parsing imports: Different formats se data
  STR_TO_DATE(input, format_based_on_source)

- Display: User-friendly formats
  DATE_FORMAT(date, '%W, %M %e, %Y at %h:%i %p')
  → 'Friday, March 15, 2024 at 02:30 PM'

Common patterns:
- US format: %m/%d/%Y (03/15/2024)
- Euro format: %d/%m/%Y (15/03/2024)
- ISO format: %Y-%m-%d (2024-03-15)
- Long format: %M %d, %Y (March 15, 2024)
- Full datetime: %Y-%m-%d %H:%i:%s
- Filename safe: %Y%m%d_%H%i%s (20240315_143000)

Important notes:
- Format specifiers case-sensitive hain
- %M = month NAME, %m = month NUMBER
- %W = day NAME, %w = day NUMBER
- Input aur format string match hona chahiye
- Performance: WHERE clause mein formatting avoid karo

Database differences:
- MySQL: DATE_FORMAT, STR_TO_DATE
- PostgreSQL: TO_CHAR, TO_DATE
- SQL Server: FORMAT, CONVERT with styles
- Oracle: TO_CHAR, TO_DATE

Performance tips:
- WHERE mein formatting se index use nahi hota (slow!)
- Better: Date ranges use karo
- Display formatting sirf SELECT mein karo
- Computed columns consider karo agar frequently format karna ho

Mistakes to avoid:
❌ Galat format specifier (%M instead of %m)
❌ Parsing format input se match nahi (%m/%d vs %d/%m)
❌ WHERE clause mein formatting (slow!)
❌ String ko date assume karna (explicit casting better)
❌ Timezone ignore karna (server vs user time)

Best practices:
✓ Hamesha ISO format store karo database mein
✓ Display time pe format karo, storage time pe nahi
✓ Format string carefully choose karo
✓ Input validation karo parsing se pehle
✓ Explicit casting use karo assumptions ki jagah
✓ Performance ke liye WHERE mein date ranges use karo

Remember:
- DATE_FORMAT = date to string
- STR_TO_DATE = string to date
- CAST = type conversion (standard)
- Format codes yaad rakho (%Y, %m, %d, %H, %i, %s)
- Input format aur parse format match hone chahiye
- Performance matters - formatting in WHERE is slow
- Different databases different syntax use karte hain

KEY TAKEAWAYS:
✓ DATE_FORMAT formats dates with pattern strings
✓ STR_TO_DATE parses strings to dates
✓ CAST/CONVERT for type conversions
✓ Format specifiers: %Y year, %m month, %d day
✓ Time: %H hour, %i minute, %s second
✓ Names: %M month name, %W day name
✓ Match input format when parsing
✓ Avoid formatting in WHERE clause
✓ Use ISO format for storage
✓ Format at display time, not storage
✓ Different databases use different syntax
✓ Validate before parsing
✓ Consider timezones in applications
✓ Performance: use date ranges, not formatting
✓ Test with various inputs and edge cases

=================================================================
*/

-- Complete example using multiple formatting functions:
SELECT
    event_name,
    event_date,
    created_at,

    -- Various date formats
    DATE_FORMAT(event_date, '%Y-%m-%d') AS iso_date,
    DATE_FORMAT(event_date, '%m/%d/%Y') AS us_date,
    DATE_FORMAT(event_date, '%d/%m/%Y') AS euro_date,
    DATE_FORMAT(event_date, '%M %e, %Y') AS long_date,

    -- Time formats
    DATE_FORMAT(event_date, '%H:%i') AS time_24hr,
    DATE_FORMAT(event_date, '%h:%i %p') AS time_12hr,

    -- Combined formats
    DATE_FORMAT(event_date, '%W, %M %e, %Y at %h:%i %p') AS full_format,
    DATE_FORMAT(event_date, '%Y%m%d_%H%i%s') AS filename_format,

    -- Type conversions
    CAST(event_date AS DATE) AS date_only,
    CAST(event_date AS TIME) AS time_only,

    -- Parsing example
    STR_TO_DATE('03/15/2024', '%m/%d/%Y') AS parsed_us_date,

    -- For exports
    CONCAT('"', event_name, '","', DATE_FORMAT(event_date, '%Y-%m-%d %H:%i:%s'), '"') AS csv_format

FROM Events
LIMIT 3;
