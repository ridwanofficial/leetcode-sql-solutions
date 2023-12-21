with
    cte as (
        select
            paid_by as user_id,
            - amount as credit
        from
            Transactions
        union all
        select
            paid_to as user_id,
            amount as credit
        from
            Transactions
    ),
    cte1 as (
        select
            user_id,
            sum(credit) as credit
        from
            cte
        group by
            user_id
    )
select
    u.user_id,
    u.user_name,
    (coalesce(c.credit, 0) + u.credit) as credit,
    case
        when (c.credit + u.credit) < 0 then 'Yes'
        ELSE 'No'
    end as credit_limit_breached
from
    cte1 c
    right join Users u using (user_id)