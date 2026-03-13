
with stg as (
    select *
    from {{ ref('stg_transactions') }}
)

select
    type,
    count(*) as transaction_count,
    sum(amount) as total_amount,
    sum(isFraud) as fraud_count,
    sum(isFraud)/count(*) as fraud_rate
from stg
group by type
