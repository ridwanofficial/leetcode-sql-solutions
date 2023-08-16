with cte as (
    select
        *,
        row_number() over(
            partition by company
            order by
                salary desc
        ) as rnk,
        count(*) over(partition by company) as total
    from
        Employee
)
select
    id,
    company,
    salary
from
    cte
where
    (
        total % 2 = 1
        and rnk = (total + 1) / 2
    )
    or (
        total % 2 = 0
        and rnk = (total) / 2
        or rnk = ((total) / 2) + 1
    )