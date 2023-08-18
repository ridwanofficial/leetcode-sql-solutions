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
        Employee e
        join Employee e1 on e.id = e1.id
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
    month desc -------------------------------------- ------------------- -------------------
    -------------------------------------- ------------------- -------------------
    -------------------------------------- ------------------- -------------------
    ---------------------------solution 2-----------------------
    -------------
    with cte5 as(
        select
            *,
            rank() over(
                partition by id
                order by
                    month desc
            ) as rnk
        from
            Employee
    ),
    cte1 as(
        select
            *
        from
            cte5
        where
            rnk <> 1
    )
select
    e.id as id,
    e.month as single_month,
    (
        coalesce(e1.salary, 0) + coalesce(e.salary, 0) + coalesce(e2.salary, 0)
    ) as cumulative_salary
from
    cte1 e
    left join cte1 e1 on (
        e.id = e1.id
        and e.month = e1.month + 1
    )
    left join cte1 e2 on (
        e1.id = e2.id
        and e1.month = e2.month + 1
    )
order by
    e.id,
    e.month desc