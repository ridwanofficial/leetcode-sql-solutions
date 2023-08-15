with cte as (
    select
        id,
        login_date
    from
        Logins
    group by
        id,
        login_date
),
cte1 as(
    select
        id,
        EXTRACT(
            DOY
            FROM
                login_date :: date
        ) - row_number() over(
            partition by id
            order by
                EXTRACT(
                    DOY
                    FROM
                        login_date :: date
                )
        ) as diff
    from
        cte
    order by
        id,
        login_date
),
cte2 as (
    select
        distinct id
    from
        cte1
    group by
        id,
        diff
    having
        count(*) >= 5
)
select
    c.id,
    name
from
    cte2 c
    join Accounts using(id)