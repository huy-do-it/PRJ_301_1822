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
('instructor1', 'Alex Johnson_AD', 'intr123', 'Instructor'),
('student1', 'Maria Garcia', 'std123', 'Student'),
('instructor2', 'Robert Lee_AD', 'intr123', 'Instructor'),
('student2', 'Sarah Wilson', 'std123', 'Student'),
('student3', 'Kevin Martinez', 'std123', 'Student');



INSERT INTO tblExamCategories (category_id, category_name, description)
VALUES 
    (1, 'Quiz', 'Short tests to assess knowledge during the course'),
    (2, 'Midterm', 'Mid-semester examination'),
    (3, 'Final', 'End of course comprehensive exam');




INSERT INTO tblExams (exam_id, exam_title, Subject, category_id, total_marks, Duration) VALUES
(1, 'Algebra Fundamentals Test', 'Mathematics', 1, 80, 75),
(2, 'Thermodynamics Assessment', 'Physics', 2, 60, 90),
(3, 'Organic Chemistry Project', 'Chemistry', 3, 100, 180),
(4, 'Literature Analysis Test', 'English', 2, 55, 60),
(5, 'Programming Logic Assignment', 'Computer Science', 1, 90, 120);



-- Mathematics (Exam 1)
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(6, 1, 'Solve for y: 3y - 7 = 11.', '4', '5', '6', '7', 'C'),
(7, 1, 'Which of these is a linear equation?', 'y = 2x^2', 'y = 3x + 1', 'x^2 + y^2 = 1', 'y = x^3', 'B'),
(8, 1, 'What is the solution to 5x = 25?', '1', '5', '10', '25', 'B'),
(9, 1, 'If x + 3 = 8, what is x?', '1', '3', '5', '8', 'C'),
(10, 1, 'What is the value of 7x when x = 2?', '9', '10', '12', '14', 'D'),
(11, 1, 'Which equation represents a straight line?', 'y = 2x + 5', 'y = x^2', 'y = x^3', 'y = 1/x', 'A'),
(12, 1, 'Solve for a: 4a = 16.', '2', '4', '8', '16', 'B'),
(13, 1, 'If 3x = 12, x = ?', '2', '3', '4', '5', 'C'),
(14, 1, 'What is the value of x in x/2 = 7?', '3', '7', '14', '21', 'C'),
(15, 1, 'Which of the following is NOT an algebraic expression?', '3x + 2', 'x^2 - 5', '7', '2x = 5', 'D');

-- Physics (Exam 2)
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(16, 2, 'What is the SI unit for temperature?', 'Joule', 'Kelvin', 'Celsius', 'Watt', 'B'),
(17, 2, 'Which law explains the relationship between pressure and volume?', 'Boyle''s Law', 'Newton''s Law', 'Ohm''s Law', 'Kepler''s Law', 'A'),
(18, 2, 'What does entropy measure?', 'Energy', 'Order', 'Disorder', 'Pressure', 'C'),
(19, 2, 'Which process is exothermic?', 'Melting ice', 'Burning fuel', 'Evaporation', 'Boiling water', 'B'),
(20, 2, 'What happens to pressure if temperature increases and volume is constant?', 'Decreases', 'Stays same', 'Increases', 'Becomes zero', 'C'),
(21, 2, 'Which is NOT a state function?', 'Pressure', 'Work', 'Temperature', 'Volume', 'B'),
(22, 2, 'What is the first law of thermodynamics about?', 'Energy conservation', 'Entropy', 'Temperature', 'Density', 'A'),
(23, 2, 'Who formulated the gas law PV=nRT?', 'Newton', 'Einstein', 'Boyle', 'Clapeyron', 'D'),
(24, 2, 'What is absolute zero?', '0°C', '0°F', '0K', '-273K', 'C'),
(25, 2, 'Which is an example of thermal equilibrium?', 'Boiling water', 'Melting ice', 'Room temp. water', 'Hot coffee in cold room', 'C');

-- Chemistry (Exam 3)
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(26, 3, 'Which group is present in ketones?', '-COOH', '-CO-', '-OH', '-NH2', 'B'),
(27, 3, 'What is the general formula of alkanes?', 'CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnHn', 'B'),
(28, 3, 'Which compound is an alcohol?', 'CH3COOH', 'CH3OH', 'CH3NH2', 'CH3CHO', 'B'),
(29, 3, 'What is the color of copper(II) sulfate?', 'Green', 'Blue', 'Red', 'Yellow', 'B'),
(30, 3, 'Which is a saturated hydrocarbon?', 'Alkene', 'Alkyne', 'Alkane', 'Arene', 'C'),
(31, 3, 'Which element is most electronegative?', 'Oxygen', 'Fluorine', 'Chlorine', 'Nitrogen', 'B'),
(32, 3, 'Which is an example of an ester?', 'CH3COOC2H5', 'CH3OH', 'CH3COOH', 'C2H5NH2', 'A'),
(33, 3, 'What is the pH of pure water?', '1', '7', '14', '0', 'B'),
(34, 3, 'Which is NOT a noble gas?', 'Helium', 'Neon', 'Argon', 'Oxygen', 'D'),
(35, 3, 'Which is the formula for methane?', 'C2H6', 'C3H8', 'CH4', 'C2H4', 'C');

-- English (Exam 4)
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(36, 4, 'Which is a synonym of "happy"?', 'Sad', 'Joyful', 'Angry', 'Tired', 'B'),
(37, 4, 'Who wrote "Romeo and Juliet"?', 'Charles Dickens', 'Jane Austen', 'Shakespeare', 'Mark Twain', 'C'),
(38, 4, 'What is a simile?', 'A comparison using "like" or "as"', 'An exaggeration', 'A rhyme', 'A contradiction', 'A'),
(39, 4, 'Which is an example of alliteration?', 'Silly snakes slither silently', 'The sun is a ball of fire', 'The wind whispered', 'As brave as a lion', 'A'),
(40, 4, 'What is the main theme of "1984"?', 'Love', 'Freedom', 'Totalitarianism', 'Adventure', 'C'),
(41, 4, 'What is an antonym for "increase"?', 'Grow', 'Expand', 'Reduce', 'Rise', 'C'),
(42, 4, 'What part of speech is "quickly"?', 'Noun', 'Adjective', 'Adverb', 'Verb', 'C'),
(43, 4, 'What is the plural of "child"?', 'Childs', 'Childes', 'Children', 'Childen', 'C'),
(44, 4, 'Which is a metaphor?', 'Time is a thief', 'As fast as lightning', 'Buzzing bee', 'Tiny turtle', 'A'),
(45, 4, 'Who is the author of "Pride and Prejudice"?', 'George Orwell', 'Jane Austen', 'Emily Bronte', 'J.K. Rowling', 'B');

-- Computer Science (Exam 5)
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(46, 5, 'Which is a valid variable name in Python?', '1variable', '_variable', 'variable-name', '.variable', 'B'),
(47, 5, 'What does CPU stand for?', 'Central Processing Unit', 'Computer Personal Use', 'Central Power Unit', 'Control Panel Unit', 'A'),
(48, 5, 'Which is NOT a programming language?', 'Python', 'Java', 'HTML', 'Windows', 'D'),
(49, 5, 'What is the output of print(2**3)?', '6', '8', '9', '16', 'B'),
(50, 5, 'Which data structure uses FIFO?', 'Stack', 'Queue', 'Tree', 'Graph', 'B'),
(51, 5, 'Which of these is a loop structure?', 'if', 'for', 'def', 'try', 'B'),
(52, 5, 'What is the binary of decimal 5?', '101', '110', '100', '111', 'A'),
(53, 5, 'Which is used to define a function in Python?', 'func', 'def', 'define', 'function', 'B'),
(54, 5, 'What is the value of 5//2 in Python?', '2.5', '2', '3', '2.0', 'B'),
(55, 5, 'Which of the following is an IDE?', 'Chrome', 'IDLE', 'Excel', 'Word', 'B');