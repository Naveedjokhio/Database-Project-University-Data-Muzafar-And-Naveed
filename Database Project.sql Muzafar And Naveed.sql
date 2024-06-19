create database university ;
use university ;
-- Table: Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    MajorID INT
);

-- Table: Professors
CREATE TABLE Professors (
    ProfessorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

-- Table: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Table: Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT
);

-- Table: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(1)
);



-- Insert Data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Physics'),
(3, 'Mathematics'),
(4, 'Biology'),
(5, 'Chemistry');

-- Insert Data into Students
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, MajorID) VALUES
(1, 'Ali', 'Khan', '2000-01-15', 1),
(2, 'Sara', 'Malik', '1999-03-22', 2),
(3, 'Ahmed', 'Sheikh', '1998-07-18', 3),
(4, 'Ayesha', 'Zafar', '2001-05-05', 4),
(5, 'Bilal', 'Hussain', '2000-11-10', 5);

-- Insert Data into Professors
INSERT INTO Professors (ProfessorID, FirstName, LastName, DepartmentID) VALUES
(1, 'Dr. Kamran', 'Farooq', 1),
(2, 'Dr. Rabia', 'Qureshi', 2),
(3, 'Dr. Salman', 'Yousuf', 3),
(4, 'Dr. Nadia', 'Ali', 4),
(5, 'Dr. Faisal', 'Raza', 5);

-- Insert Data into Courses
INSERT INTO Courses (CourseID, CourseName, DepartmentID) VALUES
(101, 'Introduction to Programming', 1),
(102, 'Data Structures', 1),
(201, 'Quantum Physics', 2),
(202, 'Classical Mechanics', 2),
(301, 'Calculus I', 3),
(302, 'Linear Algebra', 3),
(401, 'General Biology', 4),
(402, 'Genetics', 4),
(501, 'Organic Chemistry', 5),
(502, 'Inorganic Chemistry', 5);

-- Insert Data into Enrollments
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 101, 'A'),
(2, 1, 102, 'B'),
(3, 2, 201, 'A'),
(4, 2, 202, 'A'),
(5, 3, 301, 'B'),
(6, 3, 302, 'C'),
(7, 4, 401, 'A'),
(8, 4, 402, 'B'),
(9, 5, 501, 'A'),
(10, 5, 502, 'A');

SELECT * FROM Students;


SELECT * FROM Professors;


SELECT * FROM Departments;


SELECT * FROM Courses;

SELECT * FROM Enrollments;


SELECT COUNT(*) AS TotalStudents FROM Students;


SELECT COUNT(*) AS TotalProfessors FROM Professors;

SELECT COUNT(*) AS TotalCourses FROM Courses;


SELECT * FROM Students ORDER BY StudentID DESC LIMIT 1;


SELECT * FROM Students ORDER BY DateOfBirth DESC LIMIT 1;

SELECT * FROM Students ORDER BY DateOfBirth ASC LIMIT 1;

-- 12. List distinct majors (departments) of students.
SELECT DISTINCT DepartmentName FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID; 


SELECT Students.* FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
WHERE Enrollments.CourseID = 101;

-- 14. List all courses offered by the 'Computer Science' department.
SELECT Courses.* FROM Courses
JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Computer Science';



-- 16. List the names of all students taking 'Introduction to Programming' course.
SELECT Students.FirstName, Students.LastName FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Introduction to Programming';

SELECT Departments.DepartmentName, COUNT(Students.StudentID) AS TotalStudents FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;

-- 19. Find the department with the most courses.
SELECT Departments.DepartmentName, COUNT(Courses.CourseID) AS TotalCourses FROM Courses
JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName
ORDER BY TotalCourses DESC LIMIT 1;

-- 20. List the courses taught by professors in the 'Physics' department.
SELECT Courses.CourseName FROM Courses
JOIN Professors ON Courses.DepartmentID = Professors.DepartmentID
JOIN Departments ON Professors.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Physics';

-- 21. Find the student with the most enrollments.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName
ORDER BY TotalEnrollments DESC LIMIT 1;

-- 22. List all students along with their majors.
SELECT Students.FirstName, Students.LastName, Departments.DepartmentName FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID;

-- 23. Find courses not taken by any student.
SELECT Courses.CourseName FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
WHERE Enrollments.CourseID IS NULL;

-- 24. Find students not enrolled in any course.
SELECT Students.FirstName, Students.LastName FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.StudentID IS NULL;

-- 25. List professors who teach in the 'Chemistry' department.
SELECT Professors.FirstName, Professors.LastName FROM Professors
JOIN Departments ON Professors.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Chemistry';

-- 26. List students and their total number of enrollments.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- 27. Find the course with the highest average grade.
SELECT Courses.CourseName, AVG(Enrollments.Grade) AS AverageGrade FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Courses.CourseName
ORDER BY AverageGrade DESC LIMIT 1;

-- 28. Find the average grade for each department.
SELECT Departments.DepartmentName, AVG(Enrollments.Grade) AS AverageGrade FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;

-- 29. List the first name, last name, and major of all students.
SELECT Students.FirstName, Students.LastName, Departments.DepartmentName FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID;

-- 30. Find the professor with the most courses.
SELECT Professors.ProfessorID, Professors.FirstName, Professors.LastName, COUNT(Courses.CourseID) AS TotalCourses FROM Professors
JOIN Courses ON Professors.DepartmentID = Courses.DepartmentID
GROUP BY Professors.ProfessorID, Professors.FirstName, Professors.LastName
ORDER BY TotalCourses DESC LIMIT 1;

-- 31. List all students in the 'Physics' department.
SELECT Students.FirstName, Students.LastName FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Physics';

-- 32. Find students who have a grade of 'A' in any course.
SELECT DISTINCT Students.FirstName, Students.LastName FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.Grade = 'A';

-- 33. List all courses along with the number of students enrolled in each.
SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS TotalStudents FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseName;

-- 34. Find the department with the most students.
SELECT Departments.DepartmentName, COUNT(Students.StudentID) AS TotalStudents FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID
GROUP BY Departments.DepartmentName
ORDER BY TotalStudents DESC LIMIT 1;

-- 35. Find students who have taken more than 3 courses.
SELECT Students.FirstName, Students.LastName, COUNT(Enrollments.CourseID) AS TotalCourses FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName
HAVING COUNT(Enrollments.CourseID) > 3;

-- 36. List all students and their grades in 'Quantum Physics'.
SELECT Students.FirstName, Students.LastName, Enrollments.Grade FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Quantum Physics';

-- 37. Find the average age of students in the 'Biology' department.
SELECT AVG(DATEDIFF(CURDATE(), Students.DateOfBirth) / 365) AS AverageAge FROM Students
JOIN Departments ON Students.MajorID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Biology';

-- 38. List all courses and their respective departments.
SELECT Courses.CourseName, Departments.DepartmentName FROM Courses
JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID;

-- 39. Find the student with the highest average grade.
SELECT Students.StudentID, Students.FirstName, Students.LastName, AVG(Enrollments.Grade) AS AverageGrade FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName
ORDER BY AverageGrade DESC LIMIT 1;

-- 40. List the names of all professors along with the department they belong to.
SELECT Professors.FirstName, Professors.LastName, Departments.DepartmentName FROM Professors
JOIN Departments ON Professors.DepartmentID = Departments.DepartmentID;

-- 41. List all students who have a 'B' grade in any course.
SELECT DISTINCT Students.FirstName, Students.LastName FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.Grade = 'B';

-- 42. Find the total number of enrollments in each course.
SELECT Courses.CourseName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments FROM Courses
JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseName;

-- 43. List all professors who have the first name 'Dr. Salman'.
SELECT * FROM Professors
WHERE FirstName = 'Dr. Salman';

-- 44. Find the student who has the lowest average grade.
SELECT Students.StudentID, Students.FirstName, Students.LastName, AVG(Enrollments.Grade) AS AverageGrade FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName
ORDER BY AverageGrade ASC LIMIT 1;

-- 45. List the courses taken by 'Ali Khan'.
SELECT Courses.CourseName FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Students.FirstName = 'Ali' AND Students.LastName = 'Khan';

-- 46. Find the average grade of 'Sara Malik'.
SELECT AVG(Enrollments.Grade) AS AverageGrade FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
WHERE Students.FirstName = 'Sara' AND Students.LastName = 'Malik';

-- 47. List all professors along with the courses they teach.
SELECT Professors.FirstName, Professors.LastName, Courses.CourseName FROM Professors
JOIN Courses ON Professors.DepartmentID = Courses.DepartmentID;

-- 48. Find students who have taken both 'Introduction to Programming' and 'Data Structures'.
SELECT Students.FirstName, Students.LastName FROM Students
JOIN Enrollments e1 ON Students.StudentID = e1.StudentID
JOIN Enrollments e2 ON Students.StudentID = e2.StudentID
JOIN Courses c1 ON e1.CourseID = c1.CourseID
JOIN Courses c2 ON e2.CourseID = c2.CourseID
WHERE c1.CourseName = 'Introduction to Programming' AND c2.CourseName = 'Data Structures';

-- 49. List the departments with an average grade greater than 'B'.
SELECT Departments.DepartmentName, AVG(Enrollments.Grade) AS AverageGrade FROM Departments
JOIN Courses ON Departments.DepartmentID = Courses.DepartmentID
JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Departments.DepartmentName
HAVING AVG(Enrollments.Grade) > 'B';

-- 50. Find the professor with the fewest courses.
SELECT Professors.ProfessorID, Professors.FirstName, Professors.LastName, COUNT(Courses.CourseID) AS TotalCourses FROM Professors
JOIN Courses ON Professors.DepartmentID = Courses.DepartmentID
GROUP BY Professors.ProfessorID, Professors.FirstName, Professors.LastName
ORDER BY TotalCourses ASC LIMIT 1;