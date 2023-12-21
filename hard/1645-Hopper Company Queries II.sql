-------------solution 1
------
------------------
with
    recursive month as (
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
    cte as (
        SELECT
            EXTRACT(
                MONTH
                FROM
                    requested_at
            ) as month,
            COUNT(DISTINCT driver_id) AS DRIVER_COUNT
        FROM
            Accepted_Rides_1645 ar
            JOIN Rides_1645 r ON ar.ride_id = r.ride_id
        WHERE
            requested_at >= '2020-01-01'
            AND requested_at <= '2020-12-31'
        GROUP BY
            month
        order by
            month
    ),
    CTE2 AS (
        select
            MONTH,
            COALESCE(DRIVER_COUNT, 0) AS DRIVER_COUNT
        from
            cte
            right join month using (month)
    ),
    cte4 as (
        select
            driver_id,
            join_date,
            case
                when extract(
                    year
                    from
                        join_date
                ) < 2020 then 1
                else EXTRACT(
                    MONTH
                    FROM
                        join_date
                )
            end as month
        from
            drivers_1645
    ),
    cte3 as (
        select
            month,
            count(*) as join_count
        from
            cte4
        where
            extract(
                year
                from
                    join_date
            ) <= 2020
        group by
            month
        order by
            month
    )
SELECT
    month,
    round(
        (
            driver_count / sum(coalesce(join_count, 0)) over (
                order by
                    month
            )
        ) * 100,
        2
    ) as working_percentage
FROM
    CTE3 C2
    right JOIN CTE2 USING (month)
order by
    month