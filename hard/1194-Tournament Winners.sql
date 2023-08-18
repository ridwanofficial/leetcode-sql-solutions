with cte as (
    select
        first_player as player_id,
        first_score as score
    from
        Matches
    union
    all
    select
        second_player as player_id,
        second_score as score
    from
        Matches
),
cte1 as(
    select
        player_id,
        sum(score) as score
    from
        cte
    group by
        player_id
),
cte2 as(
    select
        *,
        row_number() over(
            partition by group_id
            order by
                score desc,
                player_id
        ) as rnk
    from
        cte1
        join Players using(player_id)
)
select
    group_id,
    player_id
from
    cte2
where
    rnk = 1