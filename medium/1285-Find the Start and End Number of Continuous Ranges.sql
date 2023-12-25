with
    cte as (
        select
            log_id as start_id
        from
            logs_1285 l
        group by
            l.log_id
        having
            l.log_id -1 not in (
                select
                    log_id
                from
                    logs_1285
            )
    ),
    cte1 as (
        select
            log_id as end_id
        from
            logs_1285 l
        group by
            l.log_id
        having
            l.log_id + 1 not in (
                select
                    log_id
                from
                    logs_1285
            )
    )
select
    start_id,
    min(end_id) as end_id
from
    cte cS -- startig point
    join cte1 cE -- ending point
    on cS.start_id <= cE.end_id
group by
    start_id