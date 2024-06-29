with
    cte as (
        select
            order_id,
            MAX(quantity) AS mx,
            AVG(quantity) AS av
        from
            public.orders_details_1867
        group by
            order_id
    )
select
    order_id
from
    cte
where
    mx > (
        select
            max(av)
        from
            cte
    )