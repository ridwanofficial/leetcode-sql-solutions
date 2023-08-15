with cte as (
    select
        *
    from
        friendship
    where
        user_id1 = 1
        or user_id2 = 1
),
cte1 as (
    select
        user_id1 as u1frnd
    from
        cte
    where
        user_id1 <> 1
    union
    select
        user_id2 as u1frnd
    from
        cte
    where
        user_id2 <> 1
),
cte2 as (
    select
        page_id
    from
        likes
    where
        user_id in (
            select
                *
            from
                cte1
        )
    except
    select
        page_id
    from
        likes
    where
        user_id = 1
    order by
        page_id
)
select
    page_id as recommended_page
from
    cte2