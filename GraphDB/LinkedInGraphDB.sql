USE master;
GO
DROP DATABASE IF EXISTS LinkedInGraphDB;
GO


CREATE DATABASE LinkedInGraphDB;
GO
USE LinkedInGraphDB;
GO


-- 1. Create Nodes
CREATE TABLE Professional (
    ID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    JobTitle NVARCHAR(50),
    ExperienceLevel NVARCHAR(20)
) AS NODE;

CREATE TABLE Company (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Country NVARCHAR(50),
    Industry NVARCHAR(50)
) AS NODE;

CREATE TABLE Skill (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Category NVARCHAR(50)
) AS NODE;

CREATE TABLE Project (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    ProjectType NVARCHAR(50),
    Status NVARCHAR(50)
) AS NODE;


-- 2. Create Edges
CREATE TABLE WorkedAt (StartDate DATE, EndDate DATE, Role NVARCHAR(50)) AS EDGE;
CREATE TABLE HasSkill (ProficiencyLevel INT, Certified BIT) AS EDGE;
CREATE TABLE UsesSkill (IsCore BIT) AS EDGE;
CREATE TABLE ParticipatedIn (Role NVARCHAR(50)) AS EDGE;
CREATE TABLE ConnectedTo (ConnectionType NVARCHAR(50)) AS EDGE; 


-- 3. Filled with the data
--Node: Professional
INSERT INTO Professional (ID, FirstName, LastName, JobTitle, ExperienceLevel) VALUES 
(1, N'Иван', N'Иванов', N'Backend Developer', N'Senior'),
(2, N'Анна', N'Смирнова', N'Data Scientist', N'Middle'),
(3, N'Алексей', N'Петров', N'DevOps Engineer', N'Senior'),
(4, N'Елена', N'Соколова', N'Frontend Developer', N'Junior'),
(5, N'Дмитрий', N'Волков', N'Product Manager', N'Senior'),
(6, N'Ольга', N'Морозова', N'QA Engineer', N'Middle'),
(7, N'Сергей', N'Лебедев', N'Fullstack Developer', N'Senior'),
(8, N'Мария', N'Новикова', N'UX/UI Designer', N'Middle'),
(9, N'Павел', N'Козлов', N'Backend Developer', N'Junior'),
(10, N'Екатерина', N'Ильина', N'Data Analyst', N'Middle');

-- Fill node: Company
INSERT INTO Company (ID, Name, Country, Industry) VALUES 
(1, N'Toyota', N'Япония', N'Automotive'),
(2, N'Sber', N'Россия', N'FinTech'),
(3, N'Oracle', N'США', N'Database'),
(4, N'SAP', N'Германия', N'ERP'),
(5, N'Parmalat', N'Италия', N'Food Production'),
(6, N'ASML', N'Нидерланды', N'Semiconductors'),
(7, N'Kaspersky', N'Россия', N'Cybersecurity'),
(8, N'Microsoft', N'США', N'BigTech'),
(9, N'Yandex', N'Россия', N'Search & AI'),
(10, N'BSU', N'Беларусь', N'Education');

-- Fill node: Skill
INSERT INTO Skill (ID, Name, Category) VALUES 
(1, N'Python', N'Language'),
(2, N'React', N'Framework'),
(3, N'Kubernetes', N'Tool'),
(4, N'SQL', N'Language'),
(5, N'Figma', N'Tool'),
(6, N'Go', N'Language'),
(7, N'Docker', N'Tool'),
(8, N'Machine Learning', N'Concept'),
(9, N'Java', N'Language'),
(10, N'AWS', N'Cloud');

