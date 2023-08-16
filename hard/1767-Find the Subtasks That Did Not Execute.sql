with
    RECURSIVE CTE AS (
        SELECT
            task_id,
            subtasks_count
        FROM
            Tasks
        UNION ALL
        SELECT
            task_id,
            subtasks_count - 1
        FROM
            CTE
        WHERE
            subtasks_count > 1
    )
select
    c.task_id,
    c.subtasks_count as subtask_id
from
    cte c
    left join (
        select
            *
        from
            Tasks t
            join Executed using (task_id)
    ) t on c.task_id = t.task_id
    and c.subtasks_count = t.subtask_id
where
    t.task_id is null
order by
    c.task_id,
    c.subtasks_count