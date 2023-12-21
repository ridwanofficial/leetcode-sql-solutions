with
    cte as (
        select
            platform,
            experiment_name,
            count(*) as num_experiments
        from
            Experiments
        group by
            platform,
            experiment_name
    ),
    cte1 as (
        select distinct
            platform
        from
            Experiments
    ),
    cte2 as (
        select distinct
            experiment_name
        from
            Experiments
    ),
    cte3 as (
        select
            *
        from
            cte1
            join cte2 on true
    )
select
    c1.platform,
    c1.experiment_name,
    coalesce(num_experiments, 0)
from
    cte c
    right join cte3 c1 on c.platform = c1.platform
    and c.experiment_name = c1.experiment_name