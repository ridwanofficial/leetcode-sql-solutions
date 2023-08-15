with cte as(
    select
        user_id
    from
        Activity
    WHERE
        activity_date BETWEEN '2019-06-28'
        AND '2019-07-27'
    group by
        user_id,
        activity_date
),
cte1 as(
    select
        user_id,
        count(*)
    from
        cte
    group by
        user_id
)
select
    round(avg(count), 2) as average_sessions_per_user
from
    cte1