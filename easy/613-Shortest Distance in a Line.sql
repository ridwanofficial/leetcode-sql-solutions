with
    cte as (
        select
            *,
            row_number() over (
                order by
                    x
            ) as serial
        from
            point_613
    )
select
    ABS(c.x - c1.x) as shortest
from
    cte c
    join cte c1 on c1.serial - c.serial = 1
order by
    ABS(c.x - c1.x)
    ----
    --- alternative
    ----
    -------
SELECT
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM
    point p1
    JOIN point p2 ON p1.x <> p2.x