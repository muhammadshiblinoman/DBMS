show databases;
use students;
CREATE TABLE employee (
    employee_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT
);

INSERT INTO employee VALUES
('Arif', '51 upashahar', 'Rajshahi'),
('Sumon', '52 east Moynamati', 'Abdul'),
('Sagor', 'Neemgachhi', 'Sirajgong'),
('Abdul', 'Binodpur', 'Rajshahi'),
('Himesh', 'Nazrul avenue', 'Dhaka'),
('Amirul', 'Chawk bazar', 'Sylhet'),
('Sajib', '99 north', 'Chittagong');

INSERT INTO works VALUES
('Sumon', 'Agrani', 12000),
('Abdul', 'Sonali', 13000),
('Himesh', 'Agrani', 6000),
('Amirul', 'Sonali', 20000),
('Sagor', 'Sonali', 8000),
('Arif', 'Janata', 13000),
('Sajib', 'Janata', 9000);

select * from works;
select * from employee;

-- b) Employees in Rajshahi city
SELECT employee_name FROM employee WHERE city = 'Rajshahi';

-- c) Names and street addresses in Rajshahi
SELECT employee_name, street FROM employee WHERE city = 'Rajshahi';

-- d) Employees working for specific companies
SELECT employee_name FROM works WHERE company_name = 'Sonali';
SELECT employee_name FROM works WHERE company_name = 'Agrani';
SELECT employee_name FROM works WHERE company_name = 'Janata';

-- e) Employees and salaries by company
SELECT employee_name, salary FROM works WHERE company_name = 'Sonali';
SELECT employee_name, salary FROM works WHERE company_name = 'Agrani';
SELECT employee_name, salary FROM works WHERE company_name = 'Janata';

-- f) Salaries equal to, greater than or less than 12000
SELECT employee_name FROM works WHERE salary = 12000;
SELECT employee_name FROM works WHERE salary >= 12000;
SELECT employee_name FROM works WHERE salary < 12000;

-- g) Names and companies by salary
SELECT employee_name, company_name FROM works WHERE salary = 12000;
SELECT employee_name, company_name FROM works WHERE salary >= 12000;
SELECT employee_name, company_name FROM works WHERE salary < 12000;

-- h) Employees working for Agrani (name, street, city)
SELECT e.employee_name, e.street, e.city
FROM employee e JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Agrani';

-- i) Employees earning >= 10000
SELECT e.employee_name, e.street, e.city
FROM employee e JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;

-- j) Employees living in Rajshahi
SELECT w.employee_name, w.company_name, w.salary
FROM works w JOIN employee e ON w.employee_name = e.employee_name
WHERE e.city = 'Rajshahi';

-- k) Employees earning >= 10000
SELECT e.employee_name, e.street, e.city, w.company_name
FROM employee e JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;

-- l) Employees of Sonali earning > 12000
SELECT e.employee_name, e.street, e.city
FROM employee e JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Sonali' AND w.salary > 12000;

-- m) Employees not working for Sonali
SELECT * FROM works WHERE company_name <> 'Sonali';

-- n) Update Arif’s city to Natore
UPDATE employee SET city = 'Natore' WHERE employee_name = 'Arif';

-- o) 10% raise for Agrani Bank employees
UPDATE works SET salary = salary * 1.1 WHERE company_name = 'Agrani';

-- p) Delete Sagor from employee table
DELETE FROM employee WHERE employee_name = 'Sagor';

-- q) Add manager column to works table (assuming company table is not defined yet)
ALTER TABLE works ADD COLUMN manager VARCHAR(50);
use students;
select * from works;