with
    cte as (
        SELECT
            CASE
                WHEN MAX(salary) < 1000 THEN 0
                WHEN MAX(salary) < 10000 THEN 0.24
                ELSE 0.49
            END AS tax,
            company_id
        FROM
            salaries_1468
        GROUP BY
            company_id
    )
select
    s.*,
    s.salary - s.salary * c.tax as after_tax_salary
from
    cte c
    join salaries_1468 s on c.company_id = s.company_id