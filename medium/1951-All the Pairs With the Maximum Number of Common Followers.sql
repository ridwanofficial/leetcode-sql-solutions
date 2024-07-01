with
    cte as (
        select
            r.user_id as u1,
            r1.user_id as u2
        from
            public.relations_1951 r
            join public.relations_1951 r1 on r.follower_id = r1.follower_id
            and r.user_id < r1.user_id
    ),
    cte1 as (
        select
            u1,
            u2,
            count(*) as mutual
        from
            cte
        group by
            u1,
            u2
    )
select
    *
from
    cte1
where
    mutual in (
        select
            max(mutual)
        from
            cte1
    )
