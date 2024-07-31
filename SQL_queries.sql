USE coursework;


-- Query 1 comment what the query does - Selects all the people who are a part of a society, gives their name and the society they are a part of, it also shows their memebership type
-- makes use of INNER JOIN
SELECT Student.Stu_FName as "Student First Name", Student.Stu_LName as "Student Last Name", Society.Soc_Name as "Society Name", Register.Mem_Type as "Membership Type"
FROM  ((Register
INNER JOIN Student ON Register.URN=Student.URN)
INNER JOIN Society ON Register.Soc_ID=Society.Soc_ID);


-- Query 2 comment what the query does - Lists the people in Chess society, makes use of the Subquery
SELECT Student.Stu_FName as "Student First Name", Student.Stu_LName as "Student Last Name", Society.Soc_Name as "Society Name", Register.Mem_Type as "Membership Type"
FROM  ((Register
INNER JOIN Student ON Register.URN=Student.URN)
INNER JOIN Society ON Register.Soc_ID=Society.Soc_ID)
WHERE Society.Soc_ID =
	(SELECT Soc_ID
	FROM Society
	WHERE Soc_Name = "Chess");

-- Query 3 comment what the query does - Shows people and the number of hobbies each person has, makes use of a GROUP BY and Aggregrate function
SELECT Student.Stu_FName as "Student First Name", Student.Stu_LName as "Student Last Name", COUNT(Hobby.Hob_ID) as "Number of Hobbies"
FROM ((Interest
INNER JOIN Student ON Interest.URN = Student.URN)
INNER JOIN Hobby ON Interest.Hob_ID = Hobby.Hob_ID)
GROUP BY Stu_LName, Stu_FName;



-- If you want to do some more queries as the extra challenge task you can include them here

--Query 4 - Lists the categories of each society, along with their description. Uses a multivalued attribute and only a JOIN
SELECT Society.Soc_Name as "Society Name", Soc_Type.Soc_Catg as "Society Catgeory", Society.Soc_Desc as "Society Description"
FROM ((Soc_Type
INNER JOIN Society ON Soc_Type.Soc_ID = Society.Soc_ID));

--Query 5 - Lists the students who have the hobby Reading, uses a Subquery.
SELECT Student.Stu_FName as "Student First Name", Student.Stu_LName as "Student Last Name", Hobby.Hob_Name as "Hobby"
FROM ((Interest
INNER JOIN Student ON Interest.URN = Student.URN)
INNER JOIN Hobby ON Interest.Hob_ID = Hobby.Hob_ID)
WHERE Hobby.Hob_ID =
	(SELECT Hob_ID
	FROM Hobby
	WHERE Hob_Name = "Reading");

--Query 6 - Lists all the Student who are in Chess Society, makes use of only a subquery
SELECT Student.Stu_FName as "Student First Name", Student.Stu_LName as "Student Last Name"
FROM  Student
WHERE URN IN
	(SELECT Register.URN
	FROM Register
	WHERE Soc_ID = 200);