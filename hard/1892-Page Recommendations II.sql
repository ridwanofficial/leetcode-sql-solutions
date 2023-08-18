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
friend as (
    select
        u.user_id as user_id,
        f.user_id as friend_id
    from
        cte u
        join cte f on u.friend_id = f.user_id
        and f.friend_id = u.user_id
),
cte1 as (
    select
        f.user_id,
        page_id,
        count(*) as friends_likes
    from
        friend f
        join likes l on f.friend_id = l.user_id
    group by
        f.user_id,
        page_id
)
select
    c.user_id,
    c.page_id,
    friends_likes
from
    cte1 c
    left join likes l on c.user_id = l.user_id
    and c.page_id = l.page_id
where
    l.user_id is null
order by
    c.user_id