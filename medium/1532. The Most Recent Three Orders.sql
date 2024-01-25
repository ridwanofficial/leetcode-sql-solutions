SELECT
    o1.customer_id,
    o1.order_date,
    COUNT(o2.order_date)
FROM
    orders_1532 o1
    INNER JOIN orders_1532 o2 ON o1.customer_id = o2.customer_id
    AND o1.order_date <= o2.order_date
GROUP BY
    o1.customer_id,
    o1.order_date
HAVING
    COUNT(o2.order_date) <= 3
ORDER BY
    1,
    2 DESC;