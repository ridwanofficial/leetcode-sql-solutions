select
    country_name,
    CASE
        WHEN avg(weather_state) <= 15 THEN 'Cold'
        WHEN avg(weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END as weather_type
from
    weather_1294
    join Countries_1294 using (country_id)
where
    day BETWEEN '2019-11-01' AND '2019-11-30'
group by
    country_name