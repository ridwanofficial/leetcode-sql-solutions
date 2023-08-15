with cte as (
    select
        *,
        row_number() over() as rnk
    from
        Coffee_Shop
),
cte2 as (
    select
        *,
        SUM(
            CASE
                WHEN drink IS NOT NULL THEN 1
                ELSE 0
            END
        ) OVER (
            ORDER BY
                rnk
        ) AS group_id
    from
        cte
)
select
    id,
    First_value(drink) over(partition by group_id) as drink
from
    cte2