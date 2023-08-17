with cte as(
    select
        *,
        row_number() over(
            partition by seller_id
            order by
                order_date
        ) as rnk
    from
        Orders
),
cte1 as (
    select
        seller_id,
        item_id
    from
        cte
    where
        rnk = 2
)
select
    user_id as seller_id,
    case
        when item_brand is null
        or item_brand <> favorite_brand then 'no'
        else 'yes'
    end
from
    cte1 c
    join items using(item_id)
    right join Users u on u.user_id = c.seller_id