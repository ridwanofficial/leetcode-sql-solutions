select
    Round(
        (
            SUM(
                CASE
                    WHEN order_date = customer_pref_delivery_date THEN 1
                    else 0
                END
            ) * 100
        ) / count(*)::numeric,
        2
    )
from
    Delivery_1173