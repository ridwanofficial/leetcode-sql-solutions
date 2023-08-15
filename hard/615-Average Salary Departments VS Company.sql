with cte as(
    select
        TO_CHAR(DATE_TRUNC('month', pay_date), 'YYYY-MM') AS pay_month,
        department_id,
        amount
    from
        salary s
        join employee e on s.employee_id = e.employee_id
),
cte1 as(
    SELECT
        *,
        Round(avg(amount) over(partition by pay_month), 2) as company_avg_by_month,
        round(
            avg(amount) over(partition by pay_month, department_id),
            2
        ) as dep_avg_by_month
    FROM
        cte
)
select
    pay_month,
    department_id,
    CASE
        WHEN min(company_avg_by_month) = min(dep_avg_by_month) THEN 'same'
        WHEN min(company_avg_by_month) > min(dep_avg_by_month) THEN 'lower'
        ELSE 'higher'
    END as comparison
from
    cte1
group by
    pay_month,
    department_id
order by
    department_id