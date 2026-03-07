/*
=================================================================
QUERY PURPOSE: Master CASE statements for conditional logic in SQL
=================================================================

CONCEPT EXPLANATION (English):
The CASE statement is SQL's way of implementing conditional logic - similar
to if-else statements in programming languages. It allows you to:
- Return different values based on conditions
- Implement complex business logic
- Transform data conditionally
- Create calculated columns with logic
- Categorize and classify data

CASE is one of the most powerful SQL features because it enables:
- Multi-way branching (like switch/case in programming)
- Inline conditional transformations
- Dynamic value assignment
- Complex data categorization
- Readable business logic implementation

There are TWO forms of CASE:

1. SIMPLE CASE (Equality-based)
   Syntax:
   CASE expression
       WHEN value1 THEN result1
       WHEN value2 THEN result2
       ...
       ELSE default_result
   END

   - Compares expression against specific values
   - Uses equality (=) comparison only
   - Cleaner for simple equality checks

2. SEARCHED CASE (Condition-based)
   Syntax:
   CASE
       WHEN condition1 THEN result1
       WHEN condition2 THEN result2
       ...
       ELSE default_result
   END

   - Each WHEN has its own condition
   - Can use any comparison operators (>, <, !=, etc.)
   - Can use AND, OR, NOT
   - More flexible and powerful
   - Most commonly used form

Key characteristics:
- Evaluates conditions top to bottom
- Returns result of FIRST matching condition
- ELSE is optional (but recommended)
- If no match and no ELSE, returns NULL
- Can be used in SELECT, WHERE, ORDER BY, HAVING
- Can be nested for complex logic

CONCEPT EXPLANATION (Hinglish):
CASE statement SQL ka conditional logic implement karne ka tarika hai -
programming languages ke if-else statements jaisa. Yeh aapko allow karta hai:
- Conditions ke basis pe different values return karna
- Complex business logic implement karna
- Conditionally data transform karna
- Logic ke saath calculated columns banana
- Data ko categorize aur classify karna

CASE SQL ka sabse powerful feature hai kyunki yeh enable karta hai:
- Multi-way branching (programming ke switch/case jaisa)
- Inline conditional transformations
- Dynamic value assignment
- Complex data categorization
- Readable business logic implementation

CASE ke DO forms hain:

1. SIMPLE CASE (Equality-based)
   Syntax:
   CASE expression
       WHEN value1 THEN result1
       WHEN value2 THEN result2
       ...
       ELSE default_result
   END

   - Expression ko specific values se compare karta hai
   - Sirf equality (=) comparison use karta hai
   - Simple equality checks ke liye cleaner

2. SEARCHED CASE (Condition-based)
   Syntax:
   CASE
       WHEN condition1 THEN result1
       WHEN condition2 THEN result2
       ...
       ELSE default_result
   END

   - Har WHEN ki apni condition hai
   - Koi bhi comparison operators use kar sakte ho (>, <, !=, etc.)
   - AND, OR, NOT use kar sakte ho
   - Zyada flexible aur powerful
   - Sabse commonly used form

Key characteristics:
- Conditions ko upar se neeche evaluate karta hai
- PEHLI matching condition ka result return karta hai
- ELSE optional hai (lekin recommended)
- Agar koi match nahi aur ELSE nahi to NULL return
- SELECT, WHERE, ORDER BY, HAVING mein use ho sakta hai
- Complex logic ke liye nested kar sakte ho

USE CASES:
- Data categorization: Group values into categories
- Status mapping: Convert codes to readable text
- Grade calculation: Convert scores to letter grades
- Price tiers: Classify products by price range
- Conditional calculations: Different formulas based on conditions
- Data validation: Flag invalid/suspicious data
- Report formatting: Display-friendly transformations
- Business rules: Implement complex business logic
- Priority assignment: Assign priorities based on criteria
- Conditional aggregation: Sum/count with conditions

SAMPLE DATA (Students table):

id | student_name  | score | attendance | behavior | extracurricular | financial_aid
---|---------------|-------|------------|----------|-----------------|---------------
1  | Alice Johnson | 95    | 98         | Excellent| Yes             | No
2  | Bob Smith     | 78    | 85         | Good     | No              | Yes
3  | Carol White   | 65    | 70         | Average  | Yes             | No
4  | David Brown   | 45    | 60         | Poor     | No              | Yes
5  | Emma Davis    | 88    | 92         | Excellent| Yes             | No
6  | Frank Miller  | 72    | 88         | Good     | Yes             | Yes
7  | Grace Lee     | 55    | 65         | Average  | No              | No
8  | Henry Wilson  | 92    | 95         | Excellent| Yes             | No

Additional sample (Orders table):

id | customer_id | order_date | total_amount | status      | region    | payment_method
---|-------------|------------|--------------|-------------|-----------|---------------
1  | 101         | 2024-03-01 | 1250.00      | Delivered   | North     | Credit Card
2  | 102         | 2024-03-02 | 75.50        | Shipped     | South     | PayPal
3  | 103         | 2024-03-03 | 3500.00      | Processing  | East      | Wire Transfer
4  | 104         | 2024-03-04 | 125.00       | Cancelled   | West      | Debit Card
5  | 105         | 2024-03-05 | 850.00       | Delivered   | North     | Credit Card
6  | 106         | 2024-03-06 | 45.00        | Pending     | South     | Cash
7  | 107         | 2024-03-07 | 2200.00      | Shipped     | East      | Credit Card
8  | 108         | 2024-03-08 | 500.00       | Delivered   | West      | PayPal

=================================================================
SECTION 1: SIMPLE CASE STATEMENT
=================================================================

1.1 Basic Simple CASE
━━━━━━━━━━━━━━━━━━━━

Syntax: CASE column WHEN value THEN result END
Purpose: Map specific values to results
Use: When checking equality against known values
*/

-- Example 1: Simple CASE for status mapping
SELECT
    id,
    customer_id,
    total_amount,
    status,

    -- Simple CASE: Map status codes to descriptions
    CASE status
        WHEN 'Delivered' THEN '✓ Complete'
        WHEN 'Shipped' THEN '→ In Transit'
        WHEN 'Processing' THEN '⚙ Being Prepared'
        WHEN 'Pending' THEN '⏳ Awaiting Payment'
        WHEN 'Cancelled' THEN '✗ Cancelled'
    END AS status_display
