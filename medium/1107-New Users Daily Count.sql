with cte as (
    select
        user_id,
        min(activity_date) as first_login
    from
        traffic_1107
    where
        activity = 'login'
    group by
        user_id
    having
        min(activity_date) between '2019-03-30'
        and '2019-06-30'
)
select
    first_login as login_date,
    count(*) as user_count
from
    cte
group by
    first_login