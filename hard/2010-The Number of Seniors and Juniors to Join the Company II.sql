with cte as(
    select
        *,
        sum(salary) over(
            partition by experience
            order by
                salary
        ) as sum_salary
    from
        candidates_2010
),
cte1 as(
    select
        *
    from
        cte
    where
        sum_salary <= 70000
        and experience = 'Senior'
    order by
        sum_salary
),
cte2 as (
    select
        *
    from
        cte
    where
        sum_salary <= (
            select
                70000 - max(sum_salary)
            from
                cte1
        )
        and experience = 'Junior'
    order by
        sum_salary
)
select
    employee_id
from
    cte1
union
select
    employee_id
from
    cte2