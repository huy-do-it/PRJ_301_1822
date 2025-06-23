
CREATE DATABASE Workshop_01
GO


USE Workshop_01
GO


CREATE TABLE tblUsers (
    Username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Founder', 'Team Member'))
);


CREATE TABLE tblStartupProjects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Ideation', 'Development', 'Launch', 'Scaling')),
    estimated_launch DATE NOT NULL
);


INSERT INTO tblUsers (Username, Name, Password, Role) VALUES
('HuyDT', 'Admin Dep Trai', 'deptrai', 'Founder'),
('AEBonPhuong', 'Anh Em', 'anhem', 'Team Member');



INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) VALUES
(1, 'Foodify', 'Online food delivery platform.', 'Ideation', '2025-08-01'),
(2, 'MediConnect', 'Healthcare appointment scheduling app.', 'Development', '2024-11-15'),
(3, 'EcoTravel', 'Sustainable travel booking service.', 'Development', '2024-12-10'),
(4, 'BookNest', 'Digital library and book sharing network.', 'Scaling', '2023-10-20'),
(5, 'HomeGenie', 'Smart home automation for apartments.', 'Ideation', '2021-09-30'),
(6, 'PetCare+', 'Pet health tracking and vet booking.', 'Scaling', '2023-08-12'),
(7, 'TutorMatch', 'Platform connecting tutors with students.', 'Launch', '2022-03-18'),
(8, 'FitTrack', 'AI-powered fitness and nutrition tracking.', 'Development', '2022-06-25'),
(9, 'Farm2Table', 'Direct farm-to-consumer food supply.', 'Scaling', '2025-04-05'),
(10, 'SkillBurst', 'Online micro-learning courses.', 'Launch', '2025-11-01');

