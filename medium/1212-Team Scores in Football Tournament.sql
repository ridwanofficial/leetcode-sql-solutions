with
    cte as (
        select
            host_team,
            guest_team,
            case
                when host_goals = guest_goals then 1
                when host_goals > guest_goals then 3
                ELSE 0
            END as host_points,
            case
                when guest_goals = host_goals then 1
                when guest_goals > host_goals then 3
                ELSE 0
            END as guest_points
        from
            matches
    ),
    cte1 as (
        select
            host_team as team_id,
            host_points as point
        from
            cte
        union all
        select
            guest_team as team_id,
            guest_points as point
        from
            cte
    )
select
    t.team_name,
    coalesce(sum(point), 0) as num_points
from
    cte1 c
    right join teams t using (team_id)
group by
    t.team_name
order by
    num_points desc