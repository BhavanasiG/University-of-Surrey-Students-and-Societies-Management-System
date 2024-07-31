DROP DATABASE IF EXISTS coursework;

CREATE DATABASE coursework;

USE coursework;

-- This is the Course table, I've edited this such that Course
-- is the supertype for Undergraduate and Postgraduate course
 
DROP TABLE IF EXISTS Course;

CREATE TABLE Course (
Crs_Code 	INT UNSIGNED NOT NULL,
Crs_Title 	VARCHAR(255) NOT NULL,
Crs_Enrollment INT UNSIGNED,
Crs_Type ENUM('UG', 'PG'),
PRIMARY KEY (Crs_code));


INSERT INTO Course VALUES 
(100,'BSc Computer Science', 150, 'UG'),
(101,'BSc Computer Information Technology', 20, 'UG'),
(200, 'MSc Data Science', 100, 'PG'),
(201, 'MSc Security', 30, 'PG'),
(210, 'MSc Electrical Engineering', 70, 'PG'),
(211, 'BSc Physics', 100, 'UG'),
(212, 'MSc Physics', 50, 'PG'),
(205, 'MEng Computer Science', 15, 'UG'),
(110, 'BEng Aerospace Engineering', 30, 'UG'),
(220, 'BMBS Medicine', 40, 'PG');

DROP TABLE IF EXISTS Student;

-- I've edited the student table so that only unique phone numbers can be added
-- and that URN's must be 6 digits long
CREATE TABLE Student (
URN INT UNSIGNED NOT NULL CHECK (100000 <= URN <= 999999),
Stu_FName 	VARCHAR(255) NOT NULL,
Stu_LName 	VARCHAR(255) NOT NULL,
Stu_DOB 	DATE,
Stu_Phone 	VARCHAR(12),
Stu_Course	INT UNSIGNED NOT NULL,
Stu_Type 	ENUM('UG', 'PG'),
UNIQUE (Stu_Phone),
PRIMARY KEY (URN),
FOREIGN KEY (Stu_Course) REFERENCES Course (Crs_Code)
ON DELETE RESTRICT);


INSERT INTO Student VALUES
(612345, 'Sara', 'Khan', '2002-06-20', '01483112233', 100, 'UG'),
(612346, 'Pierre', 'Gervais', '2002-03-12', '01483223344', 100, 'UG'),
(612347, 'Patrick', 'O-Hara', '2001-05-03', '01483334455', 100, 'UG'),
(612348, 'Iyabo', 'Ogunsola', '2002-04-21', '01483445566', 100, 'UG'),
(612349, 'Omar', 'Sharif', '2001-12-29', '01483778899', 100, 'UG'),
(612350, 'Yunli', 'Guo', '2002-06-07', '01483123456', 100, 'UG'),
(612351, 'Costas', 'Spiliotis', '2002-07-02', '01483234567', 100, 'UG'),
(612352, 'Tom', 'Jones', '2001-10-24',  '01483456789', 101, 'UG'),
(612353, 'Simon', 'Larson', '2002-08-23', '01483998877', 101, 'UG'),
(612354, 'Sue', 'Smith', '2002-05-16', '01483776655', 101, 'UG');

DROP TABLE IF EXISTS Undergraduate;

CREATE TABLE Undergraduate (
UG_URN 	INT UNSIGNED NOT NULL,
UG_Credits   INT NOT NULL,
CHECK (60 <= UG_Credits <= 150),
PRIMARY KEY (UG_URN),
FOREIGN KEY (UG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Undergraduate VALUES 
(612345, 120),
(612346, 90),
(612347, 150),
(612348, 120),
(612349, 120),
(612350, 60),
(612351, 60),
(612352, 90),
(612353, 120),
(612354, 90);

DROP TABLE IF EXISTS Postgraduate;

CREATE TABLE Postgraduate (
PG_URN 	INT UNSIGNED NOT NULL,
Thesis  VARCHAR(512) NOT NULL,
PRIMARY KEY (PG_URN),
FOREIGN KEY (PG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);


-- Please add your table definitions below this line.......

-- This is the Hobby table definition
DROP TABLE IF EXISTS Hobby;

CREATE TABLE Hobby (
Hob_ID INT UNSIGNED NOT NULL,
Hob_Name VARCHAR(20) NOT NULL,
PRIMARY KEY (Hob_ID));

INSERT INTO Hobby VALUES 
(100,'Reading'),
(200,'Hiking'),
(300, 'Chess'),
(400, 'Taichi'),
(500, 'Ballroom Dancing'),
(601, 'Football'),
(602, 'Tennis'),
(603, 'Rugby'),
(604, 'Climbing'),
(605, 'Rowing');

-- This is the Society table definition
DROP TABLE IF EXISTS Society;

CREATE TABLE Society (
Soc_ID INT UNSIGNED NOT NULL,
Soc_Name VARCHAR(20) NOT NULL,
Soc_Desc VARCHAR(500),
PRIMARY KEY (Soc_ID));

INSERT INTO Society VALUES
(100, 'Book Club', 'Society for bookworms of all ages and interests.'),
(200, 'Chess', 'Chess players of all abilities welcome.'),
(300, 'Martial Arts', 'The first rule of Fight Club is: You do not talk about Fight Club.'),
(400, 'Dancing', 'Exhaustive or Slow-paced, all dance types welcome.'),
(500, 'Water Sports', 'The only society for Rowing, Swiming, Water Polo and all other Water Sports.'),
(600, 'Physical Sports', 'Society for all land based physical sports, such as Football, Cricket and more.');


-- This the bridge entity for Student and Hobby, called Interest
DROP TABLE IF EXISTS Interest;

CREATE TABLE Interest (
URN INT UNSIGNED NOT NULL,
Hob_ID INT UNSIGNED NOT NULL,
FOREIGN KEY (URN) REFERENCES Student(URN)
ON DELETE CASCADE,
FOREIGN KEY (Hob_ID) REFERENCES Hobby(Hob_ID)
ON DELETE CASCADE,
PRIMARY KEY (URN, Hob_ID));

INSERT INTO Interest VALUES 
(612345, 100),
(612345, 200),
(612346, 601),
(612346, 602),
(612347, 400),
(612347, 603),
(612347, 500),
(612354, 100),
(612354, 200),
(612354, 300),
(612354, 500),
(612354, 602),
(612353, 604),
(612353, 605),
(612353, 200),
(612350, 100),
(612351, 300),
(612351, 100),
(612352, 601);

-- This is the bridge entity for Student and Society, called Register
DROP TABLE IF EXISTS Register;

CREATE TABLE Register (
URN	INT UNSIGNED NOT NULL,
Soc_ID	INT UNSIGNED NOT NULL,
Mem_Type	ENUM ('Member', 'Chair', 'Treasurer', 'Secretary' ) NOT NULL,-- Participants of a Scoiety can have 1 of 4 roles
FOREIGN KEY (URN) REFERENCES Student(URN)
ON DELETE CASCADE,
FOREIGN KEY (Soc_ID) REFERENCES Society(Soc_ID)
ON DELETE CASCADE,
PRIMARY KEY (URN, Soc_ID));


INSERT INTO Register VALUES 
(612351, 200, 'Chair'),
(612354, 200, 'Secretary'),
(612346, 600, 'Secretary'),
(612352, 600, 'Chair'),
(612350, 100, 'Chair'),
(612354, 100 , 'Member'),
(612347, 300, 'Treasurer');

-- This is the relation for the multivalued attribute of Society Category 
DROP TABLE IF EXISTS Soc_Type;

CREATE TABLE Soc_Type (
Soc_ID INT UNSIGNED NOT NULL,
Soc_Catg ENUM ('Active', 'Relaxed', 'Difficult', 'In-Person', 'Online'),
FOREIGN KEY (Soc_ID) REFERENCES Society(Soc_ID)
ON DELETE CASCADE,
PRIMARY KEY (Soc_ID, Soc_Catg));

INSERT INTO Soc_Type VALUES
(100, 'Relaxed'),
(100, 'In-Person'),
(100, 'Online'),
(200, 'Active'),
(200, 'In-Person'),
(200, 'Online'),
(300, 'Active'),
(300, 'In-Person'),
(300, 'Difficult'),
(400, 'Active'),
(400, 'Relaxed'),
(400, 'In-Person'),
(500, 'Active'),
(500, 'In-Person'),
(600, 'Active'),
(600, 'In-Person');

-- I define the subtype of undergaduate course here
DROP TABLE IF EXISTS Undergraduate_Crs;

CREATE TABLE Undergraduate_Crs (
Crs_Code INT UNSIGNED NOT NULL,
NonStudy_Year ENUM ('Year Abroad','Placement Year'),
PRIMARY KEY (Crs_Code),
FOREIGN KEY (Crs_Code) REFERENCES Course(Crs_Code)
ON DELETE CASCADE);

INSERT INTO Undergraduate_Crs VALUES
(100, 'Placement Year'),
(101, 'Placement Year'),
(211, 'Year Abroad'),
(205, 'Year Abroad'),
(110, 'Placement Year');

-- I define the subtype of postgraduate course here
DROP TABLE IF EXISTS Postgraduate_Crs;

CREATE TABLE Postgraduate_Crs (
Crs_Code INT UNSIGNED NOT NULL,
Hrs_Taught INT UNSIGNED NOT NULL,
PRIMARY KEY (Crs_Code),
FOREIGN KEY (Crs_Code) REFERENCES Course(Crs_Code)
ON DELETE CASCADE);

INSERT INTO Postgraduate_Crs VALUES
(200, 300),
(201, 270),
(210, 280),
(212, 290),
(220, 300);