-- Fill node: Project
INSERT INTO Project (ID, Name, ProjectType, Status) VALUES 
(1, N'Payment Gateway', N'Коммерческий', N'Активный'),
(2, N'Recommendation Engine', N'Коммерческий', N'Завершенный'),
(3, N'OpenSource UI Library', N'Open-source', N'Активный'),
(4, N'Cloud Migration', N'Инфраструктурный', N'Завершенный'),
(5, N'Mobile App v2.0', N'Коммерческий', N'Активный'),
(6, N'Data Warehouse Setup', N'Инфраструктурный', N'Завершенный'),
(7, N'Security Audit', N'Внутренний', N'Завершенный'),
(8, N'CRM Integration', N'Коммерческий', N'Активный'),
(9, N'Game Server Engine', N'Коммерческий', N'Активный'),
(10, N'EdTech Portal', N'Коммерческий', N'Завершенный');

-- Заполнение рёбер: WorkedAt
INSERT INTO WorkedAt ($from_id, $to_id, StartDate, EndDate, Role)
SELECT p.$node_id, c.$node_id, '2020-01-01', '2023-01-01', N'Developer' FROM Professional p, Company c WHERE p.ID = 1 AND c.ID = 9 UNION ALL
SELECT p.$node_id, c.$node_id, '2021-05-01', NULL, N'Data Scientist' FROM Professional p, Company c WHERE p.ID = 2 AND c.ID = 4 UNION ALL
SELECT p.$node_id, c.$node_id, '2019-03-01', '2022-08-01', N'DevOps Engineer' FROM Professional p, Company c WHERE p.ID = 3 AND c.ID = 6 UNION ALL
SELECT p.$node_id, c.$node_id, '2022-01-10', NULL, N'Frontend Developer' FROM Professional p, Company c WHERE p.ID = 4 AND c.ID = 8 UNION ALL
SELECT p.$node_id, c.$node_id, '2018-11-15', NULL, N'Product Manager' FROM Professional p, Company c WHERE p.ID = 5 AND c.ID = 2 UNION ALL
SELECT p.$node_id, c.$node_id, '2020-06-01', '2023-12-31', N'QA Engineer' FROM Professional p, Company c WHERE p.ID = 6 AND c.ID = 7 UNION ALL
SELECT p.$node_id, c.$node_id, '2017-02-20', NULL, N'Fullstack Developer' FROM Professional p, Company c WHERE p.ID = 7 AND c.ID = 1 UNION ALL
SELECT p.$node_id, c.$node_id, '2021-09-01', NULL, N'UI Designer' FROM Professional p, Company c WHERE p.ID = 8 AND c.ID = 5 UNION ALL
SELECT p.$node_id, c.$node_id, '2023-03-01', NULL, N'Junior Developer' FROM Professional p, Company c WHERE p.ID = 9 AND c.ID = 3 UNION ALL
SELECT p.$node_id, c.$node_id, '2019-10-01', '2022-05-14', N'Data Analyst' FROM Professional p, Company c WHERE p.ID = 10 AND c.ID = 10;

-- Заполнение рёбер: HasSkill
INSERT INTO HasSkill ($from_id, $to_id, ProficiencyLevel, Certified)
SELECT p.$node_id, s.$node_id, 5, 1 FROM Professional p, Skill s WHERE p.ID = 1 AND s.ID = 1 UNION ALL
SELECT p.$node_id, s.$node_id, 4, 0 FROM Professional p, Skill s WHERE p.ID = 2 AND s.ID = 8 UNION ALL
SELECT p.$node_id, s.$node_id, 5, 1 FROM Professional p, Skill s WHERE p.ID = 3 AND s.ID = 3 UNION ALL
SELECT p.$node_id, s.$node_id, 3, 0 FROM Professional p, Skill s WHERE p.ID = 4 AND s.ID = 2 UNION ALL
SELECT p.$node_id, s.$node_id, 4, 1 FROM Professional p, Skill s WHERE p.ID = 5 AND s.ID = 4 UNION ALL
SELECT p.$node_id, s.$node_id, 4, 1 FROM Professional p, Skill s WHERE p.ID = 6 AND s.ID = 7 UNION ALL
SELECT p.$node_id, s.$node_id, 5, 0 FROM Professional p, Skill s WHERE p.ID = 7 AND s.ID = 6 UNION ALL
SELECT p.$node_id, s.$node_id, 4, 0 FROM Professional p, Skill s WHERE p.ID = 8 AND s.ID = 5 UNION ALL
SELECT p.$node_id, s.$node_id, 3, 1 FROM Professional p, Skill s WHERE p.ID = 9 AND s.ID = 9 UNION ALL
SELECT p.$node_id, s.$node_id, 4, 0 FROM Professional p, Skill s WHERE p.ID = 10 AND s.ID = 4;

