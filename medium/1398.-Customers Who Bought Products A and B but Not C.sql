with
    cte as (
        select distinct
            customer_id as bA
        from
            Orders_1398
        where
            product_name = 'A'
    ),
    cte1 as (
        select distinct
            customer_id as bB
        from
            Orders_1398
        where
            product_name = 'B'
    ),
    cte2 as (
        select distinct
            customer_id as bC
        from
            Orders_1398
        where
            product_name = 'C'
    )
select
    bA as customer_id,
    customer_name
from
    cte c
    join cte1 c1 on c.bA = c1.bB
    join Customers_1398 cu on cu.customer_id = c.bA
where
    bA not in (
        select
            bC
        from
            cte2
    )
    -----messsed up
SELECT
    customer_id
FROM
    Orders_1398
GROUP BY
    customer_id
having
    MAX(
        CASE
            WHEN product_name = 'A' THEN 1
            ELSE 0
        END
    ) = 1
    and MAX(
        CASE
            WHEN product_name = 'B' THEN 1
            ELSE 0
        END
    ) = 1
    and MAX(
        CASE
            WHEN product_name = 'C' THEN 1
            ELSE 0
        END
    ) = 0