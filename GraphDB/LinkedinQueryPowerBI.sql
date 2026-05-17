
SELECT 
    p.ID AS SourceId,
    p.FirstName + ' ' + p.LastName AS SourceLabel,
    'Prof' + CAST(p.ID AS VARCHAR(10)) + '.png' AS SourceImage,
    c.ID AS TargetId,
    c.Name AS TargetLabel,
    'Comp' + CAST(c.ID AS VARCHAR(10)) + '.png' AS TargetImage,
    'Worked At' AS RelationType
FROM Professional p, WorkedAt w, Company c
WHERE MATCH(p-(w)->c);