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
select
    round(
        CAST(count(*) AS NUMERIC) / count(distinct user_id),
        2
    ) as average_sessions_per_user
from
    cte