with
    cte as (
        select
            user1_id as user_id,
            user2_id as frnd
        from
            friendship_1949
        union
        select
            user2_id as user_id,
            user1_id as frnd
        from
            friendship_1949
    ),
    cte1 as (
        select distinct
            users1.user_id as user1_id,
            users2.user_id as user2_id,
            count(*) as common_friend
        from
            cte users1
            join cte users2 on users1.frnd = users2.frnd
            and users1.user_id <> users2.user_id
        group by
            users1.user_id,
            users2.user_id
        having
            count(*) >= 3
        order by
            users1.user_id
    )
select
    *
from
    cte1
where
    user1_id < user2_id