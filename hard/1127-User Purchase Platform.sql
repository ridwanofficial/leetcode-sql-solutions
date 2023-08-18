WITH cte AS (
    SELECT
        *,
        COUNT(*) OVER(PARTITION BY user_id, spend_date) AS total
    FROM
        Spending_1127
),
cte1 AS (
    SELECT
        spend_date,
        SUM(
            CASE
                WHEN total = 2 THEN amount
                ELSE 0
            END
        ) AS boths,
        SUM(
            CASE
                WHEN total = 2 THEN 1
                ELSE 0
            END
        ) AS bothsUser,
        SUM(
            CASE
                WHEN total = 1
                AND platform = 'desktop' THEN amount
                ELSE 0
            END
        ) AS desktop,
        SUM(
            CASE
                WHEN total = 1
                AND platform = 'desktop' THEN 1
                ELSE 0
            END
        ) AS desktopUser,
        SUM(
            CASE
                WHEN total = 1
                AND platform = 'mobile' THEN amount
                ELSE 0
            END
        ) AS mobile,
        SUM(
            CASE
                WHEN total = 1
                AND platform = 'mobile' THEN 1
                ELSE 0
            END
        ) AS mobileUser
    FROM
        cte
    GROUP BY
        spend_date
)
SELECT
    spend_date,
    'desktop' AS platform,
    desktop AS total_amount,
    desktopUser AS total_users
FROM
    cte1
UNION
ALL
SELECT
    spend_date,
    'mobile' AS platform,
    mobile AS total_amount,
    mobileUser AS total_users
FROM
    cte1
UNION
ALL
SELECT
    spend_date,
    'both' AS platform,
    boths AS total_amount,
    bothsUser AS total_users
FROM
    cte1;