with cte as (
    select
        *,
        round(avg(occurences) over(partition by event_type), 2) as avg_occurence
    from
        events
    order by
        event_type
),
CTE1 AS (
    select
        business_id,
        SUM(
            CASE
                WHEN occurences > avg_occurence THEN 1
                ELSE 0
            END
        ) AS GOOD_PERF
    from
        cte
    group by
        business_id
)
SELECT
    business_id
FROM
    CTE1
WHERE
    GOOD_PERF > 1