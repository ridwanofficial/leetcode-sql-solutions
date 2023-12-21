with
    cte as (
        select
            *,
            row_number() over () as serial
        from
            point_2d
    )
select
    ROUND(
        SQRT(POW (p1.x - p2.x, 2) + POW (p1.y - p2.y, 2)):: numeric,
        2
    ) as shortest
from
    cte p1
    join cte p2 on p1.serial > p2.serial
order by
    shortest_distance limit 1
    ---- Window func alternatives (only work when [x,y] is different)
with
    cte as (
        select
            round(
                sqrt(power((p.x - p1.x), 2) + power((p.y - p1.y), 2)):: numeric,
                2
            ) AS distance
        from
            point_2d_612 p
            join point_2d_612 p1 on p.x <> p1.x
            or p.y <> p1.y
    )
select
    distance as shortest
from
    cte
order by
    distance limit 1


    --- efficient , grouping best on coordinate



    with
    cte as (
        select
            round(
                sqrt(power((p.x - p1.x), 2) + power((p.y - p1.y), 2))::numeric,
                2
            ) AS distance
        from
            point_2d_612 p
            join point_2d_612 p1 on ( p.x < p1.x
		or ( p.x = p1.x and p.y < p1.y) )
    )
 	 
select
    distance as shortest
from
    cte
order by
    distance
    limit 1