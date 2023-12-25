select distinct
    title
from
    Content_1495 c
    join TV_Program_1495 t using (content_id)
WHERE
    program_date BETWEEN '2020-06-01' AND '2020-06-30'
    and content_type = 'Movies'
    and kids_content = 'Y'