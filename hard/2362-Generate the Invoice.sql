with
    cte as (
        select
            *
        from
            purchases
            join Products using (product_id)
    )
select
    product_id,
    quantity,
    price
from
    cte
where
    product_id = (
        select
            invoice_id
        from
            cte
        group by
            invoice_id
        order by
            sum(quantity * price) desc,
            invoice_id limit 1
    )