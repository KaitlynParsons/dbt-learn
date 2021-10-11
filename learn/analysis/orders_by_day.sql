with orders as (
    select * from {{ ref('stg_orders') }}
),

daily as (
    select 
        order_date,
        count(*) as num_orders,
        {% for order_status in ['returned', 'completed', 'return_pending', 'shipped', 'placed'] %}
            sum(case when status = '{{order_status}}' then 1 else 0 end) as {{order_status}}_total {{',' if not loop.last}}
        {% endfor %}
    from orders
    group by 1
),

compared as (
    select *,
        lag(num_orders) over (order by order_date) as previous_day_orders
    from daily
)

select * from compared