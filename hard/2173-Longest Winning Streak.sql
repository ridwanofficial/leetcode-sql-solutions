with cte as (
    select
        player_id,
        match_day,
        result,
        lag(result) over(
            partition by player_id
            order by
                match_day
        )
    from
        matches
),
cte1 as(
    select
        player_id,
        sum(
            case
                when lag is null
                or result = lag then 0
                else 1
            end
        ) over(
            partition by player_id
            order by
                match_day
        ) as score
    from
        cte
    where
        result = 'Win'
),
cte2 as (
    select
        player_id,
        count(*) as steak
    from
        cte1
    group by
        player_id,
        score
),
cte3 as(
    select
        player_id,
        max(steak) as longest_streak
    from
        cte2
    group by
        player_id
)
select
    player_id,
    coalesce(longest_streak, 0) as longest_streak
from
    (
        select
            distinct player_id
        from
            Matches
    ) t
    left join cte3 using(player_id)