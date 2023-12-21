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
    ------------ Alternative
with
    cte as (
        select
            dept_name,
            SUM(
                CASE
                    WHEN student_id IS NULL THEN 0
                    ELSE 1
                END
            ) as student_number -- COUNT(student_id) AS student_number
        from
            student_580
            right join department_580 using (dept_id)
        group by
            dept_id,
            dept_name
    )
select
    *
from
    cte
order by
    student_number desc,
    dept_name