with cte as (
    select
        distinct seller_id
    from
        Orders_1607
    except
    select
        distinct seller_id
    from
        Orders_1607
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
    join seller_1607 using(seller_id)