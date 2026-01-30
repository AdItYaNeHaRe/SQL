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
    CONSTRAINT FK_Department PRIMARY KEY (EmployeeID)
);


-- ENGLISH EXPLANATION FOR DDL `CREATE TABLE`

-- CREATE TABLE is a DDL (Data Definition Language) command used to create a new table
-- with specified columns, data types, and constraints in a database. [web:81][web:85]

-- Basic syntax:
-- CREATE TABLE table_name (
--     column1 datatype [constraints],
--     column2 datatype [constraints],
--     ...
--     [table_constraints]
-- );

-- Common data types: INT, VARCHAR(n), DATE, DECIMAL(p,s), BOOLEAN, etc. [web:81][web:84]
-- Common constraints: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT, CHECK. [web:81][web:85]

-- Example 1: Simple table
-- CREATE TABLE Students (
--     student_id INT PRIMARY KEY,
--     name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) UNIQUE,
--     age INT CHECK (age >= 18),
--     enrollment_date DATE DEFAULT CURRENT_DATE
-- );

-- Example 2: Table with foreign key
-- CREATE TABLE Orders (
--     order_id INT PRIMARY KEY,
--     student_id INT,
--     order_date DATE,
--     FOREIGN KEY (student_id) REFERENCES Students(student_id)
-- );


-- HINGLISH EXPLANATION FOR DDL `CREATE TABLE`

-- CREATE TABLE DDL (Data Definition Language) command hai jo naya table banata hai
-- specified columns, data types aur constraints ke saath database mein. [web:81][web:85]

-- Basic syntax (Hinglish samjhaav):
-- CREATE TABLE table_name (
--     column1 datatype [constraints],
--     column2 datatype [constraints],
--     ...
--     [table_constraints]
-- );

-- Common data types: INT (number), VARCHAR(n) (text), DATE (date), DECIMAL (decimal), etc. [web:81][web:84]
-- Common constraints: PRIMARY KEY (unique identifier), FOREIGN KEY (relation), NOT NULL (empty nahi), UNIQUE, DEFAULT, CHECK. [web:81][web:85]

-- Example 1: Simple Students table
-- CREATE TABLE Students (
--     student_id INT PRIMARY KEY,      -- unique ID, har student ka alag
--     name VARCHAR(100) NOT NULL,      -- naam empty nahi ho sakta
--     email VARCHAR(100) UNIQUE,       -- email duplicate nahi
--     age INT CHECK (age >= 18),       -- age 18 se kam nahi
--     enrollment_date DATE DEFAULT CURRENT_DATE  -- default aaj ki date
-- );

-- Example 2: Orders table with foreign key relation
-- CREATE TABLE Orders (
--     order_id INT PRIMARY KEY,
--     student_id INT,                  -- Students table se link
--     order_date DATE,
--     FOREIGN KEY (student_id) REFERENCES Students(student_id)  -- relation banaya
-- );

-- Query execution order:
-- CREATE TABLE → table ban jaata hai immediately, data insert kar sakte ho ab. [web:81][web:82]
