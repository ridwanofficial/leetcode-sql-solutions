with cte as(
    select
        *,
        row_number() over() as serial
    from
        point_2d
)
select
    ROUND(
        SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)) :: numeric,
        2
    ) as shortest
from
    cte p1
    join cte p2 on p1.serial > p2.serial
order by
    shortest_distance
limit
    1