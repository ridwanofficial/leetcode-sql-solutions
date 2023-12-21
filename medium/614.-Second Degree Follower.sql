with
    cte as (
        select
            followee,
            count(*) as num
        from
            Follow
        group by
            followee
    ),
    cte1 as (
        select distinct
            follower
        from
            Follow
    )
select
    follower,
    num
from
    cte
    left join cte1 on cte.followee = cte1.follower
where
    follower is not null
order by
    follower