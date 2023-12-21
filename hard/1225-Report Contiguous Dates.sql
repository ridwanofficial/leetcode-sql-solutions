with
    cte as (
        select
            success_date as date,
            'succeeded' as status
        from
            Succeeded
        union
        select
            fail_date as date,
            'failed' as status
        from
            Failed
    ),
    cte1 as (
        select
            *,
            lag(status) over (
                order by
                    date
            )
        from
            cte
        where
            EXTRACT(
                YEAR
                FROM
                    date
            ) = 2019
        order by
            date
    ),
    cte2 as (
        select
            *,
            sum(
                case
                    when lag is null
                    or status = lag then 0
                    else 1
                end
            ) over (
                order by
                    date
            ) as score
        from
            cte1
    ),
    cte3 as (
        select
            *,
            first_value(date) over (
                partition by
                    score
                order by
                    date
            ) as start_date,
            last_value(date) over (
                partition by
                    score
            ) as end_date
        from
            cte2
    )
select
    min(status) as period_state,
    min(start_date) as start_date,
    min(end_date) as end_date
from
    cte3
group by
    score
order by
    start_date