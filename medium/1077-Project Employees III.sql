with
    cte as (
        select
            *
        from
            employee_1077
            right join project_1077 using (employee_id)
    ),
    cte1 as (
        select
            project_id,
            max(experience_years)
        from
            cte
        group by
            project_id
    )
select
    project_id,
    employee_id
from
    cte
    join cte1 using (project_id)
where
    experience_years = max
order by
    project_id