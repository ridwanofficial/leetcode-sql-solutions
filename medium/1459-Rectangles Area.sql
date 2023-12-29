with
    cte as (
        select
            p1.id as p1,
            p2.id as p2,
            abs(p1.x_value - p2.x_value) * abs(p1.y_value - p2.y_value) as area
        from
            Points_1459 p1
            join Points_1459 p2 on p1.id < p2.id
    )
select
    *
from
    cte
where
    area <> 0
order by
    area desc,
    p1,
    p2;