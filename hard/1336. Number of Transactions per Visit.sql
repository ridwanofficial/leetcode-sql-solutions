with cte as(
    select
        *,
        row_number() over(
            partition by user_id
            order by
                transaction_date
        ) as transcation_count
    from
        Transactions
    order by
        Transactions
),
cte1 as(
    select
        v.user_id,
        visit_date,
        max(coalesce(transcation_count, 0)) as visit
    from
        cte c full
        outer join visits v on c.user_id = v.user_id
        and c.transaction_date <= v.visit_date
    group by
        v.user_id,
        visit_date
    order by
        user_id,
        visit_date
),
cte2 as(
    select
        *,
        coalesce(
            lag(visit) over(
                partition by user_id
                order by
                    visit_date
            ),
            0
        ) as previous_visit
    from
        cte1
),
cte3 as(
    select
        user_id,
        visit_date,
        (visit - previous_visit) as transactions_count
    from
        cte2
)
select
    transactions_count,
    count(*) as visits_count
from
    cte3
group by
    transactions_count