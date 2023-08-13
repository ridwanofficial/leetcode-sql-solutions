with cte AS(
    SELECT
        b.book_id,
        name,
        SUM(
            CASE
                WHEN dispatch_date BETWEEN '2018-06-23'
                AND '2019-06-23' THEN QUANTITY
                ELSE 0
            END
        ) AS quantity
    FROM
        orders o
        RIGHT JOIN books b ON b.book_id = o.book_id
    WHERE
        b.available_from <= '2019-05-23' -- Books available for at least one month
    GROUP BY
        b.book_id,
        name
)
select
    book_id,
    name
from
    cte
where
    quantity <= 10