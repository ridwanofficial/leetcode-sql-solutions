select
    s1.gender,
    s1.day,
    s1.player_name,
    sum(s2.score_points)
from
    Scores_1308 s1
    join Scores_1308 s2 on s1.gender = s2.gender
    and s1.day >= s2.day
group by
    s1.gender,
    s1.day,
    s1.player_name
order by
    s1.gender,
    s1.day