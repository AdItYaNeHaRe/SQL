/*
=================================================================
QUERY PURPOSE: Create an Employees table with various constraints and data types
=================================================================

CONCEPT EXPLANATION (English):
This is a DDL (Data Definition Language) statement that creates a new
table named "Employees" in the database. The CREATE TABLE statement
defines the structure of the table including:
- Column names and their data types
- Constraints (rules) that enforce data integrity
- Primary key to uniquely identify each row
- NOT NULL constraints to ensure required fields have values
- UNIQUE constraint to prevent duplicate values

A table is like a spreadsheet with predefined columns where each column
has a specific data type and set of rules.

CONCEPT EXPLANATION (Hinglish):
Yeh ek DDL (Data Definition Language) statement hai jo database mein
"Employees" naam ki nayi table create karta hai. CREATE TABLE statement
table ki structure define karta hai jismein include hota hai:
- Column names aur unke data types
- Constraints (rules) jo data integrity enforce karte hain
- Primary key jo har row ko uniquely identify karta hai
- NOT NULL constraints jo ensure karte hain ki required fields mein value ho
- UNIQUE constraint jo duplicate values ko prevent karta hai

Table ek spreadsheet ki tarah hoti hai jismein predefined columns hote hain
aur har column ka specific data type aur rules ka set hota hai.

USE CASES:
- Creating database schema for employee management systems
- HR applications needing employee information storage
- Payroll systems tracking employee details and salaries
- Organizational structure databases
- Employee directory and contact management
- Time tracking and attendance systems
- Performance management systems
- Any application requiring structured employee data storage

SPECIFIC QUERY BREAKDOWN:

Line 1: CREATE TABLE Employees (
  → CREATE TABLE: SQL command to create a new table
  → Employees: Name of the table being created
  → ( : Opens the column definition block

Line 2: EmployeeID INT NOT NULL,
  → EmployeeID: Column name (identifier for each employee)
  → INT: Data type - Integer (whole numbers like 1, 2, 100, etc.)
  → NOT NULL: Constraint - This column MUST have a value (cannot be empty)
  → Used to uniquely identify each employee

Line 3: FirstName VARCHAR(50) NOT NULL,
  → FirstName: Column for employee's first name
  → VARCHAR(50): Variable character string, maximum 50 characters
  → VARCHAR saves space - if name is "John" (4 chars), only 4 chars stored
  → NOT NULL: First name is mandatory

Line 4: LastName VARCHAR(50) NOT NULL,
  → LastName: Column for employee's last name
  → VARCHAR(50): Up to 50 characters allowed
  → NOT NULL: Last name is required

Line 5: BirthDate DATE,
  → BirthDate: Employee's date of birth
  → DATE: Data type for dates (format: YYYY-MM-DD, e.g., 1990-05-15)
  → No NOT NULL: Birth date is optional (can be NULL)

Line 6: HireDate DATE,
  → HireDate: Date when employee was hired
  → DATE: Stores date values
  → Optional field (can be NULL if not yet assigned)

Line 7: Email VARCHAR(100) UNIQUE,
  → Email: Employee's email address
  → VARCHAR(100): Up to 100 characters (enough for email addresses)
  → UNIQUE: No two employees can have the same email
  → UNIQUE constraint automatically creates an index
  → Optional field but if provided, must be unique

Line 8: PhoneNumber VARCHAR(15),
  → PhoneNumber: Contact number
  → VARCHAR(15): String up to 15 characters (handles +, -, spaces in phone numbers)
  → Using VARCHAR instead of INT because phone numbers may have special characters
  → Optional field (no constraints)

Line 9: DepartmentID INT,
  → DepartmentID: References which department employee belongs to
  → INT: Integer value (likely foreign key to Departments table)
  → Optional: Employee might not be assigned to department yet

Line 10: Salary DECIMAL(10, 2),
  → Salary: Employee's salary amount
  → DECIMAL(10, 2): Decimal number with precision
  → 10: Total digits allowed (including decimals)
  → 2: Digits after decimal point
  → Examples: 99999999.99 (max), 50000.50, 125000.00
  → DECIMAL used for exact monetary values (not FLOAT which can be imprecise)
  → Optional field

Line 11: CONSTRAINT FK_Department PRIMARY KEY (EmployeeID)
  → CONSTRAINT: Defines a named constraint
  → FK_Department: Name of the constraint (misleading name - should be PK_Employee!)
  → PRIMARY KEY: Defines EmployeeID as the primary key
  → (EmployeeID): Column that serves as primary key
  → PRIMARY KEY ensures: NOT NULL + UNIQUE for this column
  → Only ONE primary key per table allowed

⚠️ NOTE: The constraint name "FK_Department" is MISLEADING!
   FK = Foreign Key, but this is actually a PRIMARY KEY
   Better name would be: PK_Employee or PK_EmployeeID

DATA TYPE EXPLANATION:

INT (Integer):
- Stores whole numbers: -2,147,483,648 to 2,147,483,647
- Size: 4 bytes
- Use for: IDs, counts, quantities

VARCHAR(n) (Variable Character):
- Stores text up to n characters
- Only uses space needed (VARCHAR(50) with "John" uses ~4 bytes)
- Use for: Names, emails, descriptions, addresses

DATE:
- Stores date values (year, month, day)
- Format: 'YYYY-MM-DD' (e.g., '2024-01-15')
- Range: '1000-01-01' to '9999-12-31'
- Use for: Birthdates, hire dates, deadlines

DECIMAL(p, s):
- Stores exact decimal numbers
- p = precision (total digits)
- s = scale (digits after decimal)
- DECIMAL(10,2) can store: -99999999.99 to 99999999.99
- Use for: Money, prices, percentages requiring precision

CONSTRAINTS EXPLANATION:

NOT NULL:
- Column MUST have a value
- INSERT without this column will fail
- UPDATE to NULL will fail
- Use for mandatory fields

UNIQUE:
- No duplicate values allowed in this column
- Multiple UNIQUE constraints per table allowed
- NULL values typically allowed (depends on database)
- Automatically creates an index
- Use for: Emails, usernames, SSN, unique codes

PRIMARY KEY:
- Uniquely identifies each row
- Combines NOT NULL + UNIQUE
- Only ONE primary key per table
- Automatically creates a clustered index
- Often used with AUTO_INCREMENT/IDENTITY
- Use for: Main identifier of records

EXAMPLES:

Example 1: Similar Employee table with better naming
*/
CREATE TABLE Employees (
    EmployeeID INT NOT NULL AUTO_INCREMENT,  -- Auto-incrementing ID
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    HireDate DATE DEFAULT CURRENT_DATE,      -- Default to today's date
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    DepartmentID INT,
    Salary DECIMAL(10, 2) CHECK (Salary > 0), -- Ensure positive salary
    IsActive BOOLEAN DEFAULT TRUE,            -- Track active employees
    CONSTRAINT PK_EmployeeID PRIMARY KEY (EmployeeID),  -- Better naming!
    CONSTRAINT FK_Dept FOREIGN KEY (DepartmentID) REFERENCES Departments(DeptID)
);

