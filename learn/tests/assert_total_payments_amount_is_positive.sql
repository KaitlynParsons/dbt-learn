select
    order_id,
    sum(amount) as total_amount
from {{ ref('stg_payments') }}
group by 1
-- cant reference alias 'total_amount' directly in postgres
having not(sum(amount) >= 0)