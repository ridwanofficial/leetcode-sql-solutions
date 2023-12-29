SELECT
    sale_date,
    SUM(
        CASE
            WHEN fruit = 'apples' THEN sold_num
            ELSE - sold_num
        END
    ) AS diff
FROM
    sales_1445
GROUP BY
    sale_date
order by
    sale_date