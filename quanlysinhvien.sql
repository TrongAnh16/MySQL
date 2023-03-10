USE QuanLySinhVien;
CREATE TABLE Class (
    ClassID INTEGER PRIMARY KEY AUTO_INCREMENT,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);
CREATE TABLE Student (
    StudentID INTEGER PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassID INT NOT NULL,
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE Subject (
    SubID INTEGER PRIMARY KEY AUTO_INCREMENT,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Subject.Credit >= 1 ),
    Status BIT DEFAULT 1
);

CREATE TABLE Mark(
    MarkID INTEGER PRIMARY KEY AUTO_INCREMENT,
    SubID INT NOT NULL,
    StudentID INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    FOREIGN KEY (SubID) REFERENCES Subject (SubID),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID)
);

INSERT INTO Class
VALUES (1, 'A1','2008-12-20',1);
INSERT INTO Class
VALUES (2, 'A2','2008-12-22',1);
INSERT INTO Class
VALUES (3, 'B3',current_date,1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

SELECT * FROM  Student;

SELECT * FROM Student WHERE Status = 1;

SELECT * FROM Subject WHERE Credit < 10;

SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.StudentId = C.ClassID
WHERE C.ClassName = 'A1';

SELECT * FROM Student
WHERE StudentName LIKE 'h%';

SELECT * FROM Class
WHERE StartDate LIKE '%-12-%';

SELECT * FROM Subject
WHERE Credit >= 3 AND Credit <= 5;

UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

SELECT Student.StudentName, Subject.SubName, Mark.Mark
FROM ((Student
LEFT JOIN Mark ON Student.StudentID = Mark.StudentID
    )
LEFT JOIN Subject ON Subject.SubID = Mark.SubID)
ORDER BY Mark DESC, StudentName ASC;

-- Hi???n th??? t???t c??? c??c th??ng tin m??n h???c (b???ng subject) c?? credit l???n nh???t.
SELECT *
FROM Subject
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- Hi???n th??? c??c th??ng tin m??n h???c c?? ??i???m thi l???n nh???t.
SELECT *
FROM Subject
INNER JOIN Mark M on Subject.SubID = M.SubID
WHERE Mark = (SELECT MAX(Mark) FROM Mark);

-- Hi???n th??? c??c th??ng tin sinh vi??n v?? ??i???m trung b??nh c???a m???i sinh vi??n, x???p h???ng theo th??? t??? ??i???m gi???m d???n
SELECT Student.StudentID, StudentName, AVG(Mark) AS AVGMark
FROM Student
INNER JOIN Mark M on Student.StudentID = M.StudentID
GROUP BY Student.StudentID, Student.StudentName
ORDER BY AVGMark DESC;

-- Hi???n th??? s??? l?????ng sinh vi??n ??? t???ng n??i
SELECT Address, COUNT(StudentID) AS 'S??? l?????ng h???c vi??n'
FROM Student
GROUP BY Address;

-- T??nh ??i???m trung b??nh c??c m??n h???c c???a m???i h???c vi??n
SELECT Student.StudentID, Student.StudentName, AVG(Mark.Mark)
FROM Student
INNER JOIN Mark ON student.StudentID = Mark.StudentID
GROUP BY Student.StudentID, Student.StudentName;

-- Hi???n th??? nh???ng b???n h???c vi??n c?? ??i???m trung b??nh c??c m??n h???c l???n h??n 15
SELECT Student.StudentID, Student.StudentName, AVG(Mark.Mark)
FROM Student
INNER JOIN Mark ON student.StudentID = Mark.StudentID
GROUP BY Student.StudentID, Student.StudentName
HAVING AVG(Mark.Mark) > 15;

-- Hi???n th??? th??ng tin c??c h???c vi??n c?? ??i???m trung b??nh l???n nh???t.
SELECT Student.StudentID, Student.StudentName, AVG(Mark.Mark)
FROM Student
INNER JOIN Mark ON student.StudentID = Mark.StudentID
GROUP BY Student.StudentID, Student.StudentName
HAVING AVG(Mark.Mark) >= ALL (SELECT AVG(Mark.Mark) FROM Mark GROUP BY Mark.StudentID);