FROM Orders;
/*
Result:
id | customer_id | total_amount | status     | status_display
---|-------------|--------------|------------|------------------
1  | 101         | 1250.00      | Delivered  | ✓ Complete
2  | 102         | 75.50        | Shipped    | → In Transit
3  | 103         | 3500.00      | Processing | ⚙ Being Prepared
4  | 104         | 125.00       | Cancelled  | ✗ Cancelled
5  | 105         | 850.00       | Delivered  | ✓ Complete
6  | 106         | 45.00        | Pending    | ⏳ Awaiting Payment
7  | 107         | 2200.00      | Shipped    | → In Transit
8  | 108         | 500.00       | Delivered  | ✓ Complete

Explanation:
- CASE checks status column against each WHEN value
- Returns corresponding THEN result for match
- Simple and readable for exact matches

Use Case: Status displays, code mapping, lookup transformations
*/

-- Example 2: Simple CASE with ELSE clause
SELECT
    id,
    student_name,
    behavior,

    -- Map behavior to emoji with default
    CASE behavior
        WHEN 'Excellent' THEN '⭐⭐⭐'
        WHEN 'Good' THEN '⭐⭐'
        WHEN 'Average' THEN '⭐'
        WHEN 'Poor' THEN '❌'
        ELSE '❓ Unknown'  -- Default for unexpected values
    END AS behavior_rating
FROM Students;
/*
Result:
id | student_name  | behavior  | behavior_rating
---|---------------|-----------|----------------
1  | Alice Johnson | Excellent | ⭐⭐⭐
2  | Bob Smith     | Good      | ⭐⭐
3  | Carol White   | Average   | ⭐
4  | David Brown   | Poor      | ❌
5  | Emma Davis    | Excellent | ⭐⭐⭐
6  | Frank Miller  | Good      | ⭐⭐
7  | Grace Lee     | Average   | ⭐
8  | Henry Wilson  | Excellent | ⭐⭐⭐

Explanation:
- ELSE provides default for unmatched values
- Without ELSE, unmatched values return NULL
- Best practice: Always include ELSE

Use Case: Rating displays, categorical mappings with defaults
*/

-- Example 3: Simple CASE for multiple columns
SELECT
    id,
    student_name,
    extracurricular,
    financial_aid,

    -- Map Yes/No to readable text
    CASE extracurricular
        WHEN 'Yes' THEN 'Active'
        WHEN 'No' THEN 'Not Active'
        ELSE 'Unknown'
    END AS activity_status,

    CASE financial_aid
        WHEN 'Yes' THEN 'Receives Aid'
        WHEN 'No' THEN 'No Aid'
        ELSE 'Unknown'
    END AS aid_status
FROM Students;
/*
Result:
id | student_name  | extracurricular | financial_aid | activity_status | aid_status
---|---------------|-----------------|---------------|-----------------|-------------
1  | Alice Johnson | Yes             | No            | Active          | No Aid
2  | Bob Smith     | No              | Yes           | Not Active      | Receives Aid
3  | Carol White   | Yes             | No            | Active          | No Aid
4  | David Brown   | No              | Yes           | Not Active      | Receives Aid
5  | Emma Davis    | Yes             | No            | Active          | No Aid
6  | Frank Miller  | Yes             | Yes           | Active          | Receives Aid
7  | Grace Lee     | No              | No            | Not Active      | No Aid
8  | Henry Wilson  | Yes             | No            | Active          | No Aid

Use Case: Boolean-to-text conversion, multi-column transformations
*/

/*
1.2 Simple CASE in Calculations
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Use Simple CASE to assign different calculation values
*/

-- Example 4: Simple CASE for region-based pricing
SELECT
    id,
    total_amount,
    region,

    -- Different tax rates by region
    CASE region
        WHEN 'North' THEN 8.5
        WHEN 'South' THEN 7.0
        WHEN 'East' THEN 9.0
        WHEN 'West' THEN 7.5
        ELSE 8.0
    END AS tax_rate,

    -- Calculate tax based on region
    ROUND(total_amount * (
        CASE region
            WHEN 'North' THEN 0.085
            WHEN 'South' THEN 0.070
            WHEN 'East' THEN 0.090
            WHEN 'West' THEN 0.075
            ELSE 0.080
        END
    ), 2) AS tax_amount,

    -- Total with tax
    ROUND(total_amount * (1 +
        CASE region
            WHEN 'North' THEN 0.085
            WHEN 'South' THEN 0.070
            WHEN 'East' THEN 0.090
            WHEN 'West' THEN 0.075
            ELSE 0.080
        END
    ), 2) AS total_with_tax
FROM Orders;
/*
Result:
id | total_amount | region | tax_rate | tax_amount | total_with_tax
---|--------------|--------|----------|------------|---------------
1  | 1250.00      | North  | 8.5      | 106.25     | 1356.25
2  | 75.50        | South  | 7.0      | 5.29       | 80.79
3  | 3500.00      | East   | 9.0      | 315.00     | 3815.00
4  | 125.00       | West   | 7.5      | 9.38       | 134.38
5  | 850.00       | North  | 8.5      | 72.25      | 922.25
6  | 45.00        | South  | 7.0      | 3.15       | 48.15
7  | 2200.00      | East   | 9.0      | 198.00     | 2398.00
8  | 500.00       | West   | 7.5      | 37.50      | 537.50

Use Case: Regional pricing, tax calculations, location-based logic
*/

/*
=================================================================
SECTION 2: SEARCHED CASE STATEMENT
=================================================================

2.1 Basic Searched CASE with Conditions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: CASE WHEN condition THEN result END
Purpose: Evaluate complex conditions
Use: When you need comparison operators, ranges, or logic
*/

-- Example 5: Searched CASE for grade calculation
SELECT
    id,
    student_name,
    score,

    -- Calculate letter grade based on score ranges
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score >= 80 THEN 'B'
        WHEN score >= 70 THEN 'C'
        WHEN score >= 60 THEN 'D'
        ELSE 'F'
    END AS letter_grade,

    -- More detailed grade with +/-
    CASE
        WHEN score >= 97 THEN 'A+'
        WHEN score >= 93 THEN 'A'
        WHEN score >= 90 THEN 'A-'
        WHEN score >= 87 THEN 'B+'
        WHEN score >= 83 THEN 'B'
        WHEN score >= 80 THEN 'B-'
        WHEN score >= 77 THEN 'C+'
        WHEN score >= 73 THEN 'C'
        WHEN score >= 70 THEN 'C-'
        WHEN score >= 60 THEN 'D'
        ELSE 'F'
    END AS detailed_grade