-- Example 2: Products table with various constraints
CREATE TABLE Products (
    ProductID INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    SKU VARCHAR(50) UNIQUE NOT NULL,         -- Stock Keeping Unit
    Category VARCHAR(50),
    Price DECIMAL(8, 2) NOT NULL CHECK (Price >= 0),
    StockQuantity INT DEFAULT 0,
    ManufactureDate DATE,
    ExpiryDate DATE,
    IsActive BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT CHK_Dates CHECK (ExpiryDate > ManufactureDate)
);

-- Example 3: Students table
CREATE TABLE Students (
    StudentID INT NOT NULL,
    RollNumber VARCHAR(20) UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    GPA DECIMAL(3, 2) CHECK (GPA BETWEEN 0.00 AND 4.00),
    CONSTRAINT PK_StudentID PRIMARY KEY (StudentID)
);

-- Example 4: Composite Primary Key (multiple columns)
CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Discount DECIMAL(5, 2) DEFAULT 0.00,
    CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ProductID),  -- Composite key
    CONSTRAINT FK_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

/*
INSERTING DATA INTO THE TABLE:
*/

-- Valid INSERT examples:
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary)
VALUES (1, 'John', 'Doe', 'john.doe@company.com', 50000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, Email, PhoneNumber, DepartmentID, Salary)
VALUES (2, 'Jane', 'Smith', '1990-05-15', '2020-01-10', 'jane.smith@company.com', '+1-555-0123', 5, 65000.50);

-- Insert with NULL optional fields:
INSERT INTO Employees (EmployeeID, FirstName, LastName)
VALUES (3, 'Bob', 'Johnson');  -- BirthDate, Email, Salary etc. will be NULL

/*
INVALID INSERT examples (will fail):

-- Missing NOT NULL column (FirstName):
INSERT INTO Employees (EmployeeID, LastName)
VALUES (4, 'Williams');  ❌ Error: FirstName cannot be NULL

-- Duplicate EmployeeID (Primary Key violation):
INSERT INTO Employees (EmployeeID, FirstName, LastName)
VALUES (1, 'Alice', 'Brown');  ❌ Error: EmployeeID 1 already exists

-- Duplicate Email (UNIQUE constraint violation):
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email)
VALUES (5, 'Charlie', 'Davis', 'john.doe@company.com');  ❌ Error: Email already exists

-- Wrong data type:
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary)
VALUES (6, 'David', 'Miller', 'fifty thousand');  ❌ Error: Salary expects DECIMAL, not text
*/

/*
REAL-WORLD SCENARIO:

Scenario: HR department ki new Employee Management System
Tables Needed:

1. Employees (main table) ✓
2. Departments (DepartmentID references this)
3. Positions (job titles)
4. Salaries_History (track salary changes)

Employees Table ka use:
- Har employee ka basic info store karna
- Email se employee ko uniquely identify karna
- Department assignment track karna
- Salary information maintain karna
- Hire date se experience calculate karna

Example Queries after table creation:
*/

