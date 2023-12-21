select
    extra,
    Count(distinct post_id)
from
    Actions_1113
where
    action_date = '2019-07-04'
    and action = 'report'
group by
    extra