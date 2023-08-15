-- ************************solution 1 ****************************
with cte as (
    select
        *,
        lead(purchase_date) over(
            partition by user_id
            order by
                purchase_date
        ) as next_date
    from
        Purchases_2228
    order by
        user_id,
        purchase_date
)
select
    distinct user_id
from
    cte
where
    next_date is not null
    and (next_date - purchase_date) <= 7
order by
    user_id -- ************************solution 2 ****************************
select
    distinct p.user_id
from
    Purchases_2228 p
    join Purchases_2228 p1 on p.user_id = p1.user_id
    and p.purchase_id <> p1.purchase_id
    and (p.purchase_date - p1.purchase_date) between 0
    and 7
order by
    p.user_id