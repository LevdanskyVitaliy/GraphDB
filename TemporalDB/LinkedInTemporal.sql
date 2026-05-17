--- СОздание базы данных
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'LinkedInTemporalDB')
BEGIN
    ALTER DATABASE LinkedInTemporalDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LinkedInTemporalDB;
END
GO

CREATE DATABASE LinkedInTemporalDB
    COLLATE Cyrillic_General_CI_AS;
GO

USE LinkedInTemporalDB;
GO


-- РАЗДЕЛ 1: СОЗДАНИЕ ТЕМПОРАЛЬНЫХ ТАБЛИЦ (п. 1)

-- 1. (Professionals
CREATE TABLE dbo.Professionals (
    ProfessionalID    INT            NOT NULL CONSTRAINT PK_Professionals PRIMARY KEY IDENTITY(1,1),
    FirstName         NVARCHAR(100)  NOT NULL,
    LastName          NVARCHAR(100)  NOT NULL,
    JobTitle          NVARCHAR(100)  NOT NULL,
    ProfessionalLevel NVARCHAR(50)   NOT NULL, 
    ValidFrom         DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo           DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Professionals_History));
GO

-- 2. Companies
CREATE TABLE dbo.Companies (
    CompanyID      INT            NOT NULL CONSTRAINT PK_Companies PRIMARY KEY IDENTITY(1,1),
    CompanyName    NVARCHAR(200)  NOT NULL,
    Country        NVARCHAR(100)  NOT NULL,
    Specialization NVARCHAR(100)  NOT NULL, 
    ValidFrom      DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo        DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Companies_History));
GO

-- 3. Technologies
CREATE TABLE dbo.Technologies (
    TechID    INT            NOT NULL CONSTRAINT PK_Technologies PRIMARY KEY IDENTITY(1,1),
    TechName  NVARCHAR(100)  NOT NULL, 
    Category  NVARCHAR(100)  NOT NULL, 
    ValidFrom DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo   DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Technologies_History));
GO

-- 4. Projects
CREATE TABLE dbo.Projects (
    ProjectID   INT            NOT NULL CONSTRAINT PK_Projects PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(200)  NOT NULL,
    ProjectType NVARCHAR(50)   NOT NULL, 
    Status      NVARCHAR(50)   NOT NULL, 
    ValidFrom   DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo     DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Projects_History));
GO

-- 5. WorkedAt - Таблица фактов/связей
CREATE TABLE dbo.WorkedAt (
    WorkID         INT            NOT NULL CONSTRAINT PK_WorkedAt PRIMARY KEY IDENTITY(1,1),
    ProfessionalID INT            NOT NULL CONSTRAINT FK_WorkedAt_Professionals REFERENCES dbo.Professionals(ProfessionalID),
    CompanyID      INT            NOT NULL CONSTRAINT FK_WorkedAt_Companies REFERENCES dbo.Companies(CompanyID),
    Role           NVARCHAR(100)  NOT NULL,
    Salary         INT            NOT NULL,
    ValidFrom      DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo        DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.WorkedAt_History));
GO

-- 6. HasSkill - Таблица связей/фактов
CREATE TABLE dbo.HasSkill (
    SkillID        INT          NOT NULL CONSTRAINT PK_HasSkill PRIMARY KEY IDENTITY(1,1),
    ProfessionalID INT          NOT NULL CONSTRAINT FK_HasSkill_Professionals REFERENCES dbo.Professionals(ProfessionalID),
    TechID         INT          NOT NULL CONSTRAINT FK_HasSkill_Technologies REFERENCES dbo.Technologies(TechID),
    SkillLevel     INT          NOT NULL, 
    Certified      BIT          NOT NULL, 
    ValidFrom      DATETIME2(7) GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo        DATETIME2(7) GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.HasSkill_History));
GO

-- 7. UsesTechnology (stack) Таблица фактов/связей
CREATE TABLE dbo.UsesTechnology (
    UseID      INT           NOT NULL CONSTRAINT PK_UsesTechnology PRIMARY KEY IDENTITY(1,1),
    ProjectID  INT           NOT NULL CONSTRAINT FK_UsesTechnology_Projects REFERENCES dbo.Projects(ProjectID),
    TechID     INT           NOT NULL CONSTRAINT FK_UsesTechnology_Technologies REFERENCES dbo.Technologies(TechID),
    Importance NVARCHAR(50)  NOT NULL, 
    ValidFrom  DATETIME2(7)  GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo    DATETIME2(7)  GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.UsesTechnology_History));
GO

-- 8. ParticipatedIn  Таблица фактов/связей
CREATE TABLE dbo.ParticipatedIn (
    ParticipationID INT            NOT NULL CONSTRAINT PK_ParticipatedIn PRIMARY KEY IDENTITY(1,1),
    ProfessionalID  INT            NOT NULL CONSTRAINT FK_ParticipatedIn_Professionals REFERENCES dbo.Professionals(ProfessionalID),
    ProjectID       INT            NOT NULL CONSTRAINT FK_ParticipatedIn_Projects REFERENCES dbo.Projects(ProjectID),
    Contribution    NVARCHAR(200)  NOT NULL, 
    ValidFrom       DATETIME2(7)   GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo         DATETIME2(7)   GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ParticipatedIn_History));
GO


-- НАПОЛНЕНИЕ ДАННЫМИ 

-- Дата вставки базовых строк: 15.01.2022
PRINT 'Наполнение базовыми данными: Январь 2022';

-- Заполнение справочников 
INSERT INTO dbo.Professionals (FirstName, LastName, JobTitle, ProfessionalLevel) VALUES
(N'Иван', N'Иванов', N'Backend Developer', N'Middle'),
(N'Петр', N'Петров', N'Frontend Developer', N'Senior'),
(N'Анна', N'Сидорова', N'Data Scientist', N'Senior'),
(N'Дмитрий', N'Кузнецов', N'DevOps Engineer', N'Middle'),
(N'Елена', N'Попова', N'QA Engineer', N'Junior'),
(N'Алексей', N'Смирнов', N'Fullstack Developer', N'Senior'),
(N'Ольга', N'Васильева', N'UI/UX Designer', N'Middle'),
(N'Сергей', N'Федоров', N'Project Manager', N'Senior'),
(N'Мария', N'Соколова', N'Mobile Developer', N'Middle'),
(N'Николай', N'Новиков', N'System Analyst', N'Junior');

INSERT INTO dbo.Companies (CompanyName, Country, Specialization) VALUES
(N'SberTech', N'Россия', N'FinTech'),
(N'Yandex', N'Россия', N'Search & AI'),
(N'Ozon', N'Россия', N'E-commerce'),
(N'Kaspersky', N'Россия', N'Cybersecurity'),
(N'Tinkoff', N'Россия', N'FinTech'),
(N'VK', N'Россия', N'Social Networks'),
(N'Avito', N'Россия', N'E-commerce'),
(N'MTS', N'Россия', N'Telecom'),
(N'Alfa Bank', N'Россия', N'FinTech'),
(N'Magnit Tech', N'Россия', N'Retail');

INSERT INTO dbo.Technologies (TechName, Category) VALUES
(N'Python', N'Язык программирования'),
(N'JavaScript', N'Язык программирования'),
(N'React', N'Фреймворк'),
(N'Kubernetes', N'Инструмент'),
(N'Docker', N'Инструмент'),
(N'PostgreSQL', N'База данных'),
(N'SQL Server', N'База данных'),
(N'Django', N'Фреймворк'),
(N'TypeScript', N'Язык программирования'),
(N'Flutter', N'Фреймворк');

INSERT INTO dbo.Projects (ProjectName, ProjectType, Status) VALUES
(N'Billing System 2.0', N'Коммерческий', N'Активный'),
(N'AI Search Engine', N'Коммерческий', N'Активный'),
(N'Mobile Marketplace', N'Коммерческий', N'Активный'),
(N'Cloud Security SDK', N'Open-source', N'Активный'),
(N'HR Dashboard', N'Коммерческий', N'Завершенный'),
(N'Data Lake Analytics', N'Коммерческий', N'Активный'),
(N'Smart Home App', N'Open-source', N'Активный'),
(N'SuperApp Core', N'Коммерческий', N'Активный'),
(N'B2B Portal', N'Коммерческий', N'Завершенный'),
(N'Loyalty Engine', N'Коммерческий', N'Активный');

-- Заполнение таблиц фактов/связей 
-- Навыки (HasSkill) 
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES
(1, 1, 4, 1), (1, 6, 3, 0), (2, 2, 5, 1), (2, 3, 4, 0), (3, 1, 5, 1),
(4, 4, 4, 1), (4, 5, 5, 0), (5, 7, 2, 0), (6, 2, 4, 0), (6, 6, 4, 1);
-- Места работы (WorkedAt) 
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES
(1, 1, N'Python Developer', 150000), (2, 2, N'Senior Frontend', 280000),
(3, 2, N'Lead AI Researcher', 350000), (4, 4, N'DevOps Engineer', 200000),
(5, 3, N'Junior QA', 80000), (6, 6, N'Fullstack Lead', 300000),
(7, 7, N'UX Specialist', 140000), (8, 5, N'Senior PM', 250000),
(9, 8, N'iOS Developer', 180000), (10, 9, N'System Analyst', 110000);
-- Использование технологий на проектах (UsesTechnology) 
INSERT INTO dbo.UsesTechnology (ProjectID, TechID, Importance) VALUES
(1, 7, N'Основная'), (1, 4, N'Вспомогательная'), (2, 1, N'Основная'),
(2, 6, N'Вспомогательная'), (3, 2, N'Основная'), (3, 3, N'Основная'),
(4, 5, N'Основная'), (6, 1, N'Основная'), (6, 6, N'Основная'), (7, 10, N'Основная');
-- Участие в проектах (ParticipatedIn)
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES
(1, 1, N'Разработка платежного шлюза'), (2, 3, N'Создание веб-версии'),
(3, 2, N'Обучение рекомендательной модели'), (4, 4, N'Настройка CI/CD пайплайнов'),
(5, 3, N'Регрессионное тестирование приложения'), (6, 8, N'Архитектура ядра приложения'),
(7, 3, N'Проектирование пользовательских путей'), (8, 1, N'Управление релизами и рисками'),
(9, 7, N'Разработка мобильного интерфейса'), (10, 6, N'Сбор требований бизнеса');
GO



--  Ежемесячные изменения 

PRINT 'Изменения за: Февраль 2022';
INSERT INTO dbo.Professionals (FirstName, LastName, JobTitle, ProfessionalLevel) VALUES (N'Олег', N'Волков', N'Java Dev', N'Middle'), (N'Игорь', N'Зотов', N'C# Dev', N'Senior');
INSERT INTO dbo.Companies (CompanyName, Country, Specialization) VALUES (N'QIWI', N'Россия', N'FinTech'), (N'Sber', N'Россия', N'FinTech');
INSERT INTO dbo.Technologies (TechName, Category) VALUES (N'Java', N'Язык программирования');
UPDATE dbo.Professionals SET ProfessionalLevel = N'Senior' WHERE ProfessionalID = 1;
UPDATE dbo.WorkedAt SET Salary = 170000 WHERE ProfessionalID = 1;
UPDATE dbo.Companies SET Specialization = N'E-commerce & Retail' WHERE CompanyID = 3;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 1;
UPDATE dbo.HasSkill SET SkillLevel = 5 WHERE ProfessionalID = 1 AND TechID = 1;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 5;
DELETE FROM dbo.UsesTechnology WHERE UseID = 2;
DELETE FROM dbo.HasSkill WHERE SkillID = 10;
GO


PRINT  'Изменения за: Март 2022';
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES (2, 9, 5, 1), (3, 6, 4, 0), (6, 4, 3, 1), (1, 5, 4, 0), (7, 2, 4, 0);
UPDATE dbo.Professionals SET JobTitle = N'Team Lead' WHERE ProfessionalID = 6;
UPDATE dbo.WorkedAt SET Salary = 340000 WHERE ProfessionalID = 6;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 3;
UPDATE dbo.Companies SET CompanyName = N'T-Bank' WHERE CompanyID = 5;
UPDATE dbo.Technologies SET Category = N'Платформа' WHERE TechID = 4;
DELETE FROM dbo.WorkedAt WHERE WorkID = 5;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 2;
DELETE FROM dbo.UsesTechnology WHERE UseID = 4;
GO


PRINT 'Изменения за: Апрель 2022';
INSERT INTO dbo.Projects (ProjectName, ProjectType, Status) VALUES (N'Blockchain Wallet', N'Коммерческий', N'Активный'), (N'Green Energy App', N'Open-source', N'Активный');
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES (1, 11, N'Смарт-контракты'), (4, 11, N'Инфраструктура'), (6, 12, N'Фронтенд');
UPDATE dbo.Professionals SET ProfessionalLevel = N'Middle' WHERE ProfessionalID = 5;
UPDATE dbo.WorkedAt SET Role = N'Middle QA Engineer', Salary = 110000 WHERE ProfessionalID = 5;
UPDATE dbo.Projects SET ProjectName = N'Advanced AI Search Engine' WHERE ProjectID = 2;
UPDATE dbo.HasSkill SET Certified = 1 WHERE ProfessionalID = 4 AND TechID = 4;
UPDATE dbo.UsesTechnology SET Importance = N'Основная' WHERE UseID = 6;
DELETE FROM dbo.HasSkill WHERE SkillID = 2;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 7;
DELETE FROM dbo.WorkedAt WHERE WorkID = 7;
GO


PRINT 'Изменения за: Май 2022 ';
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES (5, 7, N'QA Automation', 150000), (7, 2, N'Senior Product Designer', 220000);
INSERT INTO dbo.UsesTechnology (ProjectID, TechID, Importance) VALUES (11, 2, N'Основная'), (11, 9, N'Основная'), (12, 1, N'Вспомогательная');
UPDATE dbo.Professionals SET JobTitle = N'Lead Data Scientist' WHERE ProfessionalID = 3;
UPDATE dbo.WorkedAt SET Salary = 400000 WHERE ProfessionalID = 3;
UPDATE dbo.Companies SET Country = N'Казахстан' WHERE CompanyID = 7;
UPDATE dbo.Technologies SET TechName = N'MS SQL Server' WHERE TechID = 7;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 4;
DELETE FROM dbo.HasSkill WHERE SkillID = 4;
DELETE FROM dbo.UsesTechnology WHERE UseID = 5;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 9;
GO


PRINT 'Изменения за: Июнь 2022';
INSERT INTO dbo.Professionals (FirstName, LastName, JobTitle, ProfessionalLevel) VALUES (N'Антон', N'Кротов', N'Golang Dev', N'Middle');
INSERT INTO dbo.Technologies (TechName, Category) VALUES (N'Go', N'Язык программирования'), (N'Vue.js', N'Фреймворк');
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES (11, 11, 4, 1), (2, 12, 3, 0);
UPDATE dbo.Professionals SET ProfessionalLevel = N'Senior' WHERE ProfessionalID = 4;
UPDATE dbo.WorkedAt SET Salary = 260000 WHERE ProfessionalID = 4;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 7;
UPDATE dbo.HasSkill SET SkillLevel = 5 WHERE ProfessionalID = 3 AND TechID = 1;
UPDATE dbo.Companies SET Specialization = N'Cybersecurity & Cloud' WHERE CompanyID = 4;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 1;
DELETE FROM dbo.UsesTechnology WHERE UseID = 1;
DELETE FROM dbo.HasSkill WHERE SkillID = 8;
GO


PRINT ' Изменения за: Июль 2022';
INSERT INTO dbo.Companies (CompanyName, Country, Specialization) VALUES (N'Lamoda', N'Россия', N'E-commerce');
INSERT INTO dbo.Projects (ProjectName, ProjectType, Status) VALUES (N'Recommendation Engine v3', N'Коммерческий', N'Активный');
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES (11, 3, N'Golang Developer', 210000);
INSERT INTO dbo.UsesTechnology (ProjectID, TechID, Importance) VALUES (13, 1, N'Основная'), (13, 6, N'Основная');
UPDATE dbo.Professionals SET ProfessionalLevel = N'Senior' WHERE ProfessionalID = 9;
UPDATE dbo.WorkedAt SET Role = N'Senior iOS Developer', Salary = 250000 WHERE ProfessionalID = 9;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 2;
UPDATE dbo.Companies SET Specialization = N'Big Data & AI' WHERE CompanyID = 2;
UPDATE dbo.HasSkill SET SkillLevel = 5 WHERE ProfessionalID = 2 AND TechID = 2;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 3;
DELETE FROM dbo.UsesTechnology WHERE UseID = 3;
DELETE FROM dbo.HasSkill WHERE SkillID = 6;
GO


PRINT ' Изменения за: Август 2022';
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES (9, 10, 4, 1), (11, 5, 3, 0), (5, 6, 4, 0);
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES (11, 13, N'Разработка API микросервисов'), (3, 13, N'Алгоритмы ранжирования');
UPDATE dbo.Professionals SET ProfessionalLevel = N'Senior' WHERE ProfessionalID = 1;
UPDATE dbo.WorkedAt SET Salary = 230000 WHERE ProfessionalID = 1;
UPDATE dbo.Companies SET Country = N'ОАЭ' WHERE CompanyID = 2;
UPDATE dbo.Projects SET ProjectName = N'SuperApp Core Global' WHERE ProjectID = 8;
UPDATE dbo.Technologies SET Category = N'Контейнеризация' WHERE TechID = 5;
DELETE FROM dbo.WorkedAt WHERE WorkID = 1;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 4;
DELETE FROM dbo.UsesTechnology WHERE UseID = 7;
GO


PRINT 'Изменения за: Сентябрь 2022';
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES (1, 2, N'Senior Python Dev', 290000);
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES (1, 8, N'Оптимизация базы данных ядра');
INSERT INTO dbo.UsesTechnology (ProjectID, TechID, Importance) VALUES (8, 6, N'Основная'), (8, 4, N'Вспомогательная'), (13, 4, N'Вспомогательная');
UPDATE dbo.Professionals SET JobTitle = N'Lead PM' WHERE ProfessionalID = 8;
UPDATE dbo.WorkedAt SET Salary = 320000 WHERE ProfessionalID = 8;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 6;
UPDATE dbo.Companies SET Specialization = N'FinTech & Banking' WHERE CompanyID = 1;
UPDATE dbo.HasSkill SET SkillLevel = 5 WHERE ProfessionalID = 4 AND TechID = 5;
DELETE FROM dbo.HasSkill WHERE SkillID = 5;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 6;
DELETE FROM dbo.UsesTechnology WHERE UseID = 8;
GO


PRINT 'Изменения за: Октябрь 2022';
INSERT INTO dbo.Professionals (FirstName, LastName, JobTitle, ProfessionalLevel) VALUES (N'Егор', N'Летов', N'Security Engineer', N'Senior');
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES (12, 4, N'Security Analyst', 270000);
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES (12, 5, 4, 1), (12, 4, 4, 0), (4, 1, 3, 0);
UPDATE dbo.Professionals SET JobTitle = N'Engineering Manager' WHERE ProfessionalID = 4;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 10;
UPDATE dbo.Companies SET Specialization = N'E-commerce Platform' WHERE CompanyID = 7;
UPDATE dbo.Technologies SET TechName = N'PostgreSQL v14' WHERE TechID = 6;
UPDATE dbo.WorkedAt SET Salary = 190000 WHERE ProfessionalID = 9;
DELETE FROM dbo.WorkedAt WHERE WorkID = 9;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 8;
DELETE FROM dbo.UsesTechnology WHERE UseID = 9;
GO


PRINT '=== Изменения за: Ноябрь 2022 ===';
INSERT INTO dbo.Projects (ProjectName, ProjectType, Status) VALUES (N'Cyber Threat Radar', N'Коммерческий', N'Активный');
INSERT INTO dbo.UsesTechnology (ProjectID, TechID, Importance) VALUES (14, 1, N'Основная'), (14, 6, N'Основная'), (14, 4, N'Вспомогательная');
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES (12, 14, N'Анализ уязвимостей кода');
UPDATE dbo.Professionals SET ProfessionalLevel = N'Middle' WHERE ProfessionalID = 10;
UPDATE dbo.WorkedAt SET Role = N'Middle System Analyst', Salary = 150000 WHERE ProfessionalID = 10;
UPDATE dbo.Companies SET CompanyName = N'Avito Tech' WHERE CompanyID = 7;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 11;
UPDATE dbo.HasSkill SET SkillLevel = 5 WHERE ProfessionalID = 11 AND TechID = 11;
DELETE FROM dbo.WorkedAt WHERE WorkID = 3;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 10;
DELETE FROM dbo.UsesTechnology WHERE UseID = 10;
GO


PRINT ' Изменения за: Декабрь 2022';
INSERT INTO dbo.WorkedAt (ProfessionalID, CompanyID, Role, Salary) VALUES (3, 4, N'Principal AI Engineer', 480000);
INSERT INTO dbo.ParticipatedIn (ProfessionalID, ProjectID, Contribution) VALUES (3, 14, N'Интеграция AI-детектора угроз');
INSERT INTO dbo.HasSkill (ProfessionalID, TechID, SkillLevel, Certified) VALUES (3, 5, 4, 0), (1, 6, 5, 1), (12, 1, 3, 0);
UPDATE dbo.Professionals SET JobTitle = N'Director of Technology' WHERE ProfessionalID = 6;
UPDATE dbo.WorkedAt SET Salary = 450000 WHERE ProfessionalID = 6;
UPDATE dbo.Companies SET Specialization = N'FinTech SuperApp' WHERE CompanyID = 5;
UPDATE dbo.Projects SET Status = N'Завершенный' WHERE ProjectID = 12;
UPDATE dbo.HasSkill 
SET Certified = 1 
WHERE ProfessionalID = 5 - 0 
  AND TechID = 6;
DELETE FROM dbo.HasSkill WHERE SkillID = 7;
DELETE FROM dbo.ParticipatedIn WHERE ParticipationID = 11;
DELETE FROM dbo.UsesTechnology WHERE UseID = 11;
GO


