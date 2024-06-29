with
    cte as (
        select
            transactions_id,
            amount,
            DATE_TRUNC ('day', day) as tran_day
        from
            transactions_1831
    ),
    complex as (
        select
            *,
            row_number() over (
                partition by
                    tran_day
                order by
                    tran_day
            ) as row,
            MAX(amount) over (
                partition by
                    tran_day
                order by
                    tran_day
            ) as max
        from
            cte
    )
select
    transactions_id
from
    complex
where
    amount = max
    --  without window function 
with
    cte as (
        select
            transactions_id,
            amount,
            DATE_TRUNC ('day', day) as tran_day
        from
            transactions_1831
    ),
    maxBydate as (
        select
            tran_day,
            max(amount) as mx
        from
            cte
        group by
            tran_day
    )
select
    transactions_id
from
    maxByDate mD
    join cte c on c.tran_day = mD.tran_day
    and c.amount = mD.mx
