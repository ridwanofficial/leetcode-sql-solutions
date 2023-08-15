SELECT
    item_category as Category,
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 1 then a.quantity
            else 0
        end
    ) as "MONDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 2 then a.quantity
            else 0
        end
    ) as "TUESDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 3 then a.quantity
            else 0
        end
    ) as "WEDNESDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 4 then a.quantity
            else 0
        end
    ) as "THURSDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 5 then a.quantity
            else 0
        end
    ) as "FRIDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 6 then a.quantity
            else 0
        end
    ) as "SATURDAY",
    sum(
        case
            when EXTRACT(
                DOW
                FROM
                    a.order_date
            ) = 0 then a.quantity
            else 0
        end
    ) as "SUNDAY"
FROM
    items i
    JOIN Orders a ON i.item_id :: integer = a.item_id
GROUP BY
    i.item_category
order BY
    i.item_category