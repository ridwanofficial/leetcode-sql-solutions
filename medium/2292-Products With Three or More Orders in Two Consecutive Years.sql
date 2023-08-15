-------------soluton 1 ------------------------------------------------------
with cte as (
    select
        product_id,
        EXTRACT(
            YEAR
            FROM
                purchase_date :: date
        ) AS year
    from
        orders
),
cte1 as(
    select
        product_id,
        year,
        count(*) as order_num
    from
        cte
    group by
        product_id,
        year
),
cte2 as(
    select
        *,
        lead(order_num) over(
            partition by product_id
            order by
                year
        ) as next_order,
        lead(year) over(
            partition by product_id
            order by
                year
        ) as next_year
    from
        cte1
    order by
        product_id,
        year
)
select
    distinct product_id
from
    cte2
where
    next_year is not null
    and order_num + next_order >= 3
    and year + 1 = next_year -------------soluton 2 ------------------------------------------------------
    with cte as (
        select
            product_id,
            EXTRACT(
                YEAR
                FROM
                    purchase_date :: date
            ) AS year
        from
            orders
    ),
    cte1 as(
        select
            product_id,
            year,
            count(*) as order_num
        from
            cte
        group by
            product_id,
            year
    )
select
    distinct c.product_id
from
    cte1 c
    join cte1 c1 on c.year + 1 = c1.year
    and c.product_id = c1.product_id
    and c.order_num + c1.order_num >= 3