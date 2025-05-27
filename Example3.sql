CREATE TABLE person (
    nid VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE car (
    license VARCHAR(10) PRIMARY KEY,
    year INT,
    model VARCHAR(50)
);

CREATE TABLE accident (
    date DATE,
    driver VARCHAR(50),
    damage_amount INT
);

CREATE TABLE owns (
    nid VARCHAR(10),
    license VARCHAR(10)
);

CREATE TABLE log (
    license VARCHAR(10),
    date DATE,
    driver VARCHAR(50)
);

-- Insert data
INSERT INTO person VALUES
('123451', 'Arif', 'Rajshahi'),
('123452', 'Sumon', 'Moynamati'),
('123453', 'Sagor', 'Sirajgang'),
('123454', 'Abdul', 'Rajshahi'),
('123455', 'Himesh', 'Dhaka'),
('123456', 'Amirul', 'Sylhet'),
('123457', 'Sajib', 'Chittagang');

INSERT INTO car VALUES
('12-3000', 2012, 'Axio'),
('11-3000', 2008, 'Corolla'),
('12-4000', 2013, 'Axio'),
('12-5000', 2013, 'Premio'),
('11-5000', 2010, 'Nano'),
('11-6000', 2011, 'Alto'),
('12-6000', 2015, 'Nano Twist');

INSERT INTO accident VALUES
('2013-01-12', 'Arif', 10000),
('2015-09-25', 'Komol', 12000),
('2014-06-20', 'Bahadur', 11000),
('2011-12-20', 'Abdul', 8000),
('2015-09-19', 'Akter', 7000),
('2013-05-15', 'Arif', 20000),
('2014-08-20', 'Arif', 15000);

INSERT INTO owns VALUES
('123451', '11-3000'),
('123452', '12-4000'),
('123453', '12-5000'),
('123454', '11-5000'),
('123455', '11-6000'),
('123456', '12-6000'),
('123457', '12-3000');

INSERT INTO log VALUES
('11-3000', '2013-01-12', 'Arif'),
('12-4000', '2015-09-25', 'Komol'),
('11-6000', '2014-06-20', 'Bahadur'),
('11-5000', '2011-12-20', 'Abdul'),
('12-6000', '2015-09-19', 'Akter'),
('11-3000', '2013-05-15', 'Arif'),
('11-3000', '2014-08-20', 'Arif');

-- b) People living in Rajshahi
SELECT name FROM person WHERE address = 'Rajshahi';

-- c) Models sold in 2013
SELECT DISTINCT model FROM car WHERE year = 2013;

-- d) Drivers with damage amount between 10000 and 15000
SELECT driver FROM accident WHERE damage_amount BETWEEN 10000 AND 15000;

-- e) NID of those who own Axio
SELECT o.nid FROM owns o JOIN car c ON o.license = c.license WHERE c.model = 'Axio';

-- f) Name and address of those who own Alto
SELECT p.name, p.address
FROM person p
JOIN owns o ON p.nid = o.nid
JOIN car c ON o.license = c.license
WHERE c.model = 'Alto';

-- g) Driver involved in accident on 2011-12-20
SELECT driver FROM accident WHERE date = '2011-12-20';

-- h) Owner of car 12-4000
SELECT p.name
FROM person p
JOIN owns o ON p.nid = o.nid
WHERE o.license = '12-4000';

-- i) Owner of car driven by Arif
SELECT DISTINCT p.name
FROM person p
JOIN owns o ON p.nid = o.nid
JOIN log l ON o.license = l.license
WHERE l.driver = 'Arif';

-- j) Car involved in accident on 2015-09-19
SELECT license FROM log WHERE date = '2015-09-19';

-- k) Number of accidents involving Arif’s cars
SELECT COUNT(*) FROM log WHERE driver = 'Arif';

-- l) Dates of accidents involving Arif’s cars
SELECT date FROM log WHERE driver = 'Arif';

-- m) Update Arif’s address to Nato
UPDATE person SET address = 'Nato' WHERE name = 'Arif';