FROM Students;
/*
Result:
id | student_name  | score | letter_grade | detailed_grade
---|---------------|-------|--------------|----------------
1  | Alice Johnson | 95    | A            | A+
2  | Bob Smith     | 78    | C            | C+
3  | Carol White   | 65    | D            | D
4  | David Brown   | 45    | F            | F
5  | Emma Davis    | 88    | B            | B+
6  | Frank Miller  | 72    | C            | C
7  | Grace Lee     | 55    | F            | F
8  | Henry Wilson  | 92    | A            | A-

Explanation:
- Conditions evaluated top to bottom
- First TRUE condition determines result
- Order matters! (90-100 before 80-90)
- ELSE catches all remaining cases

Use Case: Grading systems, performance ratings, tier classification
*/

-- Example 6: Searched CASE with multiple conditions (AND, OR)
SELECT
    id,
    student_name,
    score,
    attendance,
    behavior,

    -- Academic standing based on multiple criteria
    CASE
        WHEN score >= 90 AND attendance >= 95 AND behavior = 'Excellent'
            THEN 'Honor Roll'
        WHEN score >= 80 AND attendance >= 90
            THEN 'Good Standing'
        WHEN score >= 60 AND attendance >= 75
            THEN 'Satisfactory'
        WHEN score < 60 OR attendance < 70
            THEN 'Needs Improvement'
        ELSE 'Under Review'
    END AS academic_standing,

    -- Scholarship eligibility
    CASE
        WHEN score >= 90 AND (attendance >= 95 OR extracurricular = 'Yes')
            THEN 'Eligible'
        WHEN score >= 85 AND attendance >= 90 AND extracurricular = 'Yes'
            THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS scholarship_eligible
FROM Students;
/*
Result:
id | student_name  | score | attendance | behavior  | academic_standing  | scholarship_eligible
---|---------------|-------|------------|-----------|-------------------|-----------------------
1  | Alice Johnson | 95    | 98         | Excellent | Honor Roll        | Eligible
2  | Bob Smith     | 78    | 85         | Good      | Satisfactory      | Not Eligible
3  | Carol White   | 65    | 70         | Average   | Needs Improvement | Not Eligible
4  | David Brown   | 45    | 60         | Poor      | Needs Improvement | Not Eligible
5  | Emma Davis    | 88    | 92         | Excellent | Good Standing     | Eligible
6  | Frank Miller  | 72    | 88         | Good      | Satisfactory      | Not Eligible
7  | Grace Lee     | 55    | 65         | Average   | Needs Improvement | Not Eligible
8  | Henry Wilson  | 92    | 95         | Excellent | Honor Roll        | Eligible

Use Case: Complex eligibility rules, multi-criteria categorization
*/

-- Example 7: Searched CASE for price tier classification
SELECT
    id,
    total_amount,
    status,
    region,

    -- Order value category
    CASE
        WHEN total_amount >= 2000 THEN 'Premium'
        WHEN total_amount >= 500 THEN 'Standard'
        WHEN total_amount >= 100 THEN 'Basic'
        ELSE 'Small'
    END AS order_category,

    -- Priority based on multiple factors
    CASE
        WHEN total_amount >= 2000 AND region IN ('North', 'East') THEN 'High Priority'
        WHEN total_amount >= 1000 THEN 'Medium Priority'
        WHEN status = 'Pending' AND total_amount < 100 THEN 'Low Priority'
        ELSE 'Normal Priority'
    END AS processing_priority,

    -- Shipping speed recommendation
    CASE
        WHEN total_amount >= 1000 THEN 'Express (Free)'
        WHEN total_amount >= 500 THEN 'Fast (Discounted)'
        WHEN total_amount >= 100 THEN 'Standard'
        ELSE 'Economy'
    END AS shipping_tier
FROM Orders;
/*
Result:
id | total_amount | status     | region | order_category | processing_priority | shipping_tier
---|--------------|------------|--------|----------------|---------------------|----------------
1  | 1250.00      | Delivered  | North  | Standard       | High Priority       | Express (Free)
2  | 75.50        | Shipped    | South  | Small          | Normal Priority     | Economy
3  | 3500.00      | Processing | East   | Premium        | High Priority       | Express (Free)
4  | 125.00       | Cancelled  | West   | Basic          | Normal Priority     | Standard
5  | 850.00       | Delivered  | North  | Standard       | Normal Priority     | Fast (Discounted)
6  | 45.00        | Pending    | South  | Small          | Low Priority        | Economy
7  | 2200.00      | Shipped    | East   | Premium        | High Priority       | Express (Free)
8  | 500.00       | Delivered  | West   | Standard       | Normal Priority     | Fast (Discounted)

Use Case: Customer segmentation, priority assignment, tier systems
*/

/*
2.2 CASE with Calculated Conditions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Use calculations within CASE conditions
*/

-- Example 8: CASE with calculated fields
SELECT
    id,
    student_name,
    score,
    attendance,

    -- Weighted average (60% score, 40% attendance)
    ROUND((score * 0.6) + (attendance * 0.4), 2) AS weighted_avg,

    -- Grade based on weighted average
    CASE
        WHEN (score * 0.6) + (attendance * 0.4) >= 90 THEN 'A'
        WHEN (score * 0.6) + (attendance * 0.4) >= 80 THEN 'B'
        WHEN (score * 0.6) + (attendance * 0.4) >= 70 THEN 'C'
        WHEN (score * 0.6) + (attendance * 0.4) >= 60 THEN 'D'
        ELSE 'F'
    END AS final_grade,

    -- Performance vs potential
    CASE
        WHEN score >= attendance THEN 'Meeting Potential'
        WHEN score >= attendance - 10 THEN 'Slight Underperformance'
        ELSE 'Significant Gap'
    END AS performance_analysis
FROM Students;
/*
Result:
id | student_name  | score | attendance | weighted_avg | final_grade | performance_analysis
---|---------------|-------|------------|--------------|-------------|----------------------
1  | Alice Johnson | 95    | 98         | 96.20        | A           | Meeting Potential
2  | Bob Smith     | 78    | 85         | 80.80        | B           | Meeting Potential
3  | Carol White   | 65    | 70         | 67.00        | D           | Meeting Potential
4  | David Brown   | 45    | 60         | 51.00        | F           | Slight Underperformance
5  | Emma Davis    | 88    | 92         | 89.60        | B           | Meeting Potential
6  | Frank Miller  | 72    | 88         | 78.40        | C           | Slight Underperformance
7  | Grace Lee     | 55    | 65         | 59.00        | F           | Meeting Potential
8  | Henry Wilson  | 92    | 95         | 93.20        | A           | Meeting Potential

Use Case: Weighted calculations, performance metrics, comparative analysis
*/

