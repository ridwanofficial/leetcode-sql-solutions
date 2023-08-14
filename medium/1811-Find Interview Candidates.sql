with cte as (
    select
        contest_id,
        gold_medal as user_id
    from
        contests_1811
    union
    select
        contest_id,
        silver_medal as user_id
    from
        contests_1811
    union
    select
        contest_id,
        bronz_medal as user_id
    from
        contests_1811
),
cte1 as (
    select
        *,
        row_number() over(
            partition by user_id
            order by
                contest_id
        ) as rnk
    from
        cte
    order by
        user_id,
        contest_id
),
cte2 as (
    select
        *,
        contest_id - rnk as diff
    from
        cte1
),
cte3 as (
    select
        distinct user_id
    from
        cte2
    group by
        user_id,
        diff
    having
        count(*) >= 3
),
cte4 as(
    select
        distinct gold_medal as user_id
    from
        contests_1811
    group by
        gold_medal
    having
        count(*) >= 3
),
cte5 as (
    select
        *
    from
        cte3
    union
    select
        *
    from
        cte4
)
select
    name,
    mail
from
    cte5 c
    join users_1811 u on c.user_id = u.user_id