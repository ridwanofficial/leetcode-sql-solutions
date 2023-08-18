with cte as (
    select
        distinct seller_id
    from
        Orders
    except
    select
        distinct seller_id
    from
        Orders
    where
        EXTRACT(
            YEAR
            FROM
                sale_date :: date
        ) = 2020
)
select
    seller_name
from
    cte
    join seller using(seller_id)