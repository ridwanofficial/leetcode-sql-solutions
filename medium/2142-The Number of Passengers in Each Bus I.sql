with cte as (
    select
        *,
        row_number() over(
            partition by passenger_id
            order by
                b.arrival_time
        ) as rnk
    from
        passengers p
        join buses b on b.arrival_time > p.arrival_time
    order by
        p.arrival_time
),
cte2 as (
    select
        bus_id,
        count(*) as passengers_cnt
    from
        cte
    where
        rnk = 1
    group by
        bus_id
)
select
    bus_id,
    coalesce(passengers_cnt, 0)
from
    cte2 c
    right join buses b using(bus_id)
order by
    bus_id