with cte as (
    select
        candidate_id
    from
        vote_574
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
    join candidate_574 c on v.candidate_id = c.id