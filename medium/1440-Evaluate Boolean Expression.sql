with
    cte as (
        select
            *,
            (
                select
                    value
                from
                    Variables_1440
                where
                    name = left_operand
            ) as left_val,
            (
                select
                    value
                from
                    Variables_1440
                where
                    name = right_operand
            ) as right_val
        from
            Expressions_1440
    )
SELECT
    left_operand,
    operator,
    right_operand,
    CASE
        WHEN operator = '>' THEN CASE
            WHEN left_val > right_val THEN 'true'
            ELSE 'false'
        END
        WHEN operator = '<' THEN CASE
            WHEN left_val < right_val THEN 'true'
            ELSE 'false'
        END
        WHEN operator = '=' THEN CASE
            WHEN left_val = right_val THEN 'true'
            ELSE 'false'
        END
        ELSE 'false'
    END AS value
FROM
    cte;