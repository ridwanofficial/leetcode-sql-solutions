select
    e.employee_id
from
    Logs l
    right join Employees e using(employee_id)
group by
    e.employee_id,
    needed_hours
having
    floor(
        sum(
            coalesce(
                EXTRACT(
                    EPOCH
                    FROM
                        (out_time :: timestamp - in_time :: timestamp)
                ) / 3600,
                0
            )
        )
    ) < needed_hours