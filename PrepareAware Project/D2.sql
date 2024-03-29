/*
VEREN VILLEGAS
1574646
*/

DROP TABLE Teaches
DROP TABLE Qualified
DROP TABLE Attends
DROP TABLE Class
DROP TABLE Course
DROP TABLE Customer
DROP TABLE Instructor

CREATE TABLE Customer (
    email VARCHAR(255) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    sname VARCHAR(50) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Course (
    CourseID CHAR(5) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    certDuration INT NOT NULL
);

CREATE TABLE Class (
    ClassID INT PRIMARY KEY IDENTITY,
    location VARCHAR(100) NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME NOT NULL,
    CourseID CHAR(5) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);


CREATE TABLE Instructor (
    email VARCHAR(255) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    sname VARCHAR(50) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Attends (
    cEmail VARCHAR(255) NOT NULL,
    ClassID INT NOT NULL,
    mark DECIMAL(5, 2),
    PRIMARY KEY (cEmail, ClassID),
    FOREIGN KEY (cEmail) REFERENCES Customer (email),
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE Teaches (
    iEmail VARCHAR(255) NOT NULL,
    ClassID INT NOT NULL,
    PRIMARY KEY (iEmail, ClassID),
    FOREIGN KEY (iEmail) REFERENCES Instructor (email),
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE Qualified (
    iEmail VARCHAR(255) NOT NULL,
    CourseID CHAR(5) NOT NULL,
    PRIMARY KEY (iEmail, CourseID),
    FOREIGN KEY (iEmail) REFERENCES Instructor (email),
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

/*
Gets all the information about a class for all classes.
*/
GO
CREATE PROCEDURE getAllClasses as (SELECT Class.CourseID, location, startTime, endTime, fname, sname, Class.ClassID from (Class join Teaches on Class.ClassID = Teaches.ClassID) join Instructor on Instructor.email = Teaches.iEmail) ORDER BY startTime
GO

/*
Gets the class and course ID of all classes.
*/
GO
CREATE PROCEDURE getClassIDs as(SELECT Class.CourseID, Class.ClassID from Class) ORDER BY CourseID
GO

/*
Gets all classes that have a start date later than the current system date.
*/
GO
CREATE PROCEDURE getUpcomingClasses as (SELECT Class.CourseID, location, startTime, endTime, fname, sname, Class.ClassID from (Class join Teaches on Class.ClassID = Teaches.ClassID) join Instructor on Instructor.email = Teaches.iEmail where startTime > GETDATE()) ORDER BY (startTime)
GO

/*
Gets all classes that have a start date earlier than the current system date but have an end date later than the current system date.
*/
GO
CREATE PROCEDURE getCurrentClasses as (SELECT Class.CourseID, location, startTime, endTime, fname, sname, Class.ClassID from (Class join Teaches on Class.ClassID = Teaches.ClassID) join Instructor on Instructor.email = Teaches.iEmail where (startTime <= GETDATE() AND endTime >= GETDATE())) ORDER BY (startTime)
GO

/*
Gets all classes that have an enddate later than the current system date. 
*/
GO
CREATE PROCEDURE getPastClasses as (SELECT Class.CourseID, location, startTime, endTime, fname, sname, Class.ClassID from (Class join Teaches on Class.ClassID = Teaches.ClassID) join Instructor on Instructor.email = Teaches.iEmail where endTime < GETDATE()) ORDER BY (startTime)
GO

/*
Returns all items from the customers table.
RENAME TO SOMETHING BETTER.
*/
GO
CREATE PROCEDURE findStudentEmail as
(SELECT * from Customer) order by email
GO

GO
CREATE PROCEDURE recordNewMark (@sEmail VARCHAR(255) = null, @qClassID int = -1, @mark decimal = -1) as
if @sEmail IS NOT NULL AND @qClassID != -1 AND @mark != -1 BEGIN
	DECLARE @temp VARCHAR(255)
	DECLARE @classID int 
	SELECT @temp = cEmail from Attends where cEmail = @sEmail
	SELECT @classID = ClassID from Attends where ClassID = @qClassID
	--There is already a record for this student in this class. Update the mark.
	if @temp IS NOT null AND @classID IS NOT NULL
	BEGIN
		update Attends set mark =  @mark where cEmail = @sEmail AND ClassID = @qClassID
	END
	--The student does not have a record for this class. Make a new record.
	ELSE BEGIN
		INSERT into Attends(cEmail, ClassID, mark) values (@sEmail, @qClassID, @mark)
	END
END
GO

select * from Attends

/*
<summary>
Adds new students into the database. 
</summary>
*/
GO
CREATE PROCEDURE addNewStudent (@sEmail VARCHAR(255) = null, @sFname VARCHAR(50) = null, @sLname VARCHAR(50) = null, @sPhoneNumber VARCHAR(20) = null) as
if @sEmail IS NOT null AND @sFname IS NOT null AND @sLname IS NOT null BEGIN
		INSERT into Customer (email, fname, sname, phone) values (@sEmail, @sFname, @sLname, @sPhoneNumber)
END
GO

/*
Refactor for error checking
*/
GO
CREATE PROCEDURE getAllQualifiedInstructorNames (@courseID VARCHAR(5)) as (SELECT fname, sname from (Instructor join Qualified on Instructor.email = Qualified.iEmail) where Qualified.CourseID = @courseID) ORDER BY (fname)
EXEC getAllQualifiedInstructorNames 'FA101'
GO

/*
<summary>
Finds an instructor's email based of their first and last name.
@return iemail The instructor's email
</summary>
Refactor for error checking
*/
GO
CREATE PROCEDURE findInstructorEmail (@ifname VARCHAR(50), @iLname VARCHAR(50), @iEmail VARCHAR(50) OUT) as 
(SELECT @iEmail = email from Instructor where fname = @ifname AND sname = @iLname)
GO

/*
<summary>
Finds a class's ID based on the course ID, class location, start time and end time. 
@return classID The class's ID
</summary>
*/
GO
CREATE PROCEDURE findClassID ( @classID INT OUT) as
SELECT @classID = @@IDENTITY
GO

/*
<summary>
Inserts a new class into the class table.
Inserts a new teaches relationship into the Teaches table.
</summary>
Refactor for error checking
*/
GO
CREATE PROCEDURE createNewClass (@courseID VARCHAR(5), @courseLocation VARCHAR(50), @courseStart DATETIME, @courseEnd DATETIME, @iFname VARCHAR(50), @iLname VARCHAR(50)) as 
BEGIN
INSERT INTO Class (location, startTime, endTime, CourseID) values  (@courseLocation, @courseStart, @courseEnd, @courseID)
DECLARE @email VARCHAR(50)
DECLARE @classID INT
EXEC findInstructorEmail @iFname, @iLname, @email OUTPUT
EXEC findClassID @classID OUTPUT
INSERT INTO TEACHES(ClassID, iEmail) values (@classID , @email)
END
GO

EXEC createNewClass 'FA101', 'Test Room', '05/06/2023', '06/06/2023', 'Christina', 'Yang'

EXEC getAllClasses
EXEC getUpcomingClasses
EXEC getCurrentClasses
EXEC getPastClasses
EXEC findStudentEmail 

DROP PROCEDURE getAllClasses
DROP PROCEDURE getUpcomingClasses
DROP PROCEDURE getCurrentClasses
DROP PROCEDURE getPastClasses
DROP PROCEDURE getAllQualifiedInstructorNames
DROP PROCEDURE createNewClass
DROP PROCEDURE findClassID
DROP PROCEDURE findInstructorEmail
DROP PROCEDURE findStudentEmail
DROP PROCEDURE addNewStudent
DROP PROCEDURE getClassIDs
DROP PROCEDURE recordNewMark

select * from Customer
/*
Insert statements
*/
INSERT INTO Customer (email, fname, sname, phone) VALUES ('josh.baker@example.com', 'Josh', 'Baker', '858-546-1256')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('lisa.miller@example.com', 'Lisa', 'Miller', '415-789-4563')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('kevin.morgan@example.com', 'Kevin', 'Morgan', '312-654-9874')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('hannah.roberts@example.com', 'Hannah', 'Roberts', '212-456-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('david.johnson@example.com', 'David', 'Johnson', '303-987-6543')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('samantha.smith@example.com', 'Samantha', 'Smith', '617-123-4567')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('tom.williams@example.com', 'Tom', 'Williams', '212-456-1234')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('jessica.nguyen@example.com', 'Jessica', 'Nguyen', '415-789-1234')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('ryan.jackson@example.com', 'Ryan', 'Jackson', '312-654-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('olivia.parker@example.com', 'Olivia', 'Parker', '303-987-4563')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('natalie.jones@example.com', 'Natalie', 'Jones', '617-123-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('jacob.brown@example.com', 'Jacob', 'Brown', '212-456-7891')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('emily.davis@example.com', 'Emily', 'Davis', '415-789-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('michael.thomas@example.com', 'Michael', 'Thomas', '858-546-1234')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('sara.garcia@example.com', 'Sara', 'Garcia', '312-654-1234')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('adam.smith@example.com', 'Adam', 'Smith', '303-987-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('catherine.lee@example.com', 'Catherine', 'Lee', '617-123-4567')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('jason.green@example.com', 'Jason', 'Green', '212-456-7892')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('lily.harris@example.com', 'Lily', 'Harris', '415-789-1235')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('nathan.nguyen@example.com', 'Nathan', 'Nguyen', '858-546-7890')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('madison.turner@example.com', 'Madison', 'Turner', '312-654-1235')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('jordan.rivera@example.com', 'Jordan', 'Rivera', '303-987-1234')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('anthony.evans@example.com', 'Anthony', 'Evans', '617-123-7891')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('sophie.cooper@example.com', 'Sophie', 'Cooper', '212-456-7893')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('william.miller@example.com', 'William', 'Miller', '415-789-1236')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('jessie.nguyen@example.com', 'Jessie', 'Nguyen', '858-546-7891')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('james.garcia@example.com', 'James', 'Garcia', '312-654-1236')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('victoria.taylor@example.com', 'Victoria', 'Taylor', '303-987-7891')
INSERT INTO Customer (email, fname, sname, phone) VALUES ('ethan.martinez@example.com', 'Ethan', 'Martinez', '617-123-4568')

INSERT INTO Instructor (email, fname, sname, phone) VALUES ('meredith.grey@prepareaware.com', 'Meredith', 'Grey', '555-1234');
INSERT INTO Instructor (email, fname, sname, phone) VALUES ('gregory.house@prepareaware.com', 'Gregory', 'House', '555-5678');
INSERT INTO Instructor (email, fname, sname, phone) VALUES ('miranda.bailey@prepareaware.com', 'Miranda', 'Bailey', '555-9012');
INSERT INTO Instructor (email, fname, sname, phone) VALUES ('christina.yang@prepareaware.com', 'Christina', 'Yang', '555-3456');
INSERT INTO Instructor (email, fname, sname, phone) VALUES ('derek.shepherd@prepareaware.com', 'Derek', 'Shepherd', '555-7890');

INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA101', 'Basic First Aid', 99.99, 12);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA102', 'CPR and AED', 149.99, 12);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA103', 'Wilderness Survival', 299.99, 24);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA104', 'Pediatric First Aid', 199.99, 24);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA105', 'First Aid for Dogs and Cats', 79.99, 24);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA106', 'Sports First Aid', 199.99, 12);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA107', 'Mental Health', 149.99, 12);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA108', 'Workplaces Safety', 149.99, 12);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA109', 'Industrial Safety', 399.99, 6);
INSERT INTO Course (CourseID, name, cost, certDuration) VALUES ('FA110', 'First Aid for Burn Victims', 99.99, 12);

INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room I', '2024-07-01 19:00:00', '2025-04-01 23:59:59', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room I', '2023-05-23 14:00:00', '2023-05-23 17:00:00', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room O', '2023-05-23 13:00:00', '2023-05-23 16:00:00', 'FA104')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room U', '2023-05-23 13:00:00', '2023-05-23 17:00:00', 'FA106')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room P', '2023-05-23 12:00:00', '2023-05-23 17:00:00', 'FA108')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room M', '2023-05-23 11:00:00', '2023-05-23 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room O', '2023-05-23 12:00:00', '2023-05-23 17:00:00', 'FA104')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room D', '2023-05-23 10:00:00', '2023-05-23 17:00:00', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room C', '2023-05-23 10:00:00', '2023-05-23 15:00:00', 'FA103')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room Z', '2023-05-23 13:00:00', '2023-05-23 17:00:00', 'FA107')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room I', '2023-05-23 13:00:00', '2023-05-23 17:00:00', 'FA109')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room H', '2023-08-11 14:00:00', '2023-08-11 17:00:00', 'FA107')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room W', '2023-07-19 11:00:00', '2023-07-19 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room G', '2023-06-25 11:00:00', '2023-06-25 17:00:00', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room U', '2023-08-05 14:00:00', '2023-08-05 17:00:00', 'FA109')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room Y', '2023-05-24 11:00:00', '2023-05-24 14:00:00', 'FA104')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room I', '2023-07-18 11:00:00', '2023-07-18 17:00:00', 'FA106')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room H', '2023-05-02 10:00:00', '2023-05-02 11:00:00', 'FA102')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room J', '2023-05-17 13:00:00', '2023-05-17 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room J', '2023-05-14 14:00:00', '2023-05-14 17:00:00', 'FA104')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room E', '2023-05-05 9:00:00', '2023-05-05 16:00:00', 'FA110')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room P', '2023-05-17 9:00:00', '2023-05-17 10:00:00', 'FA103')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room H', '2023-08-21 9:00:00', '2023-08-21 14:00:00', 'FA106')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room S', '2023-05-19 12:00:00', '2023-05-19 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room P', '2023-08-02 13:00:00', '2023-08-02 17:00:00', 'FA108')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room G', '2023-07-27 11:00:00', '2023-07-27 16:00:00', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room D', '2023-06-04 10:00:00', '2023-06-04 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room X', '2023-06-14 12:00:00', '2023-06-14 17:00:00', 'FA101')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room C', '2023-07-07 13:00:00', '2023-07-07 17:00:00', 'FA104')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room I', '2023-07-12 14:00:00', '2023-07-12 17:00:00', 'FA108')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room O', '2023-05-24 11:00:00', '2023-05-24 17:00:00', 'FA102')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room K', '2023-06-11 11:00:00', '2023-06-11 12:00:00', 'FA102')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room V', '2023-05-24 10:00:00', '2023-05-24 17:00:00', 'FA107')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room T', '2023-06-16 12:00:00', '2023-06-16 17:00:00', 'FA106')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room N', '2023-05-18 14:00:00', '2023-05-18 17:00:00', 'FA102')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room N', '2023-06-06 12:00:00', '2023-06-06 14:00:00', 'FA109')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room Q', '2023-06-15 9:00:00', '2023-06-15 12:00:00', 'FA110')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room T', '2023-05-19 14:00:00', '2023-05-19 17:00:00', 'FA102')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room U', '2023-07-06 14:00:00', '2023-07-06 17:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room Z', '2023-07-16 10:00:00', '2023-07-16 12:00:00', 'FA105')
INSERT INTO Class (location, startTime, endTime, CourseID) VALUES ('Room F', '2023-05-30 11:00:00', '2023-05-30 16:00:00', 'FA109')

INSERT INTO Qualified (iEmail, CourseID) VALUES ('gregory.house@prepareaware.com', 'FA101')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('derek.shepherd@prepareaware.com', 'FA101')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA101')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('christina.yang@prepareaware.com', 'FA101')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA102')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('christina.yang@prepareaware.com', 'FA102')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('gregory.house@prepareaware.com', 'FA103')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('miranda.bailey@prepareaware.com', 'FA103')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA103')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('christina.yang@prepareaware.com', 'FA104')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('miranda.bailey@prepareaware.com', 'FA104')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA104')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('christina.yang@prepareaware.com', 'FA105')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA105')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('gregory.house@prepareaware.com', 'FA105')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('derek.shepherd@prepareaware.com', 'FA105')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('christina.yang@prepareaware.com', 'FA106')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('miranda.bailey@prepareaware.com', 'FA106')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('gregory.house@prepareaware.com', 'FA107')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA108')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('derek.shepherd@prepareaware.com', 'FA108')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('miranda.bailey@prepareaware.com', 'FA108')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('meredith.grey@prepareaware.com', 'FA109')
INSERT INTO Qualified (iEmail, CourseID) VALUES ('miranda.bailey@prepareaware.com', 'FA110')

INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 1)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 2)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 2)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 3)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 3)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 3)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 4)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 5)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 5)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 6)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 6)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 6)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 7)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 8)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 8)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 9)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 9)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 9)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 10)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 11)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 12)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 12)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 12)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 13)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 13)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 14)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 15)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 15)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 16)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 16)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 16)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 17)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 17)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 17)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 18)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 19)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 19)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 19)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 20)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 20)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 21)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 21)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 21)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 22)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 22)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 23)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 23)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 24)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 24)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 25)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 25)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 26)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 26)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 26)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 27)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 27)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 27)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 28)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 29)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 29)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 29)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 30)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 30)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 31)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 31)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 31)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 32)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 32)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 32)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 33)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 34)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 35)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 36)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 37)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 38)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('meredith.grey@prepareaware.com', 38)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('christina.yang@prepareaware.com', 38)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 39)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 39)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('gregory.house@prepareaware.com', 40)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('miranda.bailey@prepareaware.com', 40)
INSERT INTO Teaches (iEmail, ClassID) VALUES ('derek.shepherd@prepareaware.com', 40)

INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 1, 41)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 1, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 1, 42)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 1, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 1, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 1, 80)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 1, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 1, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 1, 35)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 1, 69)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 1, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 1, 91)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 1, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 1, 76)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 1, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 1, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 1, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 1, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 1, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 1, 38)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 2, 7)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 2, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 2, 37)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 2, 45)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 2, 86)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 3, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 3, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 3, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 3, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 3, 88)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 3, 93)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 3, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 3, 26)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 3, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 3, 39)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 3, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 3, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 3, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 3, 10)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 4, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 4, 29)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 4, 47)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 4, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 4, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 4, 56)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 4, 88)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 4, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 4, 18)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 4, 10)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 5, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 5, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 5, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 5, 5)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 5, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 5, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 5, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 5, 37)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 5, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 6, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 6, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 6, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 6, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 6, 82)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 6, 29)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 6, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 6, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 6, 50)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 6, 13)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 7, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 7, 31)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 7, 71)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 7, 48)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 7, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 7, 59)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 7, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 7, 12)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 7, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 7, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 7, 42)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 7, 35)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 7, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 7, 78)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 8, 39)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 8, 6)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 8, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 8, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 8, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 8, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 9, 75)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 9, 59)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 9, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 9, 29)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 9, 3)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 9, 53)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 10, 2)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 10, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 10, 46)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 10, 53)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 10, 73)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 10, 65)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 10, 14)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 10, 47)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 10, 75)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 10, 21)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 10, 7)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 10, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 10, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 10, 78)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 10, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 11, 23)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 11, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 11, 70)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 11, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 11, 88)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 11, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 11, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 11, 4)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 11, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 11, 3)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 11, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 11, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 11, 27)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 11, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 11, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 11, 82)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 11, 1)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 11, 62)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 11, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 12, 6)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 12, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 12, 50)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 12, 75)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 12, 47)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 12, 21)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 12, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 12, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 12, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 12, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 12, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 12, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 12, 10)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 12, 13)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 12, 10)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 12, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 13, 4)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 13, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 13, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 13, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 13, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 14, 86)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 14, 38)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 14, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 14, 4)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 14, 39)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 14, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 14, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 15, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 15, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 15, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 15, 38)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 15, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 15, 3)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 15, 35)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 15, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 15, 7)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 15, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 16, 56)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 16, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 16, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 16, 78)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 16, 58)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 16, 76)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 16, 6)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 16, 0)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 16, 89)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 17, 14)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 17, 48)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 17, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 17, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 17, 91)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 17, 85)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 17, 4)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 17, 97)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 17, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 17, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 17, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 17, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 17, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 17, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 17, 58)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 17, 28)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 18, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 18, 41)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 18, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 18, 98)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 18, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 18, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 18, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 18, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 18, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 18, 45)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 18, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 18, 67)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 18, 57)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 18, 67)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 18, 12)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 19, 80)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 19, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 19, 97)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 19, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 19, 80)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 19, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 19, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 19, 74)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 19, 50)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 19, 2)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 19, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 19, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 19, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 19, 67)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 19, 0)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 19, 25)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 20, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 20, 86)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 20, 57)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 20, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 20, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 20, 5)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 20, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 20, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 20, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 20, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 20, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 20, 31)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 20, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 20, 21)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 21, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 21, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 21, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 21, 85)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 21, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 22, 93)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 22, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 22, 26)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 22, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 22, 82)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 22, 39)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 22, 80)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 22, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 22, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 22, 13)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 22, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 22, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 23, 26)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 23, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 23, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 23, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 23, 21)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 23, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 23, 25)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 23, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 23, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 23, 62)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 23, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 23, 53)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 23, 56)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 23, 3)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 24, 92)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 24, 89)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 24, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 24, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 24, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 24, 47)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 24, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 25, 89)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 25, 57)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 25, 2)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 25, 1)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 25, 73)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 25, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 25, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 25, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 25, 76)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 25, 7)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 25, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 25, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 25, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 25, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 26, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 26, 85)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 26, 28)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 26, 30)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 26, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 26, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 26, 75)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 26, 57)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 26, 91)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 26, 50)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 26, 6)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 26, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 26, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 26, 62)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 26, 61)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 26, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 26, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 26, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 27, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 27, 26)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 27, 7)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 27, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 27, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 27, 18)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 27, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 27, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 27, 65)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 27, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 27, 31)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 27, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 27, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 27, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 27, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 27, 82)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 27, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 28, 58)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 28, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 28, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 28, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 28, 76)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 28, 35)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 28, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 28, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 28, 51)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 28, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 28, 59)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 28, 86)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 28, 42)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 29, 49)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 29, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 29, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 29, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 29, 27)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 29, 31)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 29, 17)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 29, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 29, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 29, 28)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 29, 8)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 29, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 29, 50)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 29, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 29, 45)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 29, 52)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 29, 49)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 29, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 29, 2)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 29, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 30, 85)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 30, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 30, 48)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 30, 45)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 30, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 30, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 30, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 30, 29)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 30, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 30, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 30, 74)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 30, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 30, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 30, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 30, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 30, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 30, 82)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 30, 4)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 30, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 31, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 31, 1)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 31, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 31, 33)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 31, 62)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 31, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 32, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 32, 99)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 32, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 32, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 32, 28)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 32, 45)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 32, 21)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 33, 44)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 33, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 33, 56)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 33, 52)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 33, 42)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 33, 72)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 34, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 34, 71)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 34, 99)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 34, 49)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 34, 70)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 34, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 34, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 34, 30)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 34, 54)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 34, 98)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 35, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 35, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 35, 13)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 35, 40)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 35, 84)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 35, 25)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 35, 96)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 35, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 35, 49)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 35, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 35, 83)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 35, 1)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 35, 9)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 35, 78)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 35, 19)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 35, 61)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 35, 20)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 35, 18)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 36, 86)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 36, 73)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 36, 74)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 36, 10)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 36, 49)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 36, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 37, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 37, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 37, 59)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 37, 59)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lisa.miller@example.com', 37, 64)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 37, 29)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 37, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 37, 56)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 37, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('david.johnson@example.com', 37, 15)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 37, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 37, 75)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('kevin.morgan@example.com', 37, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 37, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 37, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 37, 30)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 37, 28)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 38, 66)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('lily.harris@example.com', 38, 5)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 38, 13)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('hannah.roberts@example.com', 38, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 38, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 38, 6)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 38, 52)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('josh.baker@example.com', 38, 39)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('victoria.taylor@example.com', 38, 22)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 38, 70)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 38, 43)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 38, 95)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('michael.thomas@example.com', 38, 16)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 38, 77)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 38, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('emily.davis@example.com', 38, 81)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 38, 87)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 38, 68)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 38, 36)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('madison.turner@example.com', 39, 42)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('catherine.lee@example.com', 39, 24)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('adam.smith@example.com', 39, 1)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 39, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 39, 74)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 39, 90)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('tom.williams@example.com', 39, 32)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 39, 38)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('olivia.parker@example.com', 39, 89)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessie.nguyen@example.com', 40, 34)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('samantha.smith@example.com', 40, 60)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jacob.brown@example.com', 40, 2)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('anthony.evans@example.com', 40, 79)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('nathan.nguyen@example.com', 40, 17)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('natalie.jones@example.com', 40, 55)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ethan.martinez@example.com', 40, 98)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sara.garcia@example.com', 40, 23)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('sophie.cooper@example.com', 40, 100)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('william.miller@example.com', 40, 11)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jason.green@example.com', 40, 18)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('ryan.jackson@example.com', 40, 94)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jessica.nguyen@example.com', 40, 23)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('james.garcia@example.com', 40, 63)
INSERT INTO Attends (cEmail, ClassID, mark) VALUES ('jordan.rivera@example.com', 40, 23)
