{{ config(
    materialized='table',
    partition_by={
        "field": "event_date",
        "data_type": "date"
    },
    cluster_by=["type"]
) }}

SELECT
    event_date,
    step,
    type,
    total_transactions,
    total_amount,
    fraud_count,
    flagged_fraud_count,

    SAFE_DIVIDE(fraud_count, total_transactions) AS fraud_rate,

    avg_amount,
    max_amount,

    debit_anomalies,
    credit_anomalies,

    CASE 
        WHEN SAFE_DIVIDE(fraud_count, total_transactions) > 0.05 THEN 'HIGH RISK'
        WHEN SAFE_DIVIDE(fraud_count, total_transactions) > 0.01 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_level,

    CASE 
        WHEN total_amount > 200000 OR fraud_count > 0 THEN 1
        ELSE 0
    END AS alert_flag

FROM {{ ref('int_fraud_transactions') }}