{%- macro pivot_payment_methods(payment_methods, column_names) -%}
    {% for payment_method in payment_methods -%}
        sum(case when {{column_names[0]}} = '{{payment_method}}' then {{column_names[1]}} else 0 end) as {{payment_method}}_amount
        {%- if not loop.last -%}
            ,
        {%- endif %}
    {% endfor -%}
{%- endmacro -%}