/*
=================================================================
SECTION 3: NESTED CASE STATEMENTS
=================================================================

3.1 CASE within CASE
━━━━━━━━━━━━━━━━━━━

Nest CASE statements for complex multi-level logic
*/

-- Example 9: Nested CASE for complex classification
SELECT
    id,
    student_name,
    score,
    attendance,
    behavior,
    extracurricular,

    -- Complex scholarship decision with nested logic
    CASE
        WHEN score >= 90 THEN
            CASE
                WHEN attendance >= 95 AND behavior = 'Excellent' THEN 'Full Scholarship'
                WHEN attendance >= 90 THEN 'Partial Scholarship (75%)'
                ELSE 'Partial Scholarship (50%)'
            END
        WHEN score >= 80 THEN
            CASE
                WHEN extracurricular = 'Yes' AND attendance >= 90 THEN 'Partial Scholarship (50%)'
                WHEN attendance >= 85 THEN 'Partial Scholarship (25%)'
                ELSE 'Merit Recognition'
            END
        WHEN score >= 70 THEN
            CASE
                WHEN extracurricular = 'Yes' THEN 'Merit Recognition'
                ELSE 'No Scholarship'
            END
        ELSE 'No Scholarship'
    END AS scholarship_award
FROM Students;
/*
Result:
id | student_name  | score | attendance | behavior  | extracurricular | scholarship_award
---|---------------|-------|------------|-----------|-----------------|-------------------------
1  | Alice Johnson | 95    | 98         | Excellent | Yes             | Full Scholarship
2  | Bob Smith     | 78    | 85         | Good      | No              | No Scholarship
3  | Carol White   | 65    | 70         | Average   | Yes             | No Scholarship
4  | David Brown   | 45    | 60         | Poor      | No              | No Scholarship
5  | Emma Davis    | 88    | 92         | Excellent | Yes             | Partial Scholarship (50%)
6  | Frank Miller  | 72    | 88         | Good      | Yes             | Merit Recognition
7  | Grace Lee     | 55    | 65         | Average   | No              | No Scholarship
8  | Henry Wilson  | 92    | 95         | Excellent | Yes             | Full Scholarship

Explanation:
- Outer CASE categorizes by score
- Inner CASE refines based on additional criteria
- Complex decision tree in single expression

Use Case: Complex eligibility rules, multi-tiered systems, decision trees
*/

-- Example 10: Nested CASE for customer segmentation
SELECT
    id,
    total_amount,
    status,
    region,
    payment_method,

    -- Multi-dimensional customer segmentation
    CASE
        WHEN total_amount >= 2000 THEN
            CASE
                WHEN status = 'Delivered' AND payment_method = 'Credit Card'
                    THEN 'VIP - Loyal'
                WHEN status IN ('Delivered', 'Shipped')
                    THEN 'VIP - Active'
                ELSE 'VIP - Potential'
            END
        WHEN total_amount >= 500 THEN
            CASE
                WHEN status = 'Delivered' THEN 'Premium - Regular'
                WHEN status = 'Cancelled' THEN 'Premium - At Risk'
                ELSE 'Premium - New'
            END
        ELSE
            CASE
                WHEN status = 'Cancelled' THEN 'Standard - Lost'
                WHEN status = 'Pending' THEN 'Standard - Potential'
                ELSE 'Standard - Active'
            END
    END AS customer_segment
FROM Orders;
/*
Result:
id | total_amount | status     | payment_method | customer_segment
---|--------------|------------|----------------|-------------------
1  | 1250.00      | Delivered  | Credit Card    | Premium - Regular
2  | 75.50        | Shipped    | PayPal         | Standard - Active
3  | 3500.00      | Processing | Wire Transfer  | VIP - Potential
4  | 125.00       | Cancelled  | Debit Card     | Standard - Lost
5  | 850.00       | Delivered  | Credit Card    | Premium - Regular
6  | 45.00        | Pending    | Cash           | Standard - Potential
7  | 2200.00      | Shipped    | Credit Card    | VIP - Active
8  | 500.00       | Delivered  | PayPal         | Premium - Regular

Use Case: Customer segmentation, RFM analysis, tier management
*/

/*
=================================================================
SECTION 4: CASE IN DIFFERENT CLAUSES
=================================================================

4.1 CASE in WHERE Clause
━━━━━━━━━━━━━━━━━━━━━━━

Use CASE in WHERE for dynamic filtering
*/

-- Example 11: CASE in WHERE for conditional filtering
SELECT
    id,
    student_name,
    score,
    attendance,
    financial_aid
FROM Students
WHERE
    -- Dynamic threshold based on financial aid status
    CASE
        WHEN financial_aid = 'Yes' THEN score >= 60  -- Lower bar for aid recipients
        ELSE score >= 70  -- Higher bar for others
    END;
/*
Result:
id | student_name  | score | attendance | financial_aid
---|---------------|-------|------------|---------------
1  | Alice Johnson | 95    | 98         | No
2  | Bob Smith     | 78    | 85         | Yes
5  | Emma Davis    | 88    | 92         | No
6  | Frank Miller  | 72    | 88         | Yes
8  | Henry Wilson  | 92    | 95         | No

Explanation:
- Financial aid students: need score >= 60
- Non-aid students: need score >= 70
- Dynamic filtering based on student type

Use Case: Conditional filtering, dynamic thresholds, policy-based queries
*/

-- Example 12: Complex CASE in WHERE
SELECT
    id,
    total_amount,
    status,
    region
FROM Orders
WHERE
    CASE
        -- High-value orders: only completed ones
        WHEN total_amount >= 1000 THEN status IN ('Delivered', 'Shipped')
        -- Medium orders: exclude cancelled
        WHEN total_amount >= 100 THEN status != 'Cancelled'
        -- Small orders: all statuses OK
        ELSE TRUE
    END;
/*
Result: Orders meeting value-based criteria

Use Case: Conditional inclusion, tiered filtering
*/

/*
4.2 CASE in ORDER BY Clause
━━━━━━━━━━━━━━━━━━━━━━━━━━

Use CASE for custom sorting logic
*/

