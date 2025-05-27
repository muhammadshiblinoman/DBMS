show databases;
use students;
create table studentTable(
	roll varchar(30) primary key,
	name varchar(30),
	dept varchar(30),
	year varchar(30),
	semester varchar(10)
);

insert into studentTable(roll, name, dept, year, semester) values
("06543201", "Rahim", "BBA", "2nd", "1st"),
("06543202", "Karim", "ICE", "2nd", "1st"),
("06543203", "Motin", "CSE", "1st", "2nd"),
("05654456", "Swadhin", "CSE", "1st", "2nd"),
("05654457", "Hena", "BBA", "4th", "2nd"),
("05654458", "Sohag", "CSE", "3rd", "1st");

select * from studentTable;
use students;
create table studentInfo(
	roll varchar(30),
    name varchar(30),
    fatherName varchar(30),
    Address varchar(30),
    Mobile varchar(30)
);
insert into studentInfo(roll, name, dept, fatherName, Address, Mobile) values
("06543201", "Rahim", "Rajshahi", "Rajshahi", "01719201233"),
("06543202", "Karim", "Tareq", "Dhaka", "01719202020"),
("06543203", "Motin", "Rahman", "Khulna", "01719202678"),
("05654456", "Swadhin", "Fazlu", "Rajshahi", "01719204564"),
("05654457", "Hena", "Rahman", "Rajshahi", "01119212020"),
("05654458", "Sohag", "Fazlul", "Natore", "01719202222");
  
SELECT Name FROM studentTable WHERE Semester = "1st";
SELECT Name FROM studentTable WHERE Semester = "2nd";
SELECT Name FROM studentTable WHERE dept = "CSE";
SELECT Name FROM studentTable WHERE roll = "06543201";

SELECT Name FROM studentInfo WHERE fatherName = "Rahman";
SELECT Name FROM studentInfo WHERE Mobile = "01719202020";
SELECT Name FROM studentInfo WHERE Address = "Rajshahi";
SELECT Name FROM studentInfo WHERE roll = "05654456";


    