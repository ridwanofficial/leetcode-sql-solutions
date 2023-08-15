with cte as (
    select
        t.account_id,
        TO_CHAR(day, 'MM') as mon,
        sum(amount) as amount
    from
        Transactions t
        join accounts a using(account_id)
    where
        type = 'Creditor'
    group by
        TO_CHAR(day, 'MM'),
        t.account_id,
        max_income
    having
        sum(amount) > max_income
),
cte1 as (
    select
        *,
        row_number() over(
            partition by account_id
            order by
                mon
        ) as rnk
    from
        cte
),
cte2 as (
    select
        *,
        (mon :: integer - rnk) as diff
    from
        cte1
)
select
    distinct account_id
from
    cte2
group by
    account_id,
    diff
having
    count(*) >= 2