-- Example 13: CASE in ORDER BY for priority sorting
SELECT
    id,
    total_amount,
    status,
    region
FROM Orders
ORDER BY
    -- Sort by custom priority
    CASE status
        WHEN 'Pending' THEN 1      -- Highest priority
        WHEN 'Processing' THEN 2
        WHEN 'Shipped' THEN 3
        WHEN 'Delivered' THEN 4
        WHEN 'Cancelled' THEN 5    -- Lowest priority
        ELSE 6
    END,
    total_amount DESC;  -- Then by amount within each status
/*
Result:
id | total_amount | status     | region
---|--------------|------------|--------
6  | 45.00        | Pending    | South     ← Priority 1
3  | 3500.00      | Processing | East      ← Priority 2
7  | 2200.00      | Shipped    | East      ← Priority 3
2  | 75.50        | Shipped    | South
1  | 1250.00      | Delivered  | North     ← Priority 4
5  | 850.00       | Delivered  | North
8  | 500.00       | Delivered  | West
4  | 125.00       | Cancelled  | West      ← Priority 5

Explanation:
- Custom sort order based on status importance
- Then sorts by amount within each status group
- Pending orders appear first regardless of amount

Use Case: Priority queues, custom sort orders, workflow management
*/

-- Example 14: Complex multi-level CASE in ORDER BY
SELECT
    id,
    student_name,
    score,
    attendance,
    behavior
FROM Students
ORDER BY
    -- Primary sort: Behavior priority
    CASE behavior
        WHEN 'Excellent' THEN 1
        WHEN 'Good' THEN 2
        WHEN 'Average' THEN 3
        WHEN 'Poor' THEN 4
        ELSE 5
    END,
    -- Secondary sort: Score descending within behavior group
    score DESC,
    -- Tertiary sort: Attendance descending
    attendance DESC;
/*
Result: Students sorted by behavior, then score, then attendance

Use Case: Multi-criteria ranking, prioritized sorting
*/

/*
4.3 CASE in GROUP BY and HAVING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Use CASE to create dynamic groupings
*/

-- Example 15: CASE in GROUP BY for dynamic bucketing
SELECT
    -- Create age groups
    CASE
        WHEN score >= 90 THEN 'A Students (90+)'
        WHEN score >= 80 THEN 'B Students (80-89)'
        WHEN score >= 70 THEN 'C Students (70-79)'
        WHEN score >= 60 THEN 'D Students (60-69)'
        ELSE 'F Students (<60)'
    END AS grade_category,

    COUNT(*) AS student_count,
    ROUND(AVG(score), 2) AS avg_score,
    ROUND(AVG(attendance), 2) AS avg_attendance,
    MIN(score) AS min_score,
    MAX(score) AS max_score
FROM Students
GROUP BY
    CASE
        WHEN score >= 90 THEN 'A Students (90+)'
        WHEN score >= 80 THEN 'B Students (80-89)'
        WHEN score >= 70 THEN 'C Students (70-79)'
        WHEN score >= 60 THEN 'D Students (60-69)'
        ELSE 'F Students (<60)'
    END
ORDER BY avg_score DESC;
/*
Result:
grade_category      | student_count | avg_score | avg_attendance | min_score | max_score
--------------------|---------------|-----------|----------------|-----------|----------
A Students (90+)    | 3             | 93.33     | 95.00          | 92        | 95
B Students (80-89)  | 1             | 88.00     | 92.00          | 88        | 88
C Students (70-79)  | 2             | 75.00     | 86.50          | 72        | 78
D Students (60-69)  | 1             | 65.00     | 70.00          | 65        | 65
F Students (<60)    | 2             | 50.00     | 62.50          | 45        | 55

Explanation:
- CASE creates dynamic groups based on score ranges
- GROUP BY uses same CASE logic
- Aggregates calculated for each group

Use Case: Bucketing, cohort analysis, segment reporting
*/

-- Example 16: CASE with HAVING for conditional filtering
SELECT
    region,

    -- Count by order size category
    SUM(CASE WHEN total_amount >= 1000 THEN 1 ELSE 0 END) AS large_orders,
    SUM(CASE WHEN total_amount BETWEEN 100 AND 999 THEN 1 ELSE 0 END) AS medium_orders,
    SUM(CASE WHEN total_amount < 100 THEN 1 ELSE 0 END) AS small_orders,

    -- Revenue by category
    SUM(CASE WHEN total_amount >= 1000 THEN total_amount ELSE 0 END) AS large_revenue,
    SUM(CASE WHEN total_amount < 100 THEN total_amount ELSE 0 END) AS small_revenue,

    -- Total
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY region
HAVING
    -- Only regions with significant large orders
    SUM(CASE WHEN total_amount >= 1000 THEN 1 ELSE 0 END) >= 2;
/*
Result:
region | large_orders | medium_orders | small_orders | large_revenue | small_revenue | total_orders | total_revenue
-------|--------------|---------------|--------------|---------------|---------------|--------------|---------------
East   | 2            | 0             | 0            | 5700.00       | 0.00          | 2            | 5700.00
North  | 2            | 0             | 0            | 2100.00       | 0.00          | 2            | 2100.00

Explanation:
- CASE used within SUM for conditional counting/summing
- HAVING filters groups using CASE condition
- Only regions with 2+ large orders shown

Use Case: Conditional aggregation, segment filtering, KPI reporting
*/

/*
=================================================================
SECTION 5: CASE FOR PIVOT/UNPIVOT OPERATIONS
=================================================================

5.1 Pivoting Data with CASE
━━━━━━━━━━━━━━━━━━━━━━━━━━

Use CASE to transform rows into columns
*/

