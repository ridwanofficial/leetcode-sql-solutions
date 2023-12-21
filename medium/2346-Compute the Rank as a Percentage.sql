with
    cte as (
        select
            *,
            dense_rank() over (
                partition by
                    department_id
                order by
                    mark desc
            ) as student_rank_in_the_department,
            count(*) over (
                partition by
                    department_id
            ) as the_number_of_students_in_the_department
        from
            Students
        order by
            department_id
    )
select
    student_id,
    department_id,
    round(
        (student_rank_in_the_department - 1) * 100 / (the_number_of_students_in_the_department - 1),
        2
    ) as percentage
from
    cte