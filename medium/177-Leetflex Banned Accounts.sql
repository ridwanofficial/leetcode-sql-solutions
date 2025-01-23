with
    cte as (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY
                    account_id
                ORDER BY
                    login
            ) as rank
        FROM
            log_info_1747
    )
select
    c1.login,
    c.login,
    c.logout,
    c1.account_id
from
    cte c
    join cte c1 on c.account_id = c1.account_id
    and c.rank = c1.rank - 1
where
    c.login <= c1.login
    and c1.login <= c.logout
    ----------------------------------------------
    ---
    --
    --
SELECT distinct
    l1.account_id
FROM
    log_info_1747 l1
    JOIN log_info_1747 l2 ON l1.account_id = l2.account_id
    and l1.ip_address <> l2.ip_address
WHERE
    (
        l2.login <= l1.login
        AND l1.login <= l2.logout
    )
    or (
        l1.login <= l2.login
        AND l2.login <= l1.logout
    )