-- Example 17: Pivot order counts by status
SELECT
    region,

    -- Count orders by status (pivot)
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_count,
    SUM(CASE WHEN status = 'Shipped' THEN 1 ELSE 0 END) AS shipped_count,
    SUM(CASE WHEN status = 'Processing' THEN 1 ELSE 0 END) AS processing_count,
    SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pending_count,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_count,

    -- Revenue by status
    SUM(CASE WHEN status = 'Delivered' THEN total_amount ELSE 0 END) AS delivered_revenue,
    SUM(CASE WHEN status = 'Shipped' THEN total_amount ELSE 0 END) AS shipped_revenue,

    -- Totals
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY region
ORDER BY region;
/*
Result:
region | delivered_count | shipped_count | processing_count | pending_count | cancelled_count | delivered_revenue | shipped_revenue | total_orders | total_revenue
-------|-----------------|---------------|------------------|---------------|-----------------|-------------------|-----------------|--------------|---------------
East   | 0               | 1             | 1                | 0             | 0               | 0.00              | 2200.00         | 2            | 5700.00
North  | 2               | 0             | 0                | 0             | 0               | 2100.00           | 0.00            | 2            | 2100.00
South  | 0               | 1             | 0                | 1             | 0               | 0.00              | 75.50           | 2            | 120.50
West   | 1               | 0             | 0                | 0             | 1               | 500.00            | 0.00            | 2            | 625.00

Use Case: Cross-tab reports, status dashboards, KPI matrices
*/

-- Example 18: Pivot with percentages
SELECT
    region,
    COUNT(*) AS total_orders,

    -- Count by category
    SUM(CASE WHEN total_amount >= 1000 THEN 1 ELSE 0 END) AS large_count,
    SUM(CASE WHEN total_amount BETWEEN 100 AND 999 THEN 1 ELSE 0 END) AS medium_count,
    SUM(CASE WHEN total_amount < 100 THEN 1 ELSE 0 END) AS small_count,

    -- Percentage breakdown
    ROUND(SUM(CASE WHEN total_amount >= 1000 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS large_pct,
    ROUND(SUM(CASE WHEN total_amount BETWEEN 100 AND 999 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS medium_pct,
    ROUND(SUM(CASE WHEN total_amount < 100 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS small_pct
FROM Orders
GROUP BY region
ORDER BY region;
/*
Result:
region | total_orders | large_count | medium_count | small_count | large_pct | medium_pct | small_pct
-------|--------------|-------------|--------------|-------------|-----------|------------|----------
East   | 2            | 2           | 0            | 0           | 100.0     | 0.0        | 0.0
North  | 2            | 1           | 1            | 0           | 50.0      | 50.0       | 0.0
South  | 2            | 0           | 0            | 2           | 0.0       | 0.0        | 100.0
West   | 2            | 0           | 2            | 0           | 0.0       | 100.0      | 0.0

Use Case: Percentage distributions, composition analysis
*/

/*
=================================================================
SECTION 6: ADVANCED CASE TECHNIQUES
=================================================================

6.1 CASE with Subqueries
━━━━━━━━━━━━━━━━━━━━━━━

Use CASE with subquery results for complex logic
*/

-- Example 19: CASE comparing to subquery results
SELECT
    id,
    student_name,
    score,

    -- Compare to class average
    (SELECT AVG(score) FROM Students) AS class_average,

    CASE
        WHEN score > (SELECT AVG(score) FROM Students) + 10
            THEN 'Well Above Average'
        WHEN score > (SELECT AVG(score) FROM Students)
            THEN 'Above Average'
        WHEN score > (SELECT AVG(score) FROM Students) - 10
            THEN 'Below Average'
        ELSE 'Well Below Average'
    END AS performance_vs_class
FROM Students;
/*
Result:
id | student_name  | score | class_average | performance_vs_class
---|---------------|-------|---------------|----------------------
1  | Alice Johnson | 95    | 73.25         | Well Above Average
2  | Bob Smith     | 78    | 73.25         | Above Average
3  | Carol White   | 65    | 73.25         | Below Average
4  | David Brown   | 45    | 73.25         | Well Below Average
5  | Emma Davis    | 88    | 73.25         | Well Above Average
6  | Frank Miller  | 72    | 73.25         | Below Average
7  | Grace Lee     | 55    | 73.25         | Well Below Average
8  | Henry Wilson  | 92    | 73.25         | Well Above Average

Use Case: Relative performance, peer comparison, benchmarking
*/

/*
6.2 Multiple CASE Statements for Complex Scoring
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Combine multiple CASE results
*/

-- Example 20: Multi-factor scoring system
SELECT
    id,
    student_name,
    score,
    attendance,
    behavior,
    extracurricular,

    -- Individual component scores
    CASE
        WHEN score >= 90 THEN 40
        WHEN score >= 80 THEN 35
        WHEN score >= 70 THEN 30
        WHEN score >= 60 THEN 25
        ELSE 20
    END AS score_points,

    CASE
        WHEN attendance >= 95 THEN 30
        WHEN attendance >= 90 THEN 25
        WHEN attendance >= 85 THEN 20
        WHEN attendance >= 75 THEN 15
        ELSE 10
    END AS attendance_points,

    CASE behavior
        WHEN 'Excellent' THEN 20
        WHEN 'Good' THEN 15
        WHEN 'Average' THEN 10
        ELSE 5
    END AS behavior_points,

    CASE extracurricular
        WHEN 'Yes' THEN 10
        ELSE 0
    END AS activity_points,

    -- Total composite score
    (CASE
        WHEN score >= 90 THEN 40
        WHEN score >= 80 THEN 35
        WHEN score >= 70 THEN 30
        WHEN score >= 60 THEN 25
        ELSE 20
    END +
    CASE
        WHEN attendance >= 95 THEN 30
        WHEN attendance >= 90 THEN 25
        WHEN attendance >= 85 THEN 20
        WHEN attendance >= 75 THEN 15
        ELSE 10
    END +
    CASE behavior
        WHEN 'Excellent' THEN 20
        WHEN 'Good' THEN 15
        WHEN 'Average' THEN 10
        ELSE 5
    END +
    CASE extracurricular
        WHEN 'Yes' THEN 10
        ELSE 0
    END) AS total_points,

    -- Final grade based on total points
    CASE
        WHEN (CASE WHEN score >= 90 THEN 40 WHEN score >= 80 THEN 35 WHEN score >= 70 THEN 30 WHEN score >= 60 THEN 25 ELSE 20 END +
              CASE WHEN attendance >= 95 THEN 30 WHEN attendance >= 90 THEN 25 WHEN attendance >= 85 THEN 20 WHEN attendance >= 75 THEN 15 ELSE 10 END +
              CASE behavior WHEN 'Excellent' THEN 20 WHEN 'Good' THEN 15 WHEN 'Average' THEN 10 ELSE 5 END +
              CASE extracurricular WHEN 'Yes' THEN 10 ELSE 0 END) >= 90 THEN 'A+'
        WHEN (CASE WHEN score >= 90 THEN 40 WHEN score >= 80 THEN 35 WHEN score >= 70 THEN 30 WHEN score >= 60 THEN 25 ELSE 20 END +
              CASE WHEN attendance >= 95 THEN 30 WHEN attendance >= 90 THEN 25 WHEN attendance >= 85 THEN 20 WHEN attendance >= 75 THEN 15 ELSE 10 END +
              CASE behavior WHEN 'Excellent' THEN 20 WHEN 'Good' THEN 15 WHEN 'Average' THEN 10 ELSE 5 END +
              CASE extracurricular WHEN 'Yes' THEN 10 ELSE 0 END) >= 80 THEN 'A'
        WHEN (CASE WHEN score >= 90 THEN 40 WHEN score >= 80 THEN 35 WHEN score >= 70 THEN 30 WHEN score >= 60 THEN 25 ELSE 20 END +
              CASE WHEN attendance >= 95 THEN 30 WHEN attendance >= 90 THEN 25 WHEN attendance >= 85 THEN 20 WHEN attendance >= 75 THEN 15 ELSE 10 END +
              CASE behavior WHEN 'Excellent' THEN 20 WHEN 'Good' THEN 15 WHEN 'Average' THEN 10 ELSE 5 END +
              CASE extracurricular WHEN 'Yes' THEN 10 ELSE 0 END) >= 70 THEN 'B'
        ELSE 'C'
    END AS final_grade
FROM Students;
/*
Result: Complex scoring with breakdown

Use Case: Weighted scoring, multi-criteria evaluation, holistic assessment
*/

/*
=================================================================
COMPREHENSIVE REAL-WORLD EXAMPLE
=================================================================
*/

-- Example 21: Complete Student Report Card
SELECT
    id,
    student_name,
    score,
    attendance,
    behavior,
    extracurricular,
    financial_aid,

    -- Academic Performance
    CASE
        WHEN score >= 90 THEN 'A (Excellent)'
        WHEN score >= 80 THEN 'B (Good)'
        WHEN score >= 70 THEN 'C (Satisfactory)'
        WHEN score >= 60 THEN 'D (Needs Improvement)'
        ELSE 'F (Failing)'
    END AS academic_grade,

    -- Attendance Rating
    CASE
        WHEN attendance >= 95 THEN 'Excellent (95%+)'
        WHEN attendance >= 90 THEN 'Very Good (90-94%)'
        WHEN attendance >= 85 THEN 'Good (85-89%)'
        WHEN attendance >= 75 THEN 'Satisfactory (75-84%)'
        ELSE 'Poor (<75%)'
    END AS attendance_rating,

    -- Overall Status
    CASE
        WHEN score >= 90 AND attendance >= 95 AND behavior = 'Excellent'
            THEN '⭐ Honor Roll'
        WHEN score >= 80 AND attendance >= 90
            THEN '✓ Good Standing'
        WHEN score >= 70 AND attendance >= 75
            THEN '→ Satisfactory'
        WHEN score >= 60 OR attendance >= 70
            THEN '⚠ Needs Improvement'
        ELSE '✗ At Risk'
    END AS overall_status,

    -- Scholarship Recommendation
    CASE
        WHEN score >= 90 AND attendance >= 95 AND behavior = 'Excellent' AND extracurricular = 'Yes'
            THEN 'Recommend Full Scholarship'
        WHEN score >= 88 AND attendance >= 92 AND extracurricular = 'Yes'
            THEN 'Recommend 75% Scholarship'
        WHEN score >= 85 AND attendance >= 90
            THEN 'Recommend 50% Scholarship'
        WHEN score >= 80 AND (attendance >= 88 OR extracurricular = 'Yes')
            THEN 'Recommend 25% Scholarship'
        ELSE 'No Scholarship Recommendation'
    END AS scholarship_recommendation,

    -- Support Services Needed
    CASE
        WHEN score < 60 AND attendance < 70
            THEN 'Academic + Attendance Counseling'
        WHEN score < 60
            THEN 'Tutoring Required'
        WHEN attendance < 70
            THEN 'Attendance Intervention'
        WHEN score < 75 OR attendance < 80
            THEN 'Academic Support Recommended'
        ELSE 'No Intervention Needed'
    END AS support_services,

    -- Next Steps
    CASE
        WHEN score >= 90 AND attendance >= 95
            THEN 'Continue Excellence - Consider Advanced Placement'
        WHEN score >= 80 AND attendance >= 90
            THEN 'Maintain Performance - Encourage Leadership Roles'
        WHEN score >= 70
            THEN 'Work on Improvement - Provide Additional Resources'
        WHEN score >= 60
            THEN 'Mandatory Tutoring - Parent Meeting Required'
        ELSE 'Intensive Intervention - Academic Plan Required'
    END AS recommended_action,

    -- Eligibility Flags
    CASE WHEN score >= 80 AND attendance >= 85 THEN 'Yes' ELSE 'No' END AS sports_eligible,
    CASE WHEN score >= 70 AND behavior != 'Poor' THEN 'Yes' ELSE 'No' END AS field_trip_eligible,
    CASE WHEN financial_aid = 'Yes' AND score >= 60 THEN 'Yes' ELSE 'No' END AS meal_program_eligible

FROM Students
ORDER BY
    CASE
        WHEN score >= 90 AND attendance >= 95 AND behavior = 'Excellent' THEN 1
        WHEN score >= 80 AND attendance >= 90 THEN 2
        WHEN score >= 70 AND attendance >= 75 THEN 3
        WHEN score >= 60 OR attendance >= 70 THEN 4
        ELSE 5
    END,
    score DESC;
/*
Complete student evaluation report with all CASE scenarios

Use Case: Report cards, student dashboards, comprehensive evaluations
*/

/*
=================================================================
COMMON MISTAKES AND BEST PRACTICES
=================================================================
*/

-- ❌ MISTAKE 1: Forgetting ELSE clause
SELECT CASE status
    WHEN 'Delivered' THEN 'Complete'
    WHEN 'Shipped' THEN 'In Transit'
END AS status_display  -- Returns NULL for other statuses!
FROM Orders;

-- ✓ CORRECT: Always include ELSE
SELECT CASE status
    WHEN 'Delivered' THEN 'Complete'
    WHEN 'Shipped' THEN 'In Transit'
    ELSE 'Other'  -- Handles unexpected values
END AS status_display
FROM Orders;

-- ❌ MISTAKE 2: Wrong order of conditions
SELECT CASE
    WHEN score >= 60 THEN 'Pass'  -- This matches 90 first!
    WHEN score >= 90 THEN 'Excellent'
END AS result
FROM Students;

-- ✓ CORRECT: Order from most specific to least specific
SELECT CASE
    WHEN score >= 90 THEN 'Excellent'  -- Check highest first
    WHEN score >= 60 THEN 'Pass'
    ELSE 'Fail'
END AS result
FROM Students;

-- ❌ MISTAKE 3: Using Simple CASE with ranges
SELECT CASE score  -- Can't do ranges with Simple CASE
    WHEN >= 90 THEN 'A'  -- Syntax error!
END AS grade
FROM Students;

-- ✓ CORRECT: Use Searched CASE for ranges
SELECT CASE
    WHEN score >= 90 THEN 'A'
    WHEN score >= 80 THEN 'B'
END AS grade
FROM Students;

-- ❌ MISTAKE 4: Not handling NULL
SELECT CASE discount
    WHEN 0 THEN 'No Discount'
    WHEN 10 THEN '10% Off'
END AS discount_text  -- NULL returns NULL
FROM Products;

-- ✓ CORRECT: Handle NULL explicitly
SELECT CASE
    WHEN discount IS NULL THEN 'No Discount'
    WHEN discount = 0 THEN 'No Discount'
    WHEN discount = 10 THEN '10% Off'
    ELSE CONCAT(discount, '% Off')
END AS discount_text
FROM Products;

/*
=================================================================
HINGLISH SUMMARY
=================================================================

CASE statement SQL ka conditional logic hai - if-else jaisa.

DO forms:

1. SIMPLE CASE - Equality checks
   CASE column
       WHEN value1 THEN result1
       WHEN value2 THEN result2
       ELSE default
   END

   Example:
   CASE status
       WHEN 'Delivered' THEN 'Complete'
       WHEN 'Shipped' THEN 'In Transit'
       ELSE 'Other'
   END

2. SEARCHED CASE - Complex conditions
   CASE
       WHEN condition1 THEN result1
       WHEN condition2 THEN result2
       ELSE default
   END

   Example:
   CASE
       WHEN score >= 90 THEN 'A'
       WHEN score >= 80 THEN 'B'
       ELSE 'F'
   END

Key points:
- Upar se neeche evaluate hota hai
- Pehli TRUE condition ka result milta hai
- ELSE optional hai (but recommended)
- Agar koi match nahi aur ELSE nahi to NULL
- SELECT, WHERE, ORDER BY, GROUP BY sab mein use ho sakta hai
- Nest kar sakte ho complex logic ke liye

Use cases:
- Grading: Score ranges se letter grades
- Status mapping: Codes ko readable text
- Categorization: Data ko groups mein
- Calculations: Conditional formulas
- Pivoting: Rows ko columns mein
- Sorting: Custom sort order
- Aggregation: Conditional counting/summing

Real-world patterns:

Grading:
CASE
    WHEN score >= 90 THEN 'A'
    WHEN score >= 80 THEN 'B'
    WHEN score >= 70 THEN 'C'
    ELSE 'F'
END

Multi-criteria:
CASE
    WHEN score >= 90 AND attendance >= 95 THEN 'Excellent'
    WHEN score >= 80 AND attendance >= 90 THEN 'Good'
    ELSE 'Needs Work'
END

Pivoting:
SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_count

Custom sorting:
ORDER BY
    CASE status
        WHEN 'Pending' THEN 1
        WHEN 'Processing' THEN 2
        ELSE 3
    END

Common mistakes:
❌ ELSE bhoolna (NULL return hota hai)
❌ Galat order (specific pehle, general baad mein)
❌ Simple CASE se ranges (use Searched CASE)
❌ NULL handle na karna
❌ Simple vs Searched confuse hona

Best practices:
✓ Hamesha ELSE include karo
✓ Specific conditions pehle, general baad mein
✓ Ranges ke liye Searched CASE use karo
✓ NULL explicitly handle karo
✓ Readable formatting use karo (indent properly)
✓ Complex logic ko nested CASE se handle karo
✓ Comments add karo business logic explain karne ke liye

Performance tips:
✓ Simple CASE faster hai equality checks ke liye
✓ Pehli matching condition pe stop ho jata hai
✓ Complex calculations CASE ke bahar calculate karo

Remember:
- Two types: Simple (equality) vs Searched (conditions)
- Top to bottom evaluation
- First match wins
- ELSE for defaults
- Can use anywhere (SELECT, WHERE, ORDER BY, etc.)
- NULL needs explicit handling
- Order matters!
- Readable code > clever code

KEY TAKEAWAYS:
✓ CASE enables conditional logic in SQL
✓ Simple CASE for equality, Searched for conditions
✓ Always include ELSE clause
✓ Order conditions from specific to general
✓ First matching condition wins
✓ Can be used in SELECT, WHERE, ORDER BY, etc.
✓ Supports nesting for complex logic
✓ Handle NULL explicitly
✓ Great for categorization and transformations
✓ Enables pivoting with aggregates
✓ Custom sorting with ORDER BY
✓ Conditional aggregation with SUM/COUNT
✓ Test all branches thoroughly
✓ Comment complex business logic
✓ Prefer readability over brevity

=================================================================
*/

-- Final comprehensive example:
SELECT
    student_name,
    score,
    attendance,
    behavior,

    -- Grade
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score >= 80 THEN 'B'
        WHEN score >= 70 THEN 'C'
        WHEN score >= 60 THEN 'D'
        ELSE 'F'
    END AS grade,

    -- Status
    CASE
        WHEN score >= 90 AND attendance >= 95 AND behavior = 'Excellent'
            THEN 'Honor Roll'
        WHEN score >= 70 AND attendance >= 80
            THEN 'Good Standing'
        WHEN score < 60 OR attendance < 70
            THEN 'At Risk'
        ELSE 'Satisfactory'
    END AS status,

    -- Recommendation
    CASE
        WHEN score < 60 THEN 'Tutoring Required'
        WHEN attendance < 75 THEN 'Attendance Counseling'
        WHEN score >= 90 AND attendance >= 95 THEN 'Advanced Placement Candidate'
        ELSE 'Continue Current Program'
    END AS recommendation

FROM Students
ORDER BY
    CASE
        WHEN score >= 90 AND attendance >= 95 THEN 1
        WHEN score >= 80 THEN 2
        WHEN score >= 70 THEN 3
        ELSE 4
    END,
    score DESC;
