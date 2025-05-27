CREATE TABLE employee (
    employee_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE company (
    company_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT
);

CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50)
);
INSERT INTO employee VALUES
('Arif', '51 upashahar', 'Rajshahi'),
('Sumon', '52 east Moynamati', 'Moynamati'),
('Sagor', 'Neemgachhi', 'Sirajgong'),
('Abdul', 'Binodpur', 'Rajshahi'),
('Himesh', 'Nazrul avenue', 'Dhaka'),
('Amirul', 'Chawk bazar', 'Sylhet'),
('Sajib', '99 north', 'Chittagong');

INSERT INTO company VALUES
('Agrani', 'Rajshahi'),
('Sonali', 'Sylhet'),
('Janata', 'Dhaka');

INSERT INTO works VALUES
('Sumon', 'Agrani', 12000),
('Abdul', 'Sonali', 13000),
('Himesh', 'Agrani', 6000),
('Amirul', 'Sonali', 20000),
('Sagor', 'Sonali', 8000),
('Arif', 'Janata', 13000),
('Sajib', 'Janata', 9000);

INSERT INTO manages VALUES
('Amirul', 'Amirul'),
('Abdul', 'Amirul'),
('Sagor', 'Amirul'),
('Sumon', 'Sumon'),
('Himesh', 'Sumon'),
('Arif', 'Arif'),
('Sajib', 'Arif');

-- Employees working at Sonali
SELECT employee_name FROM works WHERE company_name = 'Sonali';

-- Employees at Agrani with address
SELECT e.employee_name, e.street, e.city FROM employee e JOIN works w ON e.employee_name = w.employee_name WHERE w.company_name = 'Agrani';

-- Employees at Sonali earning > 10,000
SELECT e.employee_name, e.street, e.city FROM employee e JOIN works w ON e.employee_name = w.employee_name WHERE w.company_name = 'Sonali' AND w.salary > 10000;

-- Employees in same city as company
SELECT e.employee_name FROM employee e JOIN works w ON e.employee_name = w.employee_name JOIN company c ON w.company_name = c.company_name WHERE e.city = c.city;

-- Employees living on same street and city as their manager
SELECT e.employee_name FROM employee e JOIN manages m ON e.employee_name = m.employee_name JOIN employee mgr ON m.manager_name = mgr.employee_name WHERE e.city = mgr.city AND e.street = mgr.street;

-- Employees not working for Sonali
SELECT * FROM works WHERE company_name <> 'Sonali';

-- Employees earning more than all at Janata
SELECT w1.employee_name FROM works w1 WHERE w1.salary > ALL (SELECT salary FROM works WHERE company_name = 'Janata');

-- Employees earning more than average salary of their company
SELECT w1.employee_name FROM works w1 WHERE salary > (
    SELECT AVG(salary)
    FROM works w2
    WHERE w2.company_name = w1.company_name
);

-- Company with most employees
SELECT company_name FROM works GROUP BY company_name ORDER BY COUNT(*) DESC LIMIT 1;

-- Company with smallest payroll
SELECT company_name FROM works GROUP BY company_name ORDER BY SUM(salary) ASC LIMIT 1;

-- Companies with higher avg salary than Agrani
SELECT company_name FROM works GROUP BY company_name HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM works
    WHERE company_name = 'Agrani'
);

-- Update Arif’s city
UPDATE employee SET city = 'Natore' WHERE employee_name = 'Arif';

-- 10% salary raise for Agrani employees
UPDATE works SET salary = salary * 1.10 WHERE company_name = 'Agrani';

-- 10% salary raise for Agrani managers
UPDATE works
SET salary = salary * 1.10
WHERE employee_name IN (
    SELECT manager_name
    FROM manages
    JOIN works ON manages.manager_name = works.employee_name
    WHERE works.company_name = 'Agrani'
);

-- Conditional raise for all managers
UPDATE works
SET salary = salary * 1.03
WHERE employee_name IN (SELECT manager_name FROM manages) AND salary > 19000;

UPDATE works
SET salary = salary * 1.10
WHERE employee_name IN (SELECT manager_name FROM manages) AND salary <= 19000;

-- Delete all employees of Janata Bank
DELETE FROM works WHERE company_name = 'Janata';

-- Define a view with manager and avg salary
CREATE VIEW manager_avg_salary AS
SELECT m.manager_name, AVG(w.salary) AS avg_salary
FROM manages m
JOIN works w ON m.employee_name = w.employee_name
GROUP BY m.manager_name;
