with
    cte as (
        select
            user1_id as user_id,
            user2_id as friend_id
        from
            Friendship
        union
        select
            user2_id as user_id,
            user1_id as friend_id
        from
            Friendship
    ),
    cte2 as (
        select
            l.user_id as user1_id,
            l1.user_id as user2_id
        from
            listens l
            join listens l1 on l.user_id <> l1.user_id
            and l.song_id = l1.song_id
            and l.day = l1.day
        group by
            l.user_id,
            l1.user_id
        having
            count(*) >= 3
        order by
            l.user_id,
            l1.user_id
    ),
    cte5 as (
        select
            *
        from
            cte2
        except
        select
            *
        from
            cte
    )
select
    user1_id as user_id,
    user2_id as recommended_id
from
    cte5