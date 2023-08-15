with cte as (
    select
        candidate_id
    from
        vote
    group by
        candidate_id
    order by
        count(*) desc
    limit
        1
)
select
    name
from
    cte v
    join candidate c on v.candidate_id = c.id