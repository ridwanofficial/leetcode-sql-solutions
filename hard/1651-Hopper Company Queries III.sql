-------------solution 1
------
------------------
with recursive month as (
    select
        1 as month
    union
    select
        month + 1 as month
    from
        month
    where
        month < 12
),
cte as(
    SELECT
        EXTRACT(
            MONTH
            FROM
                requested_at
        ) as month,
        round(sum(ride_distance), 2) AS average_ride_distance,
        round(sum(ride_duration), 2) AS average_ride_duration
    FROM
        Accepted_Rides_1651 ar
        JOIN Rides_1651 r ON ar.ride_id = r.ride_id
    WHERE
        requested_at >= '2020-01-01'
        AND requested_at <= '2020-12-31'
    GROUP BY
        month
    order by
        month
),
cte1 as (
    select
        month,
        coalesce(average_ride_distance, 0) as average_ride_distance,
        coalesce(average_ride_duration, 0) as average_ride_duration
    from
        cte
        right join month using(month)
)
select
    c.month,
    round(avg(c1.average_ride_distance), 2) as average_ride_distance,
    round(avg(c1.average_ride_duration), 2) as average_ride_duration
from
    cte1 c
    join cte1 c1 on (c1.month - c.month) between 0
    and 2
    and c.month <= 10
group by
    c.month
order by
    c.month