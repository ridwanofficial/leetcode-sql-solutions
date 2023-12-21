with
    cte as (
        select
            action_date,
            ROUND(
                (
                    SUM(
                        CASE
                            WHEN remove_date is not null THEN 1
                            ELSE 0
                        END
                    )
                ),
                0
            ) as DAILY_post_removed,
            COUNT(*) AS DAILY_TOTAL_SPAM_REPORTED
        from
            actions a
            left join removals r on a.post_id = r.post_id
        where
            action = 'report'
            and extra = 'spam'
        group by
            action_date
    )
SELECT
    ROUND(
        AVG(DAILY_post_removed / DAILY_TOTAL_SPAM_REPORTED) * 100,
        2
    ) AS average_daily_percent
FROM
    CTE