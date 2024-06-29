with
    allplayers as (
        select
            Wimbledon as player_id
        from
            Championships_1783
        union all
        select
            Fr_open
        from
            Championships_1783
        union all
        select
            US_open
        from
            Championships_1783
        union all
        select
            Au_open
        from
            Championships_1783
    )
select
    p.player_id,
    count(*),
    player_name
from
    allplayers a
    left join Players_1783 p on p.player_id = a.player_id
group by
    p.player_id,
    player_name




    -- un pivot solution
    -- 
    -- 

    WITH allplayers AS (
    SELECT
        player_id,
        player_name
    FROM
        Players_1783
),
championships AS (
    SELECT 
        player_id, 
        COUNT(*) AS appearance_count
    FROM (
        SELECT
            unnest(array[Wimbledon, Fr_open, US_open, Au_open]) AS player_id
        FROM
            Championships_1783
    ) AS unpivoted
    WHERE player_id IS NOT NULL
    GROUP BY player_id
)
SELECT 
    a.player_id,
    COALESCE(c.appearance_count, 0) AS appearance_count,
    a.player_name
FROM 
    allplayers a
    LEFT JOIN championships c ON a.player_id = c.player_id;
