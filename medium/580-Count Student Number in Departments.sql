with
    cte as (
        select
            dept_id,
            count(*) as student_number
        from
            student
        group by
            dept_id
    )
select
    dept_name,
    coalesce(student_number, 0)
from
    cte c
    right join department d on c.dept_id = d.dept_id