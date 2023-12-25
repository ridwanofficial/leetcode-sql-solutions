select distinct
    e.employee_id
from
    employees_1270 e
    join employees_1270 e1 on (e.manager_id = e1.employee_id)
    join employees_1270 e2 on (e1.manager_id = e2.employee_id)
where
    e.employee_id <> 1
    and (
        e1.manager_id = 1
        or e2.manager_id = 1
    )