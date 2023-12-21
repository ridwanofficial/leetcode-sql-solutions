with
    cte as (
        select
            TO_CHAR(trans_date, 'YYYY-MM') AS mon,
            country,
            sum(
                case
                    when state = 'approved' then 1
                    else 0
                end
            ) as approved_count,
            sum(
                case
                    when state = 'approved' then amount
                    else 0
                end
            ) as approved_amount
        from
            Transactions
        group by
            mon,
            country
    ),
    cte1 as (
        select
            TO_CHAR(c.charge_date, 'YYYY-MM') AS mon,
            country,
            count(*) as chargeback_count,
            sum(amount) as chargeback_amount
        from
            Chargebacks c
            join Transactions t on c.trans_id = t.id
        group by
            TO_CHAR(c.charge_date, 'YYYY-MM'),
            country
    )
select
    coalesce(c.mon, c1.mon) as mon,
    coalesce(c.country, c1.country) as country,
    coalesce(approved_count, 0) as approved_count,
    coalesce(approved_amount, 0) as approved_amount,
    coalesce(chargeback_count, 0) as chargeback_count,
    coalesce(chargeback_amount, 0) as chargeback_amount
from
    cte c
    FULL OUTER JOIN cte1 c1 on c.mon = c1.mon
    and c.country = c1.country