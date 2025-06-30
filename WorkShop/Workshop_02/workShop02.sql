CREATE DATABASE Workshop_02
USE Workshop_02

-- Create Users Table
CREATE TABLE tblUsers (
    username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Instructor', 'Student'))
);
-- Create Exam Categories Table
CREATE TABLE tblExamCategories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);
-- Create Exams Table
CREATE TABLE tblExams (
    exam_id INT PRIMARY KEY,
    exam_title VARCHAR(100) NOT NULL,
    Subject VARCHAR(50) NOT NULL,
    category_id INT,
    total_marks INT NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES tblExamCategories(category_id)
);

-- Create Questions Table
CREATE TABLE tblQuestions (
    question_id INT PRIMARY KEY,
    exam_id INT,
    question_text TEXT NOT NULL,
    option_a VARCHAR(100) NOT NULL,
    option_b VARCHAR(100) NOT NULL,
    option_c VARCHAR(100) NOT NULL,
    option_d VARCHAR(100) NOT NULL,
    correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('A', 'B', 'C', 'D')),
    FOREIGN KEY (exam_id) REFERENCES tblExams(exam_id)
);

INSERT INTO tblUsers (username, Name, password, Role) VALUES
('intructor1', 'Alex Johnson', 'intr123', 'Instructor'),
('student1', 'Maria Garcia', 'std123', 'Student'),
('intructor2', 'Robert Lee', 'intr123', 'Instructor'),
('student2', 'Sarah Wilson', 'std123', 'Student'),
('student3', 'Kevin Martinez', 'std123', 'Student');


INSERT INTO tblExamCategories (category_id, category_name, description) VALUES
(100, 'Assignment', 'Regular assignments for skill assessment.'),
(101, 'Test', 'Periodic tests during the semester.'),
(102, 'Project', 'Final projects for comprehensive evaluation.');



INSERT INTO tblExams (exam_id, exam_title, Subject, category_id, total_marks, Duration) VALUES
(1, 'Algebra Fundamentals Test', 'Mathematics', 101, 80, 75),
(2, 'Thermodynamics Assessment', 'Physics', 100, 60, 90),
(3, 'Organic Chemistry Project', 'Chemistry', 102, 120, 180),
(4, 'Literature Analysis Test', 'English', 101, 55, 60),
(5, 'Programming Logic Assignment', 'Computer Science', 100, 90, 120);




INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(1, 1, 'What is 2x + 5 = 11, solve for x?', '2', '3', '4', '5', 'B'),
(2, 1, 'What is the value of x² when x = 6?', '12', '24', '36', '48', 'C'),
(3, 2, 'What happens to gas volume when temperature increases at constant pressure?', 'Decreases', 'Increases', 'Stays same', 'Becomes zero', 'B'),
(4, 3, 'Which functional group characterizes alcohols?', '-COOH', '-OH', '-NH2', '-CHO', 'B'),
(5, 4, 'What literary device is used in "The stars danced in the sky"?', 'Metaphor', 'Personification', 'Simile', 'Alliteration', 'B');
