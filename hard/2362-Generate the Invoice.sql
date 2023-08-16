select
from
    purchases_2362
    join Products_2362 p using(product_id)
where
    p.product_id = (
        select
            invoice_id
        from
            purchases_2362
            join Products_2362 using(product_id)
        group by
            invoice_id
        order by
            sum(quantity * price) desc,
            invoice_id
        limit
            1
    )