with cte as (
    select
        *,
        row_number() over(
            partition by call_time :: date
            order by
                call_time
        ) as rnk,
        count(*) over(partition by call_time :: date) as total
    from
        calls
    order by
        call_time
),
cte1 as (
    select
        *
    from
        cte
    where
        total = 1
),
cte2 as (
    select
        *
    from
        cte
    where
        total <> 1
        and (
            rnk = 1
            or rnk = total
        )
),
cte3 as (
    select
        caller_id as id,
        call_time
    from
        cte2
    union
    select
        recipient_id as id,
        call_time
    from
        cte2
),
cte4 as(
    select
        call_time :: date,
        count(distinct id) as distinct_count
    from
        cte3
    group by
        call_time :: date
),
cte5 as(
    select
        call_time
    from
        cte4
    where
        distinct_count = 2
)
select
    caller_id as user_id
from
    cte1
union
select
    recipient_id as user_id
from
    cte1
union
(
    select
        id as user_id
    from
        cte3
    where
        call_time :: date in (
            select
                call_time
            from
                cte5
        )
)