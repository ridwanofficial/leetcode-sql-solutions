with cte as(
    select
        *,
        row_number() over(
            partition by username
            order by
                start_date desc
        ) as rnk,
        count(*) over(partition by username) as total
    from
        User_Activity
)
select
    username,
    activity,
    start_Date,
    end_Date
from
    cte
where
    total = 1
    or rnk = 2