DROP TABLE tblStartupProjects;
-- T?o database
CREATE DATABASE Workshop_1
GO

-- S? d?ng database v?a t?o
USE Workshop_1
GO

-- T?o b?ng tblUsers
CREATE TABLE tblUsers (
    Username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Founder', 'Team Member'))
);

-- T?o b?ng tblStartupProjects
CREATE TABLE tblStartupProjects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    estimated_launch DATE NOT NULL
);

-- Chèn d? li?u m?u vào tblUsers
INSERT INTO tblUsers (Username, Name, Password, Role) VALUES
('ngoc_quang', 'Ngoc Quang', 'ngocquang123', 'Founder'),
('tuong_vi', 'Tuong Vi', 'tuongvi123', 'Team Member');



-- Chèn d? li?u m?u vào tblStartupProjects
INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES
(1, 'Tech Revolution', 'A startup focusing on AI solutions.', 'Ideation', '01-06-2025'),
(2, 'Green Energy', 'Renewable energy project.', 'Development', '02-07-2024'),
(3, 'FinTech Pro', 'A next-gen fintech platform.', 'Development', '03-06-2024'),
(4, 'Health Guardian', 'AI-powered health monitoring system.', 'Scaling', '02-08-2023'),
(5, 'EduFuture', 'E-learning platform for modern education.', 'Ideation', '01-07-2021'),
(6, 'SmartAgri', 'IoT-based smart agriculture solution.', 'Scaling', '02-08-2023'),
(7, 'Urban Mobility', 'Electric scooter sharing network.', 'Launch', '01-09-2022'),
(8, 'CyberShield', 'Cybersecurity AI-powered tool.', 'Development', '01-06-2022'),
(9, 'SpaceXplorer', 'Aerospace research and exploration.', 'Scaling', '03-06-2025'),
(10, 'QuantumCompute', 'Quantum computing research project.', 'Launch', '01-07-2025');

