with
    cte as (
        select
            *,
            max(score) over () as high,
            min(score) over () as low
        from
            students
            join exams using (student_id)
    )
select distinct
    student_id,
    student_name
from
    cte
except
select distinct
    student_id,
    student_name
from
    cte
where
    score = (
        select
            max(score)
        from
            exams
    )
    or score = (
        select
            min(score)
        from
            exams
    )