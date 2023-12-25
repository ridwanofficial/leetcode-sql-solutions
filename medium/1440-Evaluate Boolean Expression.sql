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
        WHEN operator = '>'
        AND left_val > right_val THEN 'true'
        WHEN operator = '<'
        and left_val < right_val THEN 'true'
        WHEN operator = '='
        AND left_val = right_val THEN 'true'
        ELSE 'false'
    END AS value
FROM
    cte;

---alternative  
SELECT
    e.left_operand,
    e.operator,
    e.right_operand,
    (
        CASE
            WHEN e.operator = '<'
            AND v1.value < v2.value THEN 'true'
            WHEN e.operator = '='
            AND v1.value = v2.value THEN 'true'
            WHEN e.operator = '>'
            AND v1.value > v2.value THEN 'true'
            ELSE 'false'
        END
    ) AS value
FROM
    Expressions e
    JOIN Variables v1 ON e.left_operand = v1.name
    JOIN Variables v2 ON e.right_operand = v2.name