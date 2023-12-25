select
    s.id,
    s.name
from
    students_1350 s
    left join Departments_1350 d on s.department_id = d.id
where
    d.id is null