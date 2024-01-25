# A different way of solving with COUNT instead on RANK
WITH freq_count AS (
    SELECT
        customer_id,
        product_id,
        COUNT(product_id) AS total_order
    FROM orders
    GROUP BY customer_id, product_id
)
, max_order AS (
    SELECT
        customer_id,
        product_id        
    FROM freq_count f
    WHERE total_order = (SELECT MAX(total_order) FROM freq_count WHERE customer_id = f.customer_id)
)
SELECT
    customer_id,
    product_id,
    product_name
FROM max_order 
LEFT JOIN products using(product_id);   