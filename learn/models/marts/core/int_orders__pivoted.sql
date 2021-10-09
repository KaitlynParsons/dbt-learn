{%- set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}
{%- set column_names = ['payment_method', 'amount'] -%}

with payments as (
    select * from {{ ref('stg_payments')}}
),

pivoted as (
    select 
        order_id,
        {{ pivot_payment_methods(payment_methods, column_names) }}
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted