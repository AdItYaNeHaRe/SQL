-- =====================================================
-- SQL SEARCH OPERATORS (LIKE, ILIKE) - Complete Reference with Examples
-- =====================================================

-- ENGLISH EXPLANATION FOR SEARCH OPERATORS

-- LIKE operator searches for patterns in text using wildcards.

-- WILDCARDS:
-- %    → Zero or more characters (any length)
-- _    → Exactly ONE character

-- 1. LIKE with % (anywhere match)
-- SELECT * FROM Employees WHERE name LIKE '%rahul%';
-- Returns names containing "rahul" anywhere (Rahul Kumar, Rahul Sharma).

-- 2. LIKE with % at end (starts with)
-- SELECT * FROM Employees WHERE name LIKE 'Rahul%';
-- Returns names starting with "Rahul" (Rahul, RahulK).

-- 3. LIKE with % at start (ends with)
-- SELECT * FROM Employees WHERE name LIKE '%kumar';
-- Returns names ending with "kumar" (Rahul Kumar, Amit Kumar).

-- 4. LIKE with _ (single character)
-- SELECT * FROM Employees WHERE name LIKE 'R_hul';
-- Returns Rahul, Rahal, Rehul (exactly 5 chars, 3rd char varies).

-- 5. NOT LIKE (exclude pattern)
-- SELECT * FROM Employees WHERE name NOT LIKE 'A%';
-- Returns names NOT starting with 'A'.

-- Sample data examples:
-- Names: Rahul, Amit, Priya, RahulK, NehaR, SalesTeam
SELECT * FROM Names WHERE name LIKE '%rahul%';     -- Rahul, RahulK
SELECT * FROM Names WHERE name LIKE 'A%';          -- Amit
SELECT * FROM Names WHERE name LIKE '%Team';       -- SalesTeam


-- HINGLISH EXPLANATION FOR SEARCH OPERATORS

-- LIKE operator text mein patterns dhundne ke liye wildcards ke saath use hota hai.

-- WILDCARDS (Hinglish):
-- %    → kitne bhi characters (0 ya zyada)
-- _    → sirf EK character

-- 1. Kahin bhi match (%rahul%)
-- SELECT * FROM Employees WHERE name LIKE '%rahul%';
-- Matlab: naam mein kahin bhi "rahul" ho (Rahul Kumar, Rahul Sharma).

-- 2. Shuru mein match (Rahul%)
-- SELECT * FROM Employees WHERE name LIKE 'Rahul%';
-- Matlab: naam Rahul se shuru ho (Rahul, RahulK).

-- 3. End mein match (%kumar)
-- SELECT * FROM Employees WHERE name LIKE '%kumar';
-- Matlab: naam kumar se khatam ho (Rahul Kumar, Amit Kumar).

-- 4. Single character match (R_hul)
-- SELECT * FROM Employees WHERE name LIKE 'R_hul';
-- Matlab: 5 characters ka naam, 3rd position different (Rahul, Rahal).

-- 5. Pattern exclude (NOT LIKE)
-- SELECT * FROM Employees WHERE name NOT LIKE 'A%';
-- Matlab: A se shuru na ho.

-- Quick Pattern Reference (Hinglish):
-- '%rah%'     → kahin bhi "rah" ho
-- 'Rah%'      → Rahul se start
-- '%ul'       → ul se end
-- 'R_h_l'     → R, _, h, _, l (5 chars)
-- '_a%'       → dusra char 'a' ho

-- ⚠️ Case Sensitivity:
-- MySQL: case-insensitive by default
-- PostgreSQL: case-sensitive (use ILIKE for case-insensitive)
-- SELECT * FROM names WHERE name ILIKE '%Rahul%';  -- PostgreSQL