-- Find all employees in Department 5
SELECT * FROM Employees WHERE DepartmentID = 5;

-- Find employees hired in 2023
SELECT * FROM Employees WHERE YEAR(HireDate) = 2023;

-- Calculate average salary
SELECT AVG(Salary) AS AverageSalary FROM Employees;

-- Find employees with email addresses
SELECT * FROM Employees WHERE Email IS NOT NULL;

-- List employees by salary (highest first)
SELECT FirstName, LastName, Salary
FROM Employees
ORDER BY Salary DESC;

/*
COMMON MISTAKES TO AVOID:

1. Wrong constraint naming:
   ❌ CONSTRAINT FK_Department PRIMARY KEY (EmployeeID)
   ✓ CONSTRAINT PK_EmployeeID PRIMARY KEY (EmployeeID)
   FK = Foreign Key, PK = Primary Key - don't mix them up!

2. Forgetting NOT NULL on important fields:
   If FirstName can be NULL, you'll have employees without names!

3. Using INT for phone numbers:
   Phone numbers can have +, -, (, ), spaces - use VARCHAR!

4. Using FLOAT/DOUBLE for money:
   ❌ Salary FLOAT
   ✓ Salary DECIMAL(10, 2)
   FLOAT has precision issues: 0.1 + 0.2 might not equal 0.3!

5. VARCHAR size too small:
   VARCHAR(10) for email will fail for 'johndoe@company.com'

6. Not adding AUTO_INCREMENT to ID columns:
   Without AUTO_INCREMENT, you must manually specify IDs

7. Multiple PRIMARY KEYs:
   ❌ You can only have ONE primary key per table
   ✓ Use composite primary key: PRIMARY KEY (col1, col2)

8. Confusing UNIQUE and PRIMARY KEY:
   - PRIMARY KEY: NOT NULL + UNIQUE, only one per table
   - UNIQUE: Can be NULL (usually), multiple allowed per table

PERFORMANCE NOTES:

1. PRIMARY KEY automatically creates an index (fast lookups)
2. UNIQUE constraint also creates an index
3. Consider adding indexes on frequently queried columns:
   CREATE INDEX idx_lastname ON Employees(LastName);
   CREATE INDEX idx_department ON Employees(DepartmentID);

4. VARCHAR is more efficient than CHAR for variable-length data
5. INT is 4 bytes, BIGINT is 8 bytes (use INT unless you need huge numbers)

MODIFYING THE TABLE AFTER CREATION:

-- Add a new column:
ALTER TABLE Employees ADD COLUMN MiddleName VARCHAR(50);

-- Modify column data type:
ALTER TABLE Employees MODIFY COLUMN PhoneNumber VARCHAR(20);

-- Add constraint to existing column:
ALTER TABLE Employees MODIFY Email VARCHAR(100) NOT NULL;

-- Add foreign key constraint:
ALTER TABLE Employees
ADD CONSTRAINT FK_Department
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- Drop a column:
ALTER TABLE Employees DROP COLUMN PhoneNumber;

-- Rename table:
RENAME TABLE Employees TO Staff;
-- or
ALTER TABLE Employees RENAME TO Staff;

HINGLISH SUMMARY:
CREATE TABLE statement se hum database mein nayi table banate hain.
Har column ka naam, data type (INT, VARCHAR, DATE, DECIMAL) aur
constraints (NOT NULL, UNIQUE, PRIMARY KEY) define karte hain.

PRIMARY KEY har row ko uniquely identify karta hai aur NOT NULL + UNIQUE
dono enforce karta hai. UNIQUE constraint duplicate values nahi allow karta.
NOT NULL matlab column mein value hona zaroori hai.

Salary ke liye DECIMAL use karo (FLOAT nahi) kyunki exact values chahiye.
Phone numbers ke liye VARCHAR use karo (INT nahi) kyunki special characters
ho sakte hain.

Constraint naming important hai - PK for Primary Key, FK for Foreign Key,
CHK for Check constraint. Proper naming se readability aur maintenance
easy hoti hai!

KEY TAKEAWAYS:
✓ Use descriptive column names
✓ Choose appropriate data types
✓ Add NOT NULL for required fields
✓ Use UNIQUE for fields that must be distinct
✓ Always have a PRIMARY KEY
✓ Name constraints properly (PK_, FK_, CHK_, UQ_)
✓ Use DECIMAL for money, not FLOAT
✓ Use VARCHAR for text, not CHAR (unless fixed length)
✓ Consider adding DEFAULT values where appropriate
✓ Plan for future: AUTO_INCREMENT for IDs

=================================================================
*/

CREATE TABLE Employees (
    EmployeeID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    HireDate DATE,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    CONSTRAINT FK_Department PRIMARY KEY (EmployeeID)  -- ⚠️ Should be named PK_EmployeeID
);
