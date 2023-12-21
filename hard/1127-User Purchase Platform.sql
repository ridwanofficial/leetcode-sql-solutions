with
    cte as (
        select
            *,
            count(*) over (
                partition by
                    user_id,
                    spend_date
            ) as total
        from
            Spending
    ),
    cte1 as (
        select
            spend_date,
            sum(
                case
                    when total = 2 then amount
                    else 0
                end
            ) as "boths",
            count(
                distinct case
                    when total = 2 then user_id
                    else null
                end
            ) as bothsUser,
            sum(
                case
                    when total = 1
                    and platform = 'desktop' then amount
                    else 0
                end
            ) as "desktop",
            count(
                distinct case
                    when total = 1
                    and platform = 'desktop' then user_id
                    else null
                end
            ) as desktopUser,
            sum(
                case
                    when total = 1
                    and platform = 'mobile' then amount
                    else 0
                end
            ) as "mobile",
            count(
                distinct case
                    when total = 1
                    and platform = 'mobile' then user_id
                    else null
                end
            ) as mobileuser
        from
            cte
        group by
            spend_date
    )
select
    spend_date,
    'desktop' as platform,
    desktop as total_amount,
    desktopUser as total_users
from
    cte1
union all
select
    spend_date,
    'mobile' as platform,
    mobile as total_amount,
    mobileUser as total_users
from
    cte1
union all
select
    spend_date,
    'both' as platform,
    boths as total_amount,
    bothsUser as total_users
from
    cte1