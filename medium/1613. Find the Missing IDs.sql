with
    cte as (
        SELECT
            generate_series (
                (
                    select
                        min(customer_id)
                    from
                        Customers_1613
                ),
                (
                    select
                        max(customer_id)
                    from
                        Customers_1613
                )
            ) AS number
    )
select
    number as missing_number
from
    Customers_1613 c
    right join cte c1 on c.customer_id = c1.number
where
    c.customer_id is null