with
    parsedCountry as (
        select
            *,
            substring (
                phone_number
                from
                    '(\d+)'
            ) AS country_code
        from
            person
    ),
    cte as (
        select
            id,
            country_code,
            c.name
        from
            parsedCountry p
            join country c using (country_code)
    ),
    cte1 as (
        select
            caller_id as id,
            duration
        from
            calls
        union all
        select
            callee_id as id,
            duration
        from
            calls
    ),
    cte2 as (
        select
            id,
            round(avg(duration), 5) as avg_duration
        from
            cte1
        group by
            id
    ),
    cte3 as (
        select
            name,
            round(
                avg(avg_duration) over (
                    partition by
                        name
                ),
                5
            ) as duration,
            round(avg(avg_duration) over (), 5) as global_duration
        from
            cte2 c2
            join cte c using (id)
    )
select distinct
    name
from
    cte3
where
    global_duration < duration