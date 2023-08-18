with cte as(
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
cte2 as(
    select
        l.user_id as user1_id,
        l1.user_id as user2_id
    from
        listens l
        join listens l1 on l.user_id <> l1.user_id
        and l.song_id = l1.song_id
        and l.day = l1.day
    where
        l.user_id < l1.user_id
    group by
        l.user_id,
        l1.user_id
    having
        count(*) >= 3
    order by
        l.user_id,
        l1.user_id
)
select
    c.user1_id,
    c.user2_id
from
    cte2 c
    join Friendship f on c.user1_id = f.user1_id
    and c.user2_id = f.user2_id