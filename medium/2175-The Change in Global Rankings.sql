WITH cte AS (
    SELECT
        p.team_id,
        name,
        ROW_NUMBER() OVER (
            ORDER BY
                (points + points_change) DESC,
                name
        ) AS rnk_combined,
        ROW_NUMBER() OVER (
            ORDER BY
                points DESC,
                name
        ) AS rnk_points
    FROM
        team_points_2175 t
        JOIN points_change_2175 p ON t.team_id = p.team_id
)
SELECT
    team_id,
    name,
    rnk_combined - rnk_points AS rank_diff
FROM
    cte;