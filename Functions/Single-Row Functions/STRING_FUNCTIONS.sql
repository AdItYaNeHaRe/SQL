/*
=================================================================
QUERY PURPOSE: Manipulate, analyze, and extract data from strings
=================================================================

CONCEPT EXPLANATION (English):
String functions are built-in SQL functions that allow you to manipulate,
transform, and extract information from text/character data. They are
essential for:
- Data cleaning and standardization
- Formatting output for display
- Extracting specific parts of text
- Searching and pattern matching
- Calculating string properties

String functions are categorized into three main types:

1. MANIPULATION Functions - Transform and modify strings
   - CONCAT: Combine multiple strings into one
   - UPPER: Convert to uppercase
   - LOWER: Convert to lowercase
   - TRIM: Remove leading/trailing spaces
   - REPLACE: Replace occurrences of substring
   - REVERSE: Reverse string order
   - And more...

2. CALCULATION Functions - Measure and analyze strings
   - LENGTH/LEN: Get string length (character count)
   - CHAR_LENGTH: Count characters (multi-byte aware)
   - POSITION/LOCATE: Find substring position
   - ASCII: Get ASCII value of character
   - And more...

3. EXTRACTION Functions - Get parts of strings
   - LEFT: Extract characters from left
   - RIGHT: Extract characters from right
   - SUBSTRING/SUBSTR: Extract from middle
   - SUBSTRING_INDEX: Extract based on delimiter
   - MID: Extract from specified position
   - And more...

These functions can be used in:
- SELECT clause (display formatted data)
- WHERE clause (filter based on string conditions)
- UPDATE clause (modify existing string data)
- ORDER BY clause (sort by string properties)

CONCEPT EXPLANATION (Hinglish):
String functions built-in SQL functions hain jo aapko text/character data
ko manipulate, transform, aur extract karne dete hain. Yeh zaroori hain:
- Data cleaning aur standardization ke liye
- Output ko display ke liye format karna
- Text ke specific parts extract karna
- Searching aur pattern matching
- String properties calculate karna

String functions teen main types mein categorized hain:

1. MANIPULATION Functions - Strings ko transform aur modify karna
   - CONCAT: Multiple strings ko ek mein combine karna
   - UPPER: Uppercase mein convert karna
   - LOWER: Lowercase mein convert karna
   - TRIM: Leading/trailing spaces remove karna
   - REPLACE: Substring ke occurrences replace karna
   - REVERSE: String ko reverse karna
   - Aur bhi bahut...

2. CALCULATION Functions - Strings ko measure aur analyze karna
   - LENGTH/LEN: String length nikalna (character count)
   - CHAR_LENGTH: Characters count karna (multi-byte aware)
   - POSITION/LOCATE: Substring ki position dhoondhna
   - ASCII: Character ki ASCII value nikalna
   - Aur bhi bahut...

3. EXTRACTION Functions - Strings ke parts nikalna
   - LEFT: Left se characters extract karna
   - RIGHT: Right se characters extract karna
   - SUBSTRING/SUBSTR: Middle se extract karna
   - SUBSTRING_INDEX: Delimiter ke basis pe extract karna
   - MID: Specified position se extract karna
   - Aur bhi bahut...

Yeh functions use ho sakte hain:
- SELECT clause mein (formatted data display karna)
- WHERE clause mein (string conditions pe filter karna)
- UPDATE clause mein (existing string data modify karna)
- ORDER BY clause mein (string properties se sort karna)

USE CASES:
- Name formatting (first + last name, proper case)
- Email validation and extraction
- Phone number formatting
- Address parsing and standardization
- Data cleaning (removing extra spaces, special characters)
- Report generation (formatted text output)
- Search functionality (case-insensitive, partial matches)
- Data masking (hiding sensitive information)
- URL parsing and manipulation
- Product code generation and parsing

SAMPLE DATA (Employees table):

id | first_name | last_name | email                  | phone         | city
---|------------|-----------|------------------------|---------------|-------------
1  | john       | DOE       | john.doe@company.com   | 555-123-4567  | New York
2  | MARY       | smith     |  mary@email.com        | (555)234-5678 | los angeles
3  | Bob        | JOHNSON   | bob.johnson@firm.org   | 5551234567    | Chicago
4  | alice      | BROWN     | alice@test.com         | 555.345.6789  | houston

Note: Data intentionally has inconsistent formatting to demonstrate functions

=================================================================
SECTION 1: STRING MANIPULATION FUNCTIONS
=================================================================

1.1 CONCAT - Combine Multiple Strings
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CONCAT(string1, string2, ..., stringN)
Purpose: Combines multiple strings into one
Returns: Single concatenated string
*/

-- Example 1: Basic concatenation (Full name from parts)
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM Employees;
/*
Result:
first_name | last_name | full_name
-----------|-----------|-------------
john       | DOE       | john DOE
MARY       | smith     | MARY smith
Bob        | JOHNSON   | Bob JOHNSON
alice      | BROWN     | alice BROWN

Use Case: Creating full names, complete addresses, display labels
*/

-- Example 2: Concatenating with literals
SELECT
    first_name,
    email,
    CONCAT('Employee: ', first_name, ' (', email, ')') AS employee_info
FROM Employees;
/*
Result:
employee_info
----------------------------------------
Employee: john (john.doe@company.com)
Employee: MARY (mary@email.com)
Employee: Bob (bob.johnson@firm.org)
Employee: alice (alice@test.com)

Use Case: Creating formatted labels, descriptions, display text
*/

-- Example 3: Multiple columns concatenation
SELECT
    CONCAT(first_name, ' ', last_name, ' - ', city, ' - ', phone) AS contact_card
FROM Employees;
/*
Result:
contact_card
--------------------------------------------------
john DOE - New York - 555-123-4567
MARY smith - los angeles - (555)234-5678
Bob JOHNSON - Chicago - 5551234567
alice BROWN - houston - 555.345.6789

Use Case: Creating contact cards, mailing labels, formatted reports
*/

-- Example 4: CONCAT_WS (Concat With Separator) - MySQL specific
SELECT
    CONCAT_WS(' | ', first_name, last_name, city, phone) AS formatted_info
FROM Employees;
/*
Result:
formatted_info
--------------------------------------------------
john | DOE | New York | 555-123-4567
MARY | smith | los angeles | (555)234-5678
Bob | JOHNSON | Chicago | 5551234567
alice | BROWN | houston | 555.345.6789

Advantage: Separator (' | ') automatically added between each value
Use Case: CSV generation, pipe-delimited exports, formatted lists
*/

-- Example 5: Concatenation with NULL handling
SELECT
    first_name,
    CONCAT(first_name, ' ', last_name) AS name_basic,
    CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, '')) AS name_safe
FROM Employees;
/*
Note: If any value in CONCAT is NULL, entire result is NULL
COALESCE returns first non-NULL value (empty string '' if NULL)

Use Case: Safely concatenating fields that may contain NULL
*/

/*
1.2 UPPER - Convert to Uppercase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: UPPER(string)
Purpose: Converts all characters to uppercase
Returns: String in uppercase
*/

-- Example 6: Basic uppercase conversion
SELECT
    first_name,
    UPPER(first_name) AS first_name_upper,
    last_name,
    UPPER(last_name) AS last_name_upper
FROM Employees;
/*
Result:
first_name | first_name_upper | last_name | last_name_upper
-----------|------------------|-----------|----------------
john       | JOHN             | DOE       | DOE
MARY       | MARY             | smith     | SMITH
Bob        | BOB              | JOHNSON   | JOHNSON
alice      | ALICE            | BROWN     | BROWN

Use Case: Standardizing names, case-insensitive comparisons
*/

-- Example 7: Uppercase for case-insensitive search
SELECT *
FROM Employees
WHERE UPPER(first_name) = 'JOHN';
/*
Matches: 'john', 'John', 'JOHN', 'JoHn' (any case variation)

Use Case: Case-insensitive searches, user input matching
*/

-- Example 8: Standardizing full names
SELECT
    CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS standardized_name
FROM Employees;
/*
Result:
standardized_name
-----------------
JOHN DOE
MARY SMITH
BOB JOHNSON
ALICE BROWN

Use Case: Standardized data exports, official documents
*/

/*
1.3 LOWER - Convert to Lowercase
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: LOWER(string)
Purpose: Converts all characters to lowercase
Returns: String in lowercase
*/

-- Example 9: Basic lowercase conversion
SELECT
    email,
    LOWER(email) AS email_lowercase
FROM Employees;
/*
Result:
email                  | email_lowercase
-----------------------|------------------------
john.doe@company.com   | john.doe@company.com
 mary@email.com        |  mary@email.com
bob.johnson@firm.org   | bob.johnson@firm.org
alice@test.com         | alice@test.com

Use Case: Email normalization, username standardization
*/

-- Example 10: Lowercase for consistent storage
SELECT
    first_name,
    last_name,
    LOWER(CONCAT(first_name, '.', last_name, '@company.com')) AS generated_email
FROM Employees;
/*
Result:
generated_email
------------------------
john.doe@company.com
mary.smith@company.com
bob.johnson@company.com
alice.brown@company.com

Use Case: Auto-generating emails, usernames, slugs
*/

/*
1.4 TRIM - Remove Leading/Trailing Spaces
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  TRIM(string) - removes spaces from both ends
  LTRIM(string) - removes spaces from left
  RTRIM(string) - removes spaces from right
Purpose: Cleans whitespace from strings
Returns: String without leading/trailing spaces
*/

-- Example 11: Basic TRIM (both ends)
SELECT
    email,
    TRIM(email) AS email_trimmed,
    LENGTH(email) AS original_length,
    LENGTH(TRIM(email)) AS trimmed_length
FROM Employees;
/*
Result:
email              | email_trimmed     | original_length | trimmed_length
-------------------|-------------------|-----------------|----------------
 mary@email.com    | mary@email.com    | 15              | 14

Note: Row 2 has leading space that TRIM removes

Use Case: Data cleaning, user input sanitization
*/

-- Example 12: LTRIM (left side only)
SELECT
    '   hello   ' AS original,
    LTRIM('   hello   ') AS left_trimmed,
    RTRIM('   hello   ') AS right_trimmed,
    TRIM('   hello   ') AS both_trimmed;
/*
Result:
original     | left_trimmed | right_trimmed | both_trimmed
-------------|--------------|---------------|-------------
   hello     | hello        |    hello      | hello

Use Case: Selective space removal based on requirements
*/

-- Example 13: TRIM with specific characters (MySQL)
SELECT
    phone,
    TRIM(BOTH '()-. ' FROM phone) AS cleaned_phone
FROM Employees;
/*
Result:
phone          | cleaned_phone
---------------|---------------
555-123-4567   | 5551234567
(555)234-5678  | 5552345678
5551234567     | 5551234567
555.345.6789   | 5553456789

Note: Removes parentheses, hyphens, dots, and spaces

Use Case: Phone number normalization, data standardization
*/

/*
1.5 REPLACE - Replace Substring Occurrences
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: REPLACE(string, old_substring, new_substring)
Purpose: Replaces all occurrences of substring
Returns: String with replacements made
*/

-- Example 14: Basic replacement
SELECT
    phone,
    REPLACE(phone, '-', '') AS phone_no_dashes
FROM Employees;
/*
Result:
phone          | phone_no_dashes
---------------|----------------
555-123-4567   | 5551234567
(555)234-5678  | (555)2345678
5551234567     | 5551234567
555.345.6789   | 555.345.6789

Use Case: Removing formatting characters, standardizing data
*/

-- Example 15: Multiple replacements (chained)
SELECT
    phone,
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(phone, '-', ''),
            '(', ''),
        ')', ''),
    '.', '') AS phone_digits_only
FROM Employees;
/*
Result:
phone          | phone_digits_only
---------------|-------------------
555-123-4567   | 5551234567
(555)234-5678  | 5552345678
5551234567     | 5551234567
555.345.6789   | 5553456789

Use Case: Complete data cleaning, removing all special characters
*/

-- Example 16: Domain replacement in emails
SELECT
    email,
    REPLACE(email, '@company.com', '@newcompany.com') AS updated_email
FROM Employees;
/*
Result:
email                  | updated_email
-----------------------|-------------------------
john.doe@company.com   | john.doe@newcompany.com
mary@email.com         | mary@email.com
bob.johnson@firm.org   | bob.johnson@firm.org
alice@test.com         | alice@test.com

Use Case: Bulk email domain migration, data updates
*/

/*
1.6 REVERSE - Reverse String Order
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: REVERSE(string)
Purpose: Reverses character order
Returns: String with characters in reverse order
*/

-- Example 17: Basic reverse
SELECT
    first_name,
    REVERSE(first_name) AS first_name_reversed
FROM Employees;
/*
Result:
first_name | first_name_reversed
-----------|--------------------
john       | nhoj
MARY       | YRAM
Bob        | boB
alice      | ecila

Use Case: Palindrome checking, data obfuscation, puzzles
*/

-- Example 18: Palindrome check (advanced)
SELECT
    'racecar' AS word,
    'racecar' = REVERSE('racecar') AS is_palindrome;
/*
Result:
word    | is_palindrome
--------|---------------
racecar | 1 (TRUE)

Use Case: Data validation, word games
*/

/*
1.7 LPAD / RPAD - Pad Strings
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  LPAD(string, length, pad_string) - pad on left
  RPAD(string, length, pad_string) - pad on right
Purpose: Adds padding to reach desired length
Returns: Padded string
*/

-- Example 19: Left padding with zeros (ID formatting)
SELECT
    id,
    LPAD(id, 5, '0') AS formatted_id
FROM Employees;
/*
Result:
id | formatted_id
---|-------------
1  | 00001
2  | 00002
3  | 00003
4  | 00004

Use Case: Invoice numbers, order IDs, fixed-width formatting
*/

-- Example 20: Right padding for alignment
SELECT
    first_name,
    RPAD(first_name, 15, '.') AS padded_name
FROM Employees;
/*
Result:
first_name | padded_name
-----------|------------------
john       | john...........
MARY       | MARY...........
Bob        | Bob............
alice      | alice..........

Use Case: Creating aligned text, dot leaders in reports
*/

/*
1.8 REPEAT - Repeat String Multiple Times
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: REPEAT(string, count)
Purpose: Repeats string specified number of times
Returns: Repeated string
*/

-- Example 21: Creating separator lines
SELECT
    first_name,
    REPEAT('=', 20) AS separator,
    last_name
FROM Employees
LIMIT 1;
/*
Result:
first_name | separator            | last_name
-----------|----------------------|-----------
john       | ====================  | DOE

Use Case: Report formatting, visual separators
*/

-- Example 22: Creating masked data
SELECT
    first_name,
    CONCAT(LEFT(first_name, 1), REPEAT('*', LENGTH(first_name) - 1)) AS masked_name
FROM Employees;
/*
Result:
first_name | masked_name
-----------|------------
john       | j***
MARY       | M***
Bob        | B**
alice      | a****

Use Case: Data privacy, masking sensitive information
*/

/*
=================================================================
SECTION 2: STRING CALCULATION FUNCTIONS
=================================================================

2.1 LENGTH / LEN - Get String Length
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  LENGTH(string) - MySQL, PostgreSQL
  LEN(string) - SQL Server
  CHAR_LENGTH(string) - Character count (multi-byte aware)
Purpose: Counts number of characters/bytes
Returns: Integer representing length
*/

-- Example 23: Basic length calculation
SELECT
    first_name,
    LENGTH(first_name) AS name_length,
    email,
    LENGTH(email) AS email_length
FROM Employees;
/*
Result:
first_name | name_length | email                | email_length
-----------|-------------|----------------------|-------------
john       | 4           | john.doe@company.com | 20
MARY       | 4           | mary@email.com       | 15 (includes space!)
Bob        | 3           | bob.johnson@firm.org | 20
alice      | 5           | alice@test.com       | 14

Use Case: Validation, character counting, data quality checks
*/

-- Example 24: Finding long/short values
SELECT
    first_name,
    LENGTH(first_name) AS length
FROM Employees
WHERE LENGTH(first_name) > 4;
/*
Result:
first_name | length
-----------|-------
alice      | 5

Use Case: Data validation, finding outliers
*/

-- Example 25: Password length validation
SELECT
    'password123' AS password,
    LENGTH('password123') AS length,
    CASE
        WHEN LENGTH('password123') >= 8 THEN 'Valid'
        ELSE 'Too Short'
    END AS validation_status;
/*
Result:
password    | length | validation_status
------------|--------|------------------
password123 | 11     | Valid

Use Case: Password requirements, input validation
*/

/*
2.2 POSITION / LOCATE - Find Substring Position
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  POSITION(substring IN string) - Standard SQL
  LOCATE(substring, string) - MySQL
  CHARINDEX(substring, string) - SQL Server
Purpose: Finds position of first occurrence of substring
Returns: Position (1-based index), or 0 if not found
*/

-- Example 26: Finding @ symbol in email
SELECT
    email,
    LOCATE('@', email) AS at_position
FROM Employees;
/*
Result:
email                | at_position
---------------------|------------
john.doe@company.com | 9
mary@email.com       | 6
bob.johnson@firm.org | 12
alice@test.com       | 6

Use Case: Email parsing, substring location
*/

-- Example 27: Extracting domain from email (using LOCATE)
SELECT
    email,
    SUBSTRING(email, LOCATE('@', email) + 1) AS domain
FROM Employees;
/*
Result:
email                | domain
---------------------|-------------
john.doe@company.com | company.com
mary@email.com       | email.com
bob.johnson@firm.org | firm.org
alice@test.com       | test.com

Use Case: Email domain extraction, parsing
*/

-- Example 28: Checking if substring exists
SELECT
    email,
    CASE
        WHEN LOCATE('company', email) > 0 THEN 'Company Email'
        ELSE 'External Email'
    END AS email_type
FROM Employees;
/*
Result:
email                | email_type
---------------------|---------------
john.doe@company.com | Company Email
mary@email.com       | External Email
bob.johnson@firm.org | External Email
alice@test.com       | External Email

Use Case: Email classification, pattern matching
*/

/*
2.3 ASCII - Get ASCII Value
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: ASCII(string)
Purpose: Returns ASCII value of first character
Returns: Integer (ASCII code)
*/

-- Example 29: ASCII values of names
SELECT
    first_name,
    ASCII(first_name) AS first_char_ascii,
    CHAR(ASCII(first_name)) AS first_character
FROM Employees;
/*
Result:
first_name | first_char_ascii | first_character
-----------|------------------|----------------
john       | 106              | j
MARY       | 77               | M
Bob        | 66               | B
alice      | 97               | a

Use Case: Character encoding, sorting, validation
*/

-- Example 30: Sorting by ASCII value
SELECT
    first_name,
    ASCII(first_name) AS ascii_val
FROM Employees
ORDER BY ASCII(first_name);
/*
Result (ordered by ASCII):
first_name | ascii_val
-----------|----------
Bob        | 66        ← Uppercase 'B' (lower ASCII)
MARY       | 77        ← Uppercase 'M'
alice      | 97        ← Lowercase 'a' (higher ASCII)
john       | 106       ← Lowercase 'j'

Use Case: Custom sorting, character-based ordering
*/

/*
=================================================================
SECTION 3: STRING EXTRACTION FUNCTIONS
=================================================================

3.1 LEFT - Extract from Left
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: LEFT(string, length)
Purpose: Extracts specified number of characters from left
Returns: Substring from beginning
*/

-- Example 31: First name initial
SELECT
    first_name,
    LEFT(first_name, 1) AS initial
FROM Employees;
/*
Result:
first_name | initial
-----------|--------
john       | j
MARY       | M
Bob        | B
alice      | a

Use Case: Initials, abbreviations, prefixes
*/

-- Example 32: First 3 characters
SELECT
    first_name,
    LEFT(first_name, 3) AS short_name
FROM Employees;
/*
Result:
first_name | short_name
-----------|------------
john       | joh
MARY       | MAR
Bob        | Bob
alice      | ali

Use Case: Short codes, nicknames, display names
*/

-- Example 33: Phone area code extraction
SELECT
    phone,
    LEFT(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), 3) AS area_code
FROM Employees;
/*
Result:
phone          | area_code
---------------|----------
555-123-4567   | 555
(555)234-5678  | 555
5551234567     | 555
555.345.6789   | 555

Use Case: Area code extraction, phone number parsing
*/

/*
3.2 RIGHT - Extract from Right
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: RIGHT(string, length)
Purpose: Extracts specified number of characters from right
Returns: Substring from end
*/

-- Example 34: Last 2 characters
SELECT
    first_name,
    RIGHT(first_name, 2) AS last_two
FROM Employees;
/*
Result:
first_name | last_two
-----------|----------
john       | hn
MARY       | RY
Bob        | ob
alice      | ce

Use Case: Suffixes, endings, last digits
*/

-- Example 35: File extension extraction
SELECT
    'document.pdf' AS filename,
    RIGHT('document.pdf', 3) AS extension;
/*
Result:
filename     | extension
-------------|----------
document.pdf | pdf

Use Case: File type detection, extension parsing
*/

-- Example 36: Last 4 digits of phone
SELECT
    phone,
    RIGHT(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), 4) AS last_four
FROM Employees;
/*
Result:
phone          | last_four
---------------|----------
555-123-4567   | 4567
(555)234-5678  | 5678
5551234567     | 4567
555.345.6789   | 6789

Use Case: Partial phone display, last digits for verification
*/

/*
3.3 SUBSTRING / SUBSTR - Extract from Middle
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax:
  SUBSTRING(string, start, length) - Standard
  SUBSTR(string, start, length) - MySQL, Oracle
  SUBSTRING(string FROM start FOR length) - PostgreSQL alternative
Purpose: Extracts substring from specified position
Returns: Substring from middle of string
Note: Positions are 1-based (first character is 1)
*/

-- Example 37: Extract middle characters
SELECT
    email,
    SUBSTRING(email, 1, LOCATE('@', email) - 1) AS username
FROM Employees;
/*
Result:
email                | username
---------------------|----------
john.doe@company.com | john.doe
mary@email.com       | mary
bob.johnson@firm.org | bob.johnson
alice@test.com       | alice

Use Case: Email username extraction, parsing
*/

-- Example 38: Extract with fixed position and length
SELECT
    phone,
    SUBSTRING(phone, 1, 3) AS part1,
    SUBSTRING(phone, 5, 3) AS part2,
    SUBSTRING(phone, 9, 4) AS part3
FROM Employees
WHERE phone = '555-123-4567';
/*
Result:
phone        | part1 | part2 | part3
-------------|-------|-------|------
555-123-4567 | 555   | 123   | 4567

Use Case: Parsing formatted strings, extracting components
*/

-- Example 39: Substring from position to end
SELECT
    email,
    SUBSTRING(email, LOCATE('@', email)) AS domain_with_at
FROM Employees;
/*
Result:
email                | domain_with_at
---------------------|---------------
john.doe@company.com | @company.com
mary@email.com       | @email.com
bob.johnson@firm.org | @firm.org
alice@test.com       | @test.com

Note: Without length parameter, extracts to end of string

Use Case: Extracting remainder of string from position
*/

-- Example 40: MID function (MySQL - same as SUBSTRING)
SELECT
    first_name,
    MID(first_name, 2, 2) AS middle_chars
FROM Employees;
/*
Result:
first_name | middle_chars
-----------|-------------
john       | oh
MARY       | AR
Bob        | ob
alice      | li

MID is alias for SUBSTRING in MySQL

Use Case: Same as SUBSTRING - extracting middle portions
*/

/*
3.4 SUBSTRING_INDEX - Extract Based on Delimiter
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: SUBSTRING_INDEX(string, delimiter, count)
Purpose: Returns substring before/after delimiter occurrence
  - Positive count: Returns everything before Nth occurrence
  - Negative count: Returns everything after Nth occurrence from end
Returns: Substring based on delimiter
Note: MySQL specific function
*/

-- Example 41: Extract first name from email (before dot)
SELECT
    email,
    SUBSTRING_INDEX(email, '.', 1) AS first_part
FROM Employees;
/*
Result:
email                | first_part
---------------------|------------
john.doe@company.com | john
mary@email.com       | mary@email
bob.johnson@firm.org | bob
alice@test.com       | alice@test

Use Case: Parsing delimited strings, extracting components
*/

-- Example 42: Extract domain from email
SELECT
    email,
    SUBSTRING_INDEX(email, '@', -1) AS domain
FROM Employees;
/*
Result:
email                | domain
---------------------|-------------
john.doe@company.com | company.com
mary@email.com       | email.com
bob.johnson@firm.org | firm.org
alice@test.com       | test.com

Negative -1: Gets everything AFTER last @ symbol

Use Case: Email domain extraction, URL parsing
*/

-- Example 43: Nested SUBSTRING_INDEX for complex parsing
SELECT
    email,
    SUBSTRING_INDEX(SUBSTRING_INDEX(email, '@', 1), '.', 1) AS first_name_from_email
FROM Employees;
/*
Result:
email                | first_name_from_email
---------------------|----------------------
john.doe@company.com | john
mary@email.com       | mary
bob.johnson@firm.org | bob
alice@test.com       | alice

Inner: Gets username part (before @)
Outer: Gets first name (before first dot)

Use Case: Multi-level parsing, extracting nested components
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================

Example 44: Complete Name Formatting (Title Case)
*/
SELECT
    first_name,
    last_name,
    CONCAT(
        UPPER(LEFT(first_name, 1)),
        LOWER(SUBSTRING(first_name, 2)),
        ' ',
        UPPER(LEFT(last_name, 1)),
        LOWER(SUBSTRING(last_name, 2))
    ) AS proper_name
FROM Employees;
/*
Result:
first_name | last_name | proper_name
-----------|-----------|-------------
john       | DOE       | John Doe
MARY       | smith     | Mary Smith
Bob        | JOHNSON   | Bob Johnson
alice      | BROWN     | Alice Brown

Use Case: Name standardization, display formatting
*/

-- Example 45: Email Generation
SELECT
    first_name,
    last_name,
    LOWER(CONCAT(
        TRIM(first_name),
        '.',
        TRIM(last_name),
        '@newcompany.com'
    )) AS generated_email
FROM Employees;
/*
Result:
first_name | last_name | generated_email
-----------|-----------|---------------------------
john       | DOE       | john.doe@newcompany.com
MARY       | smith     | mary.smith@newcompany.com
Bob        | JOHNSON   | bob.johnson@newcompany.com
alice      | BROWN     | alice.brown@newcompany.com

Use Case: Automated email generation, user provisioning
*/

-- Example 46: Phone Number Standardization
SELECT
    phone AS original_phone,
    CONCAT(
        '(',
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), '.', ''), 1, 3),
        ') ',
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), '.', ''), 4, 3),
        '-',
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), '.', ''), 7, 4)
    ) AS formatted_phone
FROM Employees;
/*
Result:
original_phone | formatted_phone
---------------|------------------
555-123-4567   | (555) 123-4567
(555)234-5678  | (555) 234-5678
5551234567     | (555) 123-4567
555.345.6789   | (555) 345-6789

Use Case: Phone number standardization, consistent formatting
*/

-- Example 47: Data Masking (Privacy)
SELECT
    first_name,
    email,
    CONCAT(
        LEFT(email, 3),
        REPEAT('*', LENGTH(email) - LOCATE('@', email) - 2),
        RIGHT(email, LOCATE('@', email) + 2)
    ) AS masked_email
FROM Employees;
/*
Result (approximate - masking logic):
first_name | email                | masked_email
-----------|----------------------|-----------------
john       | john.doe@company.com | joh***@company.com
MARY       | mary@email.com       | mar***@email.com

Use Case: PII protection, data privacy, secure display
*/

-- Example 48: Initials Extraction
SELECT
    first_name,
    last_name,
    CONCAT(
        UPPER(LEFT(first_name, 1)),
        '.',
        UPPER(LEFT(last_name, 1)),
        '.'
    ) AS initials
FROM Employees;
/*
Result:
first_name | last_name | initials
-----------|-----------|----------
john       | DOE       | J.D.
MARY       | smith     | M.S.
Bob        | JOHNSON   | B.J.
alice      | BROWN     | A.B.

Use Case: Abbreviated names, display in limited space
*/

-- Example 49: Username Generation
SELECT
    first_name,
    last_name,
    LOWER(CONCAT(
        LEFT(first_name, 1),
        last_name,
        LPAD(id, 3, '0')
    )) AS username
FROM Employees;
/*
Result:
first_name | last_name | username
-----------|-----------|-------------
john       | DOE       | jdoe001
MARY       | smith     | msmith002
Bob        | JOHNSON   | bjohnson003
alice      | BROWN     | abrown004

Use Case: System username generation, unique identifiers
*/

-- Example 50: Address Parsing (hypothetical)
SELECT
    '123 Main St, Apt 4B, New York, NY 10001' AS full_address,
    SUBSTRING_INDEX('123 Main St, Apt 4B, New York, NY 10001', ',', 1) AS street,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX('123 Main St, Apt 4B, New York, NY 10001', ',', 2), ',', -1)) AS apartment,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX('123 Main St, Apt 4B, New York, NY 10001', ',', 3), ',', -1)) AS city,
    TRIM(SUBSTRING_INDEX('123 Main St, Apt 4B, New York, NY 10001', ',', -1)) AS state_zip;
/*
Result:
full_address                              | street      | apartment | city     | state_zip
------------------------------------------|-------------|-----------|----------|-------------
123 Main St, Apt 4B, New York, NY 10001   | 123 Main St | Apt 4B    | New York | NY 10001

Use Case: Address parsing, data normalization
*/

/*
=================================================================
STRING FUNCTIONS IN WHERE CLAUSE
=================================================================
*/

-- Example 51: Case-insensitive search
SELECT *
FROM Employees
WHERE UPPER(first_name) = 'JOHN';
-- Matches: john, John, JOHN, JoHn

-- Example 52: Partial name search
SELECT *
FROM Employees
WHERE first_name LIKE CONCAT('%', 'oh', '%');
-- Matches any name containing 'oh': john

-- Example 53: Email domain filtering
SELECT *
FROM Employees
WHERE SUBSTRING_INDEX(email, '@', -1) = 'company.com';
-- Only company.com emails

-- Example 54: Length validation
SELECT *
FROM Employees
WHERE LENGTH(TRIM(first_name)) >= 4;
-- Names with 4+ characters (after trimming)

-- Example 55: Find names starting with specific letter
SELECT *
FROM Employees
WHERE LEFT(UPPER(first_name), 1) = 'J';
-- Names starting with J (case-insensitive)

/*
=================================================================
STRING FUNCTIONS IN UPDATE
=================================================================
*/

-- Example 56: Standardize names to title case
UPDATE Employees
SET first_name = CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2))),
    last_name = CONCAT(UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2)));
/*
Before:
john, DOE → After: John, Doe
MARY, smith → After: Mary, Smith

Use Case: Data cleanup, standardization
*/

-- Example 57: Normalize email addresses
UPDATE Employees
SET email = LOWER(TRIM(email));
/*
Before:
 mary@email.com  → After: mary@email.com (trimmed and lowercase)

Use Case: Email normalization
*/

-- Example 58: Remove phone formatting
UPDATE Employees
SET phone = REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), '.', '');
/*
Before:
555-123-4567 → After: 5551234567
(555)234-5678 → After: 5552345678

Use Case: Phone number standardization
*/

/*
=================================================================
STRING FUNCTIONS IN ORDER BY
=================================================================
*/

-- Example 59: Sort by name length
SELECT first_name, LENGTH(first_name) AS name_length
FROM Employees
ORDER BY LENGTH(first_name), first_name;
/*
Result (ordered by length, then alphabetically):
first_name | name_length
-----------|------------
Bob        | 3
MARY       | 4
john       | 4
alice      | 5

Use Case: Sorting by string properties
*/

-- Example 60: Sort by email domain
SELECT email
FROM Employees
ORDER BY SUBSTRING_INDEX(email, '@', -1);
/*
Result (ordered by domain):
email
----------------------
john.doe@company.com
mary@email.com
bob.johnson@firm.org
alice@test.com

Use Case: Grouping by domain, organizational sorting
*/

/*
=================================================================
PERFORMANCE CONSIDERATIONS
=================================================================
*/

-- ⚠️ PERFORMANCE NOTE 1: Functions on indexed columns prevent index usage
-- ❌ Slow (can't use index on first_name):
SELECT * FROM Employees WHERE UPPER(first_name) = 'JOHN';

-- ✓ Better: Create functional index (MySQL 8.0+, PostgreSQL):
CREATE INDEX idx_first_name_upper ON Employees((UPPER(first_name)));

-- ⚠️ PERFORMANCE NOTE 2: LIKE with leading wildcard is slow
-- ❌ Slow (full table scan):
SELECT * FROM Employees WHERE email LIKE '%@company.com';

-- ✓ Better (can use index):
SELECT * FROM Employees WHERE email LIKE 'john%';

-- ⚠️ PERFORMANCE NOTE 3: Complex nested functions are expensive
-- ❌ Slow (multiple function calls per row):
SELECT UPPER(TRIM(REPLACE(CONCAT(first_name, last_name), ' ', ''))) FROM Employees;

-- ✓ Better: Break into steps or use computed columns

/*
=================================================================
DATABASE-SPECIFIC VARIATIONS
=================================================================
*/

-- MySQL:
CONCAT(str1, str2)          -- Concatenation
LENGTH(str)                 -- Byte length
CHAR_LENGTH(str)            -- Character length
SUBSTRING(str, pos, len)    -- Extraction
LOCATE(substr, str)         -- Find position
UPPER(str), LOWER(str)      -- Case conversion

-- PostgreSQL:
str1 || str2                -- Concatenation (also CONCAT)
LENGTH(str)                 -- Character length
SUBSTRING(str FROM pos FOR len)  -- Extraction
POSITION(substr IN str)     -- Find position
UPPER(str), LOWER(str)      -- Case conversion

-- SQL Server:
str1 + str2                 -- Concatenation (also CONCAT)
LEN(str)                    -- Length (excludes trailing spaces!)
DATALENGTH(str)             -- Byte length (includes trailing spaces)
SUBSTRING(str, pos, len)    -- Extraction
CHARINDEX(substr, str)      -- Find position
UPPER(str), LOWER(str)      -- Case conversion

-- Oracle:
str1 || str2                -- Concatenation (also CONCAT for 2 strings)
LENGTH(str)                 -- Character length
SUBSTR(str, pos, len)       -- Extraction
INSTR(str, substr)          -- Find position
UPPER(str), LOWER(str)      -- Case conversion

/*
=================================================================
COMMON MISTAKES TO AVOID
=================================================================
*/

-- ❌ MISTAKE 1: NULL in CONCAT returns NULL
SELECT CONCAT(first_name, ' ', NULL, ' ', last_name) AS full_name;
-- Result: NULL (entire result is NULL if any part is NULL)

-- ✓ CORRECT: Use COALESCE or CONCAT_WS
SELECT CONCAT(first_name, ' ', COALESCE(middle_name, ''), ' ', last_name) AS full_name;
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name;

-- ❌ MISTAKE 2: 0-based vs 1-based indexing
SELECT SUBSTRING(first_name, 0, 2);  -- ❌ Returns 1 char (starts at 1, not 0)

-- ✓ CORRECT: Use 1-based index
SELECT SUBSTRING(first_name, 1, 2);  -- ✓ Returns first 2 chars

-- ❌ MISTAKE 3: Using functions in WHERE on indexed columns
SELECT * FROM Employees WHERE UPPER(email) = 'JOHN@TEST.COM';
-- ❌ Can't use index on email

-- ✓ BETTER: Store data consistently, compare directly
SELECT * FROM Employees WHERE email = 'john@test.com';

-- ❌ MISTAKE 4: Not trimming user input
UPDATE Employees SET email = '  user@test.com  ';  -- ❌ Spaces stored

-- ✓ CORRECT: Always trim
UPDATE Employees SET email = TRIM('  user@test.com  ');

-- ❌ MISTAKE 5: Assuming LENGTH counts characters (it counts bytes!)
SELECT LENGTH('café');  -- Returns 5 in MySQL (é is 2 bytes in UTF-8)
SELECT CHAR_LENGTH('café');  -- ✓ Returns 4 (actual character count)

/*
=================================================================
HINGLISH SUMMARY
=================================================================

String functions teen categories mein aate hain:

1. MANIPULATION Functions - Strings ko modify karna

   CONCAT('Hello', ' ', 'World') → 'Hello World'
   - Multiple strings ko ek mein jodna

   UPPER('john') → 'JOHN', LOWER('JOHN') → 'john'
   - Case change karna (uppercase/lowercase)

   TRIM('  hello  ') → 'hello'
   - Extra spaces remove karna (양 taraf se)

   REPLACE('555-123-4567', '-', '') → '5551234567'
   - Substring ko replace karna

   REVERSE('hello') → 'olleh'
   - String ko ulta karna

2. CALCULATION Functions - String properties nikalna

   LENGTH('hello') → 5
   - String ki length nikalna (kitne characters)

   LOCATE('@', 'john@test.com') → 5
   - Substring ki position dhoondhna

   ASCII('A') → 65
   - Character ka ASCII code nikalna

3. EXTRACTION Functions - String ke parts nikalna

   LEFT('hello', 2) → 'he'
   - Left se characters nikalna

   RIGHT('hello', 2) → 'lo'
   - Right se characters nikalna

   SUBSTRING('hello', 2, 3) → 'ell'
   - Middle se characters nikalna (position 2 se 3 chars)

   SUBSTRING_INDEX('john.doe@company.com', '@', 1) → 'john.doe'
   - Delimiter ke basis pe extract karna

Real-world use cases:
- Name formatting: CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2)))
- Email generation: LOWER(CONCAT(first, '.', last, '@company.com'))
- Phone formatting: Remove special chars, add consistent format
- Data masking: CONCAT(LEFT(email, 3), '***', RIGHT(email, 10))
- Username creation: LOWER(CONCAT(LEFT(first, 1), last))

Common patterns:
- Title case: First letter UPPER, rest LOWER
- Clean spaces: TRIM spaces from sides
- Remove formatting: REPLACE multiple times
- Extract domain: SUBSTRING_INDEX(email, '@', -1)
- Check length: LENGTH(password) >= 8

Important notes:
- NULL in CONCAT → whole result NULL (use COALESCE)
- Positions are 1-based (first char is 1, not 0)
- LENGTH counts bytes, CHAR_LENGTH counts characters
- Functions in WHERE prevent index usage
- Different databases have slight syntax differences

Performance tips:
- Avoid functions on indexed columns in WHERE
- Use functional indexes when needed
- Store data in consistent format
- TRIM user input before storing
- LIKE with leading % is slow

Mistakes to avoid:
❌ CONCAT with NULL (result NULL ho jata hai)
❌ 0-based indexing assume karna (1-based hai)
❌ UPPER/LOWER in WHERE on indexed columns (slow)
❌ TRIM na karna user input
❌ LENGTH for character count (bytes count karta hai)

Remember:
- CONCAT = join, UPPER/LOWER = case, TRIM = spaces
- LENGTH = count, LOCATE = find, ASCII = code
- LEFT = start, RIGHT = end, SUBSTRING = middle
- Always handle NULL properly
- Test with actual data
- Consider performance impact

KEY TAKEAWAYS:
✓ CONCAT joins strings, handles multiple arguments
✓ UPPER/LOWER for case standardization
✓ TRIM removes leading/trailing spaces
✓ REPLACE substitutes substrings
✓ LENGTH/LEN counts characters (use CHAR_LENGTH for UTF-8)
✓ LOCATE/POSITION finds substring location
✓ LEFT/RIGHT extract from ends
✓ SUBSTRING extracts from middle (1-based indexing)
✓ SUBSTRING_INDEX extracts based on delimiter
✓ Functions in WHERE can prevent index usage
✓ Always TRIM user input
✓ Handle NULL in concatenation (use COALESCE)
✓ Consider database-specific syntax variations
✓ Use for data cleaning, formatting, parsing
✓ Test thoroughly with edge cases

=================================================================
*/

-- Complete example showcasing multiple string functions together:
SELECT
    -- Original data
    first_name AS original_first,
    last_name AS original_last,
    email AS original_email,

    -- Formatted full name (Title Case)
    CONCAT(
        UPPER(LEFT(TRIM(first_name), 1)),
        LOWER(SUBSTRING(TRIM(first_name), 2)),
        ' ',
        UPPER(LEFT(TRIM(last_name), 1)),
        LOWER(SUBSTRING(TRIM(last_name), 2))
    ) AS formatted_name,

    -- Clean email (trimmed, lowercase)
    LOWER(TRIM(email)) AS clean_email,

    -- Email username
    SUBSTRING(LOWER(TRIM(email)), 1, LOCATE('@', LOWER(TRIM(email))) - 1) AS username,

    -- Email domain
    SUBSTRING_INDEX(LOWER(TRIM(email)), '@', -1) AS domain,

    -- Initials
    CONCAT(UPPER(LEFT(first_name, 1)), '.', UPPER(LEFT(last_name, 1)), '.') AS initials,

    -- Name length analysis
    LENGTH(TRIM(first_name)) AS first_name_length,
    LENGTH(TRIM(last_name)) AS last_name_length,

    -- Generated username
    LOWER(CONCAT(LEFT(first_name, 1), last_name)) AS generated_username

FROM Employees;