-- Заполнение рёбер: UsesSkill
INSERT INTO UsesSkill ($from_id, $to_id, IsCore)
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 1 AND s.ID = 4 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 2 AND s.ID = 8 UNION ALL
SELECT pr.$node_id, s.$node_id, 0 FROM Project pr, Skill s WHERE pr.ID = 3 AND s.ID = 2 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 4 AND s.ID = 3 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 5 AND s.ID = 1 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 6 AND s.ID = 4 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 7 AND s.ID = 7 UNION ALL
SELECT pr.$node_id, s.$node_id, 0 FROM Project pr, Skill s WHERE pr.ID = 8 AND s.ID = 9 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 9 AND s.ID = 6 UNION ALL
SELECT pr.$node_id, s.$node_id, 1 FROM Project pr, Skill s WHERE pr.ID = 10 AND s.ID = 2;

-- Заполнение рёбер: ParticipatedIn
INSERT INTO ParticipatedIn ($from_id, $to_id, Role)
SELECT p.$node_id, pr.$node_id, N'Lead Backend' FROM Professional p, Project pr WHERE p.ID = 1 AND pr.ID = 1 UNION ALL
SELECT p.$node_id, pr.$node_id, N'ML Engineer' FROM Professional p, Project pr WHERE p.ID = 2 AND pr.ID = 2 UNION ALL
SELECT p.$node_id, pr.$node_id, N'DevOps Architect' FROM Professional p, Project pr WHERE p.ID = 3 AND pr.ID = 4 UNION ALL
SELECT p.$node_id, pr.$node_id, N'Frontend Developer' FROM Professional p, Project pr WHERE p.ID = 4 AND pr.ID = 3 UNION ALL
SELECT p.$node_id, pr.$node_id, N'Product Owner' FROM Professional p, Project pr WHERE p.ID = 5 AND pr.ID = 5 UNION ALL
SELECT p.$node_id, pr.$node_id, N'QA Lead' FROM Professional p, Project pr WHERE p.ID = 6 AND pr.ID = 7 UNION ALL
SELECT p.$node_id, pr.$node_id, N'Fullstack Developer' FROM Professional p, Project pr WHERE p.ID = 7 AND pr.ID = 9 UNION ALL
SELECT p.$node_id, pr.$node_id, N'UI Designer' FROM Professional p, Project pr WHERE p.ID = 8 AND pr.ID = 5 UNION ALL
SELECT p.$node_id, pr.$node_id, N'Junior Backend' FROM Professional p, Project pr WHERE p.ID = 9 AND pr.ID = 1 UNION ALL
SELECT p.$node_id, pr.$node_id, N'Data Analyst' FROM Professional p, Project pr WHERE p.ID = 10 AND pr.ID = 6;

-- Заполнение рёбер: ConnectedTo 
INSERT INTO ConnectedTo ($from_id, $to_id, ConnectionType)
SELECT p1.$node_id, p2.$node_id, N'Colleague' FROM Professional p1, Professional p2 WHERE p1.ID = 1 AND p2.ID = 2 UNION ALL
SELECT p1.$node_id, p2.$node_id, N'Mentor' FROM Professional p1, Professional p2 WHERE p1.ID = 1 AND p2.ID = 9 UNION ALL
SELECT p1.$node_id, p2.$node_id, N'Colleague' FROM Professional p1, Professional p2 WHERE p1.ID = 2 AND p2.ID = 3 UNION ALL
SELECT p1.$node_id, p2.$node_id, N'Partner' FROM Professional p1, Professional p2 WHERE p1.ID = 3 AND p2.ID = 5 UNION ALL
SELECT p1.$node_id, p2.$node_id, N'Colleague' FROM Professional p1, Professional p2 WHERE p1.ID = 5 AND p2.ID = 7 UNION ALL
SELECT p1.$node_id, p2.$node_id, N'Colleague' FROM Professional p1, Professional p2 WHERE p1.ID = 7 AND p2.ID = 10;


-- 4.  MATCH Queries

-- 4.1: Поиск специалистов по названию навыка
SELECT p.FirstName, p.LastName, p.JobTitle, s.Name AS SkillName
FROM Professional p, HasSkill hs, Skill s
WHERE MATCH(p-(hs)->s) AND s.Name = N'Python';

-- 4.2: Проекты, в которых участвовали сотрудники конкретных компаний
SELECT DISTINCT pr.Name AS ProjectName, c.Name AS CompanyName
FROM Professional p, WorkedAt w, Company c, ParticipatedIn pi, Project pr
WHERE MATCH(c<-(w)-p-(pi)->pr) AND c.Name = N'Yandex';

-- 4.3: Поиск коллег конкретного человека
SELECT p2.FirstName, p2.LastName, ct.ConnectionType
FROM Professional p1, ConnectedTo ct, Professional p2
WHERE MATCH(p1-(ct)->p2) AND p1.FirstName = N'Иван' AND p1.LastName = N'Иванов';

-- 4.4: Поиск специалистов уровня 'Senior', знающих определенную технологию
SELECT p.FirstName, p.LastName, p.JobTitle, s.Name AS SkillName
FROM Professional p, HasSkill hs, Skill s
WHERE MATCH(p-(hs)->s) AND p.ExperienceLevel = N'Senior' AND s.Name = N'Kubernetes';

-- 4.5: История работы специалиста с указанием должностей
SELECT c.Name AS CompanyName, w.Role, w.StartDate, w.EndDate
FROM Professional p, WorkedAt w, Company c
WHERE MATCH(p-(w)->c) AND p.FirstName = N'Иван';


-- 5. Executing queries SHORTEST_PATH

-- 5.1: Кратчайший путь от Ивана до Екатерины
SELECT 
    StartPerson,
    TargetPerson,
    ConnectionPath,
    DegreesOfSeparation
FROM (
    SELECT 
        p1.FirstName AS StartPerson,
        LAST_VALUE(p2.FirstName) WITHIN GROUP (GRAPH PATH) AS TargetPerson,
        STRING_AGG(p2.FirstName, ' -> ') WITHIN GROUP (GRAPH PATH) AS ConnectionPath,
        COUNT(p2.FirstName) WITHIN GROUP (GRAPH PATH) AS DegreesOfSeparation
    FROM 
        Professional p1,
        ConnectedTo FOR PATH ct,
        Professional FOR PATH p2
    WHERE MATCH(SHORTEST_PATH(p1(-(ct)->p2)+))
    AND p1.FirstName = N'Иван'
) AS PathResults
WHERE TargetPerson = N'Екатерина';


-- 5.2: Поиск контактов Ивана в пределах 1-2 рукопожатий
SELECT 
    SourcePerson,
    ConnectedPerson,
    Path,
    Hops
FROM (
    SELECT 
        p1.FirstName AS SourcePerson,
        LAST_VALUE(p2.FirstName) WITHIN GROUP (GRAPH PATH) AS ConnectedPerson,
        STRING_AGG(p2.FirstName, ' -> ') WITHIN GROUP (GRAPH PATH) AS Path,
        COUNT(p2.FirstName) WITHIN GROUP (GRAPH PATH) AS Hops
    FROM 
        Professional p1,
        ConnectedTo FOR PATH ct,
        Professional FOR PATH p2
    WHERE MATCH(SHORTEST_PATH(p1(-(ct)->p2){1,2}))
    AND p1.FirstName = N'Иван'
) AS FriendsQuery;