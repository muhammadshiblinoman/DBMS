create database Example5;

use Example5;

CREATE TABLE Publisher (
    Name VARCHAR(50) PRIMARY KEY,
    Address VARCHAR(100),
    Phone VARCHAR(15)
);

-- Book Table (depends on Publisher)
CREATE TABLE Book (
    BookId VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(50),
    PublisherName VARCHAR(50),
    FOREIGN KEY (PublisherName) REFERENCES Publisher(Name)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- Library_Branch Table (independent)
CREATE TABLE Library_Branch (
    BranchId VARCHAR(10) PRIMARY KEY,
    BranchName VARCHAR(50),
    Address VARCHAR(50)
);

-- Borrower Table (independent)
CREATE TABLE Borrower (
    CardNo VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(50),
    Phone VARCHAR(15)
);

-- Book_Author Table (depends on Book)
CREATE TABLE Book_Author (
    BookId VARCHAR(10),
    AuthorName VARCHAR(50),
    PRIMARY KEY (BookId, AuthorName),
    FOREIGN KEY (BookId) REFERENCES Book(BookId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Book_Copies Table (depends on Book and Library_Branch)
CREATE TABLE Book_Copies (
    BookId VARCHAR(10),
    BranchId VARCHAR(10),
    No_Of_Copies INT,
    PRIMARY KEY (BookId, BranchId),
    FOREIGN KEY (BookId) REFERENCES Book(BookId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (BranchId) REFERENCES Library_Branch(BranchId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Book_Loan Table (depends on Book, Branch, Borrower)
CREATE TABLE Book_Loan (
    BookId VARCHAR(10),
    BranchId VARCHAR(10),
    CardNo VARCHAR(10),
    DateOut DATE,
    DueDate DATE,
    PRIMARY KEY (BookId, BranchId, CardNo, DateOut),
    FOREIGN KEY (BookId) REFERENCES Book(BookId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (BranchId) REFERENCES Library_Branch(BranchId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert Publisher Data
INSERT INTO Publisher VALUES
('PHI', '20 Delhi Super Market', '01715-454678'),
('Tata', 'North Kolkata', '0156-2345445'),
('Galgotia', 'Mumbai', '0192-203490');

-- Insert Book Data
INSERT INTO Book VALUES
('100.001cn', 'Computer Network', 'PHI'),
('100.002dsc', 'Database System', 'Tata'),
('100.003ds', 'Digital System', 'PHI'),
('100.004db', 'DBMS', 'PHI'),
('100.005ora', 'Oracle 2000', 'Galgotia');

-- Insert Book_Author Data
INSERT INTO Book_Author VALUES
('100.001cn', 'A S Tanenbaum'),
('100.002dsc', 'Silberschatz'),
('100.003ds', 'Ronald J Tocci'),
('100.004db', 'Ivan Bayross'),
('100.005ora', 'Ivan Bayross');

-- Insert Library_Branch Data
INSERT INTO Library_Branch VALUES
('1001', 'CSE Seminar Library', 'Rajshahi'),
('1002', 'RU Central Library', 'Rajshahi'),
('1003', 'DU Central Library', 'Dhaka');

-- Insert Book_Copies Data
INSERT INTO Book_Copies VALUES
('100.001cn', '1001', 2),
('100.001cn', '1002', 5),
('100.002dsc', '1001', 3),
('100.002dsc', '1002', 4),
('100.003ds', '1001', 3),
('100.003ds', '1003', 5),
('100.004db', '1001', 2),
('100.004db', '1002', 5),
('100.005ora', '1001', 2),
('100.005ora', '1002', 7);

-- Insert Borrower Data
INSERT INTO Borrower VALUES
('10001', 'Saidur', 'CSE', '01714-400567'),
('10002', 'Rafiq', 'PHYSICS', '0194-300436'),
('10003', 'Masud', 'CSE', '0156-345678'),
('10004', 'Nobir', 'ICT', '01199-203456');

-- Insert Book_Loan Data
INSERT INTO Book_Loan VALUES
('100.001cn', '1001', '10001', '2015-01-15', '2015-02-15'),
('100.001cn', '1002', '10002', '2015-01-25', '2015-02-25'),
('100.002dsc', '1001', '10003', '2015-02-20', '2015-03-20'),
('100.002dsc', '1002', '10004', '2015-03-15', '2015-04-15'),
('100.003ds', '1001', '10001', '2015-06-07', '2015-07-07'),
('100.003ds', '1003', '10002', '2015-10-15', '2015-11-15'),
('100.004db', '1001', '10003', '2015-10-25', '2015-11-25'),
('100.004db', '1002', '10004', '2015-11-15', '2015-12-15'),
('100.005ora', '1001', '10003', '2015-12-22', '2016-01-22'),
('100.005ora', '1002', '10001', '2015-12-25', '2016-01-25');

-- 1️Copies of DBMS in CSE Seminar Library
SELECT BC.No_Of_Copies
FROM Book B
JOIN Book_Copies BC ON B.BookId = BC.BookId
JOIN Library_Branch LB ON BC.BranchId = LB.BranchId
WHERE B.Title = 'DBMS' AND LB.BranchName = 'CSE Seminar Library';

-- 2️ Copies of DBMS in each branch
SELECT LB.BranchName, BC.No_Of_Copies
FROM Book B
JOIN Book_Copies BC ON B.BookId = BC.BookId
JOIN Library_Branch LB ON BC.BranchId = LB.BranchId
WHERE B.Title = 'DBMS';

-- 3️Borrowers with no books checked out
SELECT BR.Name
FROM Borrower BR
WHERE BR.CardNo NOT IN (SELECT CardNo FROM Book_Loan);

-- 4️Books loaned from CSE Seminar Library due today
SELECT B.Title, BR.Name, BR.Address
FROM Book_Loan BL
JOIN Book B ON BL.BookId = B.BookId
JOIN Borrower BR ON BL.CardNo = BR.CardNo
JOIN Library_Branch LB ON BL.BranchId = LB.BranchId
WHERE LB.BranchName = 'CSE Seminar Library' AND BL.DueDate = CURDATE();

-- 5️ Total books loaned from each branch
SELECT LB.BranchName, COUNT(*) AS Total_Loaned_Books
FROM Book_Loan BL
JOIN Library_Branch LB ON BL.BranchId = LB.BranchId
GROUP BY LB.BranchName;

-- 6️ Borrowers with more than 2 books
SELECT BR.Name, BR.Address, COUNT(*) AS Books_Checked_Out
FROM Borrower BR
JOIN Book_Loan BL ON BR.CardNo = BL.CardNo
GROUP BY BR.Name, BR.Address
HAVING COUNT(*) > 2;

-- 7️ Books by Ivan Bayross in RU Central Library
SELECT B.Title, BC.No_Of_Copies
FROM Book B
JOIN Book_Author BA ON B.BookId = BA.BookId
JOIN Book_Copies BC ON B.BookId = BC.BookId
JOIN Library_Branch LB ON BC.BranchId = LB.BranchId
WHERE BA.AuthorName = 'Ivan Bayross' AND LB.BranchName = 'RU Central Library';
