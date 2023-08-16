select
    p.product_id,
    quantity,
    price
from
    purchases
    join Products p using(product_id)
where
    p.product_id = (
        select
            invoice_id
        from
            purchases
            join Products using(product_id)
        group by
            invoice_id
        order by
            sum(quantity * price) desc,
            invoice_id
        limit
            1
    )