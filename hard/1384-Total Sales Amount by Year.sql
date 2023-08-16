WITH RECURSIVE cte AS (
    SELECT
        product_id,
        EXTRACT(
            YEAR
            FROM
                period_start
        ) AS period_start,
        period_end
    FROM
        Sales
    UNION
    SELECT
        product_id,
        period_start + 1 AS period_start,
        period_end
    FROM
        cte c
    Where
        c.period_start < EXTRACT(
            YEAR
            FROM
                period_end
        )
),
cte1 as(
    select
        *
    from
        Sales
        join Product using(product_id)
)
SELECT
    c.product_id,
    product_name,
    c.period_start as report_year,
    case
        when EXTRACT(
            YEAR
            FROM
                c1.period_start
        ) = c.period_start
        and EXTRACT(
            YEAR
            FROM
                c1.period_end
        ) = c.period_start then (c1.period_end - c1.period_start + 1) :: integer
        when EXTRACT(
            YEAR
            FROM
                c1.period_start
        ) = c.period_start then 365 -(
            c1.period_start - MAKE_DATE(c.period_start :: integer, 1, 1)
        ) :: integer
        when EXTRACT(
            YEAR
            FROM
                c1.period_end
        ) = c.period_start then (
            c1.period_end - MAKE_DATE(c.period_start :: integer, 1, 1) + 1
        ) :: integer
        else 365
    end * average_daily_sales as total_amount
FROM
    cte c
    join cte1 c1 using(product_id)
order by
    c.product_id