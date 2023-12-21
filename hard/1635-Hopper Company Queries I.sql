with
    recursive months as (
        select
            1 as month
        union
        select
            month + 1
        from
            months
        where
            month < 12
    ),
    cte1 as (
        select
            EXTRACT(
                MONTH
                FROM
                    requested_at
            ) as month,
            count(*) as accepted_rides
        from
            Accepted_Rides a
            join Rides using (ride_id)
        where
            extract(
                year
                from
                    requested_at
            ) = 2020
        group by
            EXTRACT(
                MONTH
                FROM
                    requested_at
            )
        order by
            month
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
            drivers
    ),
    cte2 as (
        select
            month,
            count(*) as driver_count
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
    ),
    cte3 as (
        select
            month,
            coalesce(driver_count, 0) as driver_count
        from
            cte2
            right join months using (month)
        order by
            month
    )
select
    month,
    sum(driver_count) over (
        order by
            month
    ) as active_drivers,
    coalesce(accepted_rides, 0) as accepted_rides
from
    cte3
    left join cte1 using (month)