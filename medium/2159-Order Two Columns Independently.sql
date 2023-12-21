with
    cte as (
        SELECT
            *,
            row_number() over (
                order by
                    first_col
            ) as f_rnk,
            row_number() over (
                order by
                    second_col desc
            ) as s_rnk
        FROM
            data
    )
select
    f.first_col,
    s.second_col
from
    cte f
    join cte s on f.f_rnk = s.s_rnk