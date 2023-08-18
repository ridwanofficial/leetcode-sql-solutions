SELECT
    p.post_id,
    CASE
        WHEN COUNT(DISTINCT k.topic_id) = 0 THEN 'Ambiguous!'
        ELSE STRING_AGG(DISTINCT k.topic_id :: TEXT, ',')
    END AS topic
FROM
    Posts p
    left JOIN Keywords k ON CONCAT(' ', LOWER(P.content), ' ') LIKE CONCAT('% ', LOWER(K.word), ' %')
group by
    p.post_id
order by
    p.post_id