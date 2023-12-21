select distinct
    title
from
    Content
    join TV_Program using (content_id)
WHERE
    Kids_content = 'Y'
    AND EXTRACT(
        YEAR
        FROM
            program_date
    ) = 2020
    AND EXTRACT(
        MONTH
        FROM
            program_date
    ) = 6;