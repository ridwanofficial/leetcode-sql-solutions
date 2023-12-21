with
    cte as (
        select
            *,
            case
                when home_team_goals = away_team_goals then 1
                when home_team_goals > away_team_goals then 3
                ELSE 0
            END as host_points,
            case
                when away_team_goals = home_team_goals then 1
                when away_team_goals > home_team_goals then 3
                ELSE 0
            END as guest_points
        from
            Matches
    ),
    cte1 as (
        select
            home_team_id as team_id,
            home_team_goals as goal_for,
            away_team_goals as goal_against,
            host_points as point
        from
            cte
        union all
        select
            away_team_id as team_id,
            away_team_goals as goal_for,
            home_team_goals as goal_against,
            guest_points as point
        from
            cte
    )
select
    team_name,
    count(*) as matches_played,
    sum(point) as points,
    sum(goal_for) as goal_for,
    sum(goal_against) as goal_against,
    (sum(goal_for) - sum(goal_against)) as goal_diff
from
    cte1 c
    join teams t using (team_id)
group by
    team_name
order by
    points desc,
    goal_diff desc,
    team_name