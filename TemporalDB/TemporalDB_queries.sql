USE LinkedInTemporalDB;
GO


PRINT 'Состояние на 31.03.2022 23:59:59.9999999';

SELECT 'Professionals' AS Таблица, ProfessionalID AS ID, LastName + N' ' + FirstName AS Значение, JobTitle, ValidFrom, ValidTo FROM dbo.Professionals FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'Companies' AS Таблица, CompanyID AS ID, CompanyName AS Значение, Specialization, ValidFrom, ValidTo FROM dbo.Companies FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'Technologies' AS Таблица, TechID AS ID, TechName AS Значение, Category, ValidFrom, ValidTo FROM dbo.Technologies FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'Projects' AS Таблица, ProjectID AS ID, ProjectName AS Значение, Status, ValidFrom, ValidTo FROM dbo.Projects FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'WorkedAt' AS Таблица, WorkID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' в Комп ' + CAST(CompanyID AS NVARCHAR) AS Значение, Salary, ValidFrom, ValidTo FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'HasSkill' AS Таблица, SkillID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, SkillLevel, ValidFrom, ValidTo FROM dbo.HasSkill FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'UsesTechnology' AS Таблица, UseID AS ID, N'Проект ' + CAST(ProjectID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, Importance, ValidFrom, ValidTo FROM dbo.UsesTechnology FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';
SELECT 'ParticipatedIn' AS Таблица, ParticipationID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Проект ' + CAST(ProjectID AS NVARCHAR) AS Значение, Contribution, ValidFrom, ValidTo FROM dbo.ParticipatedIn FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59.9999999';


PRINT 'Состояние на 30.06.2022 23:59:59.9999999 ';

SELECT 'Professionals' AS Таблица, ProfessionalID AS ID, LastName + N' ' + FirstName AS Значение, JobTitle, ValidFrom, ValidTo FROM dbo.Professionals FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'Companies' AS Таблица, CompanyID AS ID, CompanyName AS Значение, Specialization, ValidFrom, ValidTo FROM dbo.Companies FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'Technologies' AS Таблица, TechID AS ID, TechName AS Значение, Category, ValidFrom, ValidTo FROM dbo.Technologies FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'Projects' AS Таблица, ProjectID AS ID, ProjectName AS Значение, Status, ValidFrom, ValidTo FROM dbo.Projects FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'WorkedAt' AS Таблица, WorkID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' в Комп ' + CAST(CompanyID AS NVARCHAR) AS Значение, Salary, ValidFrom, ValidTo FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'HasSkill' AS Таблица, SkillID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, SkillLevel, ValidFrom, ValidTo FROM dbo.HasSkill FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'UsesTechnology' AS Таблица, UseID AS ID, N'Проект ' + CAST(ProjectID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, Importance, ValidFrom, ValidTo FROM dbo.UsesTechnology FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';
SELECT 'ParticipatedIn' AS Таблица, ParticipationID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Проект ' + CAST(ProjectID AS NVARCHAR) AS Значение, Contribution, ValidFrom, ValidTo FROM dbo.ParticipatedIn FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999';

PRINT ' Состояние на 30.09.2022 23:59:59.9999999';

SELECT 'Professionals' AS Таблица, ProfessionalID AS ID, LastName + N' ' + FirstName AS Значение, JobTitle, ValidFrom, ValidTo FROM dbo.Professionals FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'Companies' AS Таблица, CompanyID AS ID, CompanyName AS Значение, Specialization, ValidFrom, ValidTo FROM dbo.Companies FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'Technologies' AS Таблица, TechID AS ID, TechName AS Значение, Category, ValidFrom, ValidTo FROM dbo.Technologies FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'Projects' AS Таблица, ProjectID AS ID, ProjectName AS Значение, Status, ValidFrom, ValidTo FROM dbo.Projects FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'WorkedAt' AS Таблица, WorkID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' в Комп ' + CAST(CompanyID AS NVARCHAR) AS Значение, Salary, ValidFrom, ValidTo FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'HasSkill' AS Таблица, SkillID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, SkillLevel, ValidFrom, ValidTo FROM dbo.HasSkill FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'UsesTechnology' AS Таблица, UseID AS ID, N'Проект ' + CAST(ProjectID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, Importance, ValidFrom, ValidTo FROM dbo.UsesTechnology FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';
SELECT 'ParticipatedIn' AS Таблица, ParticipationID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Проект ' + CAST(ProjectID AS NVARCHAR) AS Значение, Contribution, ValidFrom, ValidTo FROM dbo.ParticipatedIn FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59.9999999';


PRINT 'Состояние на 31.12.2022 23:59:59.9999999';

SELECT 'Professionals' AS Таблица, ProfessionalID AS ID, LastName + N' ' + FirstName AS Значение, JobTitle, ValidFrom, ValidTo FROM dbo.Professionals FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'Companies' AS Таблица, CompanyID AS ID, CompanyName AS Значение, Specialization, ValidFrom, ValidTo FROM dbo.Companies FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'Technologies' AS Таблица, TechID AS ID, TechName AS Значение, Category, ValidFrom, ValidTo FROM dbo.Technologies FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'Projects' AS Таблица, ProjectID AS ID, ProjectName AS Значение, Status, ValidFrom, ValidTo FROM dbo.Projects FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'WorkedAt' AS Таблица, WorkID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' в Комп ' + CAST(CompanyID AS NVARCHAR) AS Значение, Salary, ValidFrom, ValidTo FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'HasSkill' AS Таблица, SkillID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, SkillLevel, ValidFrom, ValidTo FROM dbo.HasSkill FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'UsesTechnology' AS Таблица, UseID AS ID, N'Проект ' + CAST(ProjectID AS NVARCHAR) + N' Стек ' + CAST(TechID AS NVARCHAR) AS Значение, Importance, ValidFrom, ValidTo FROM dbo.UsesTechnology FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';
SELECT 'ParticipatedIn' AS Таблица, ParticipationID AS ID, N'Сотрудник ' + CAST(ProfessionalID AS NVARCHAR) + N' Проект ' + CAST(ProjectID AS NVARCHAR) AS Значение, Contribution, ValidFrom, ValidTo FROM dbo.ParticipatedIn FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59.9999999';



--  Состояние всех таблиц за лето 2022 года
PRINT ' Состояние таблиц за лето 2022 (01.06–31.08)';

SELECT 'Professionals' AS Таб, ProfessionalID, LastName, FirstName, JobTitle, ValidFrom, ValidTo FROM dbo.Professionals FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'Companies' AS Таб, CompanyID, CompanyName, Country, Specialization, ValidFrom, ValidTo FROM dbo.Companies FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'Technologies' AS Таб, TechID, TechName, Category, ValidFrom, ValidTo FROM dbo.Technologies FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'Projects' AS Таб, ProjectID, ProjectName, ProjectType, Status, ValidFrom, ValidTo FROM dbo.Projects FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'WorkedAt' AS Таб, WorkID, ProfessionalID, CompanyID, Role, Salary, ValidFrom, ValidTo FROM dbo.WorkedAt FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'HasSkill' AS Таб, SkillID, ProfessionalID, TechID, SkillLevel, ValidFrom, ValidTo FROM dbo.HasSkill FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'UsesTechnology' AS Таб, UseID, ProjectID, TechID, Importance, ValidFrom, ValidTo FROM dbo.UsesTechnology FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';
SELECT 'ParticipatedIn' AS Таб, ParticipationID, ProfessionalID, ProjectID, Contribution, ValidFrom, ValidTo FROM dbo.ParticipatedIn FOR SYSTEM_TIME BETWEEN '2022-06-01T00:00:00' AND '2022-08-31T23:59:59';



--  Строки, вставленные и удаленные в Q3 2022
PRINT 'Вставленные строки в Q3 2022 ';

SELECT 'Professionals - New' AS Оп, ProfessionalID, LastName, FirstName, ValidFrom FROM dbo.Professionals FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.Professionals FOR SYSTEM_TIME ALL p2 WHERE p2.ProfessionalID = Professionals.ProfessionalID AND p2.ValidFrom < Professionals.ValidFrom);
SELECT 'Companies - New' AS Оп, CompanyID, CompanyName, ValidFrom FROM dbo.Companies FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.Companies FOR SYSTEM_TIME ALL c2 WHERE c2.CompanyID = Companies.CompanyID AND c2.ValidFrom < Companies.ValidFrom);
SELECT 'Projects - New' AS Оп, ProjectID, ProjectName, ValidFrom FROM dbo.Projects FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.Projects FOR SYSTEM_TIME ALL pr2 WHERE pr2.ProjectID = Projects.ProjectID AND pr2.ValidFrom < Projects.ValidFrom);
SELECT 'WorkedAt - New' AS Оп, WorkID, ProfessionalID, CompanyID, ValidFrom FROM dbo.WorkedAt FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.WorkedAt FOR SYSTEM_TIME ALL w2 WHERE w2.WorkID = WorkedAt.WorkID AND w2.ValidFrom < WorkedAt.ValidFrom);
SELECT 'ParticipatedIn - New' AS Оп, ParticipationID, ProjectID, ValidFrom FROM dbo.ParticipatedIn FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.ParticipatedIn FOR SYSTEM_TIME ALL pt2 WHERE pt2.ParticipationID = ParticipatedIn.ParticipationID AND pt2.ValidFrom < ParticipatedIn.ValidFrom);
SELECT 'UsesTechnology - New' AS Оп, UseID, ProjectID, TechID, ValidFrom FROM dbo.UsesTechnology FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.UsesTechnology FOR SYSTEM_TIME ALL u2 WHERE u2.UseID = UsesTechnology.UseID AND u2.ValidFrom < UsesTechnology.ValidFrom);
SELECT 'HasSkill - New' AS Оп, SkillID, ProfessionalID, TechID, ValidFrom FROM dbo.HasSkill FOR SYSTEM_TIME ALL WHERE ValidFrom >= '2022-07-01' AND ValidFrom < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.HasSkill FOR SYSTEM_TIME ALL hs2 WHERE hs2.SkillID = HasSkill.SkillID AND hs2.ValidFrom < HasSkill.ValidFrom);

PRINT 'Удалённые строки в Q3 2022';

SELECT 'Companies - Del' AS Оп, h.CompanyID, h.CompanyName, h.ValidFrom, h.ValidTo FROM dbo.Companies_History h WHERE h.ValidTo >= '2022-07-01' AND h.ValidTo < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.Companies FOR SYSTEM_TIME ALL c2 WHERE c2.CompanyID = h.CompanyID AND c2.ValidFrom = h.ValidTo);
SELECT 'WorkedAt - Del' AS Оп, h.WorkID, h.ProfessionalID, h.CompanyID, h.ValidFrom, h.ValidTo FROM dbo.WorkedAt_History h WHERE h.ValidTo >= '2022-07-01' AND h.ValidTo < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.WorkedAt FOR SYSTEM_TIME ALL w2 WHERE w2.WorkID = h.WorkID AND w2.ValidFrom = h.ValidTo);
SELECT 'ParticipatedIn - Del' AS Оп, h.ParticipationID, h.ProfessionalID, h.ProjectID, h.ValidFrom, h.ValidTo FROM dbo.ParticipatedIn_History h WHERE h.ValidTo >= '2022-07-01' AND h.ValidTo < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.ParticipatedIn FOR SYSTEM_TIME ALL pt2 WHERE pt2.ParticipationID = h.ParticipationID AND pt2.ValidFrom = h.ValidTo);
SELECT 'UsesTechnology - Del' AS Оп, h.UseID, h.ProjectID, h.TechID, h.ValidFrom, h.ValidTo FROM dbo.UsesTechnology_History h WHERE h.ValidTo >= '2022-07-01' AND h.ValidTo < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.UsesTechnology FOR SYSTEM_TIME ALL u2 WHERE u2.UseID = h.UseID AND u2.ValidFrom = h.ValidTo);
SELECT 'HasSkill - Del' AS Оп, h.SkillID, h.ProfessionalID, h.TechID, h.ValidFrom, h.ValidTo FROM dbo.HasSkill_History h WHERE h.ValidTo >= '2022-07-01' AND h.ValidTo < '2022-10-01' AND NOT EXISTS(SELECT 1 FROM dbo.HasSkill FOR SYSTEM_TIME ALL hs2 WHERE hs2.SkillID = h.SkillID AND hs2.ValidFrom = h.ValidTo);



-- Запросы с JOIN нескольких темпоральных таблиц

-- Карьерный срез специалистов на середину года (30.06.2022)
-- Соединяет 4 темпоральные таблицы: Professionals, WorkedAt, Companies, HasSkill
PRINT 'Карьерный срез на 30.06.2022 (JOIN 4 таблиц) ';

SELECT
    p.LastName + N' ' + p.FirstName AS [Специалист],
    p.JobTitle AS [Роль],
    c.CompanyName AS [Компания],
    w.Salary AS [Оклад на тот момент],
    t.TechName AS [Ключевой навык],
    hs.SkillLevel AS [Уровень навыка (1-5)]
FROM dbo.Professionals FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999' AS p
JOIN dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999' AS w ON w.ProfessionalID = p.ProfessionalID
JOIN dbo.Companies FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999' AS c ON c.CompanyID = w.CompanyID
LEFT JOIN dbo.HasSkill FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999' AS hs ON hs.ProfessionalID = p.ProfessionalID
LEFT JOIN dbo.Technologies FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59.9999999' AS t ON t.TechID = hs.TechID
ORDER BY [Специалист];


-- Запрос Сводный зарплатный фонд по кварталам 2022 года 

PRINT ' Анализ по кварталам 2022 года';

SELECT Квартал, COUNT(DISTINCT ProfessionalID) AS [Сотрудников], SUM(Salary) AS [Общий ФОТ]
FROM (
    SELECT N'Q1 (31.03.2022)' AS Квартал, w.ProfessionalID, w.Salary
    FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-03-31T23:59:59' w
    
    UNION ALL
    
    SELECT N'Q2 (30.06.2022)', w.ProfessionalID, w.Salary
    FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-06-30T23:59:59' w
    
    UNION ALL
    
    SELECT N'Q3 (30.09.2022)', w.ProfessionalID, w.Salary
    FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-09-30T23:59:59' w
    
    UNION ALL
    
    SELECT N'Q4 (31.12.2022)', w.ProfessionalID, w.Salary
    FROM dbo.WorkedAt FOR SYSTEM_TIME AS OF '2022-12-31T23:59:59' w
) AS QuarterlyReport
GROUP BY Квартал;
GO