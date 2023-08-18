with cte as (
    select
        e.id as id,
        e.month as single_month,
        e1.salary as cumulative_salary,
        rank() over(
            partition by e.id
            order by
                e.month desc
        ) as rnk
    from
        Employee_579 e
        join Employee_579 e1 on e.id = e1.id
        and e.month - e1.month between 0
        and 2
),
cte1 as(
    select
        *
    from
        cte
    where
        rnk <> 1
)
select
    id,
    single_month as month,
    sum(cumulative_salary) as Salary
from
    cte1
group by
    id,
    month
order by
    id,
    month desc