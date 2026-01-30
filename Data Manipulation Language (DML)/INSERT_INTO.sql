INSERT INTO customers(id, first_name, country, score)
    VALUE (7, 'Anjali', 'India', 88),
            (8, 'Liam', 'Canada', 92),
            (9, 'Sophia', 'USA', NULL);


INSERT INTO customers
VALUES (10, 'Noah', 'UK', 75);

INSERT INTO customers (id, first_name, country)
VALUES (11, 'Emma', 'Australia');
-- ENGLISH EXPLANATION FOR `INSERT INTO ... VALUES (...)`

-- INSERT INTO is a DML (Data Manipulation Language) statement used to add
-- one or more new rows into a table. [web:1][web:2]

-- General syntax:
-- INSERT INTO Table_Name (column1, column2, ...)
-- VALUES (value1, value2, ...);

-- Meaning:
-- Table_Name  → name of the table where the new row will be stored. [web:2][web:7]
-- column1...  → columns that will receive values.
-- value1...   → actual values that will be inserted, in the same order as columns. [web:1][web:7]

-- Example (single row):
-- INSERT INTO Students (student_id, name, age, city)
-- VALUES (1, 'Rahul', 21, 'Hyderabad');
-- This inserts one new student record into the Students table. [web:2][web:7]

-- Example (multiple rows):
-- INSERT INTO Students (student_id, name, age, city)
-- VALUES
--   (2, 'Amit', 22, 'Delhi'),
--   (3, 'Neha', 20, 'Mumbai');
-- This inserts two rows in a single statement. [web:4][web:7]


-- HINGLISH EXPLANATION FOR `INSERT INTO ... VALUES (...)`

-- INSERT INTO ek DML statement hai jo table ke andar nayi row/rows add karne ke
-- kaam aata hai. [web:1][web:2]

-- General syntax (Hinglish samjhaav):
-- INSERT INTO Table_Name (column1, column2, ...)
-- VALUES (value1, value2, ...);

-- Yahan:
-- Table_Name  → jis table mein data insert karna hai. [web:2][web:7]
-- column1...  → kaun‑kaun se columns mein values jayengi.
-- value1...   → un columns ke corresponding values, same order mein likhni padti hain. [web:1][web:7]

-- Example (single row, Hinglish):
-- INSERT INTO Students (student_id, name, age, city)
-- VALUES (1, 'Rahul', 21, 'Hyderabad');
-- Matlab: Students table mein ek naya student add kar diya. [web:2][web:7]

-- Example (multiple rows, Hinglish):
-- INSERT INTO Students (student_id, name, age, city)
-- VALUES
--   (2, 'Amit', 22, 'Delhi'),
--   (3, 'Neha', 20, 'Mumbai');
-- Matlab: ek hi query se do naye students insert kar diye. [web:4][web:7]

-- Important points:
-- - Columns aur VALUES ka count match hona chahiye. [web:7]
-- - Har value ka datatype us column ke datatype se match hona chahiye. [web:7]
