SELECT
    CAST(step AS INT64) AS step,

    -- ✅ ADD THIS (CRITICAL)
    DATE(TIMESTAMP_SECONDS(step)) AS event_date,

    type,
    CAST(amount AS FLOAT64) AS amount,
    nameOrig,
    nameDest,

    CAST(oldbalanceOrg AS FLOAT64) AS oldbalance_org,
    CAST(newbalanceOrig AS FLOAT64) AS newbalance_org,
    CAST(oldbalanceDest AS FLOAT64) AS oldbalance_dest,
    CAST(newbalanceDest AS FLOAT64) AS newbalance_dest,

    CAST(isFraud AS INT64) AS is_fraud,
    CAST(isFlaggedFraud AS INT64) AS is_flagged_fraud,

    -- derived values
    (oldbalanceOrg - newbalanceOrig) AS expected_debit,
    (newbalanceDest - oldbalanceDest) AS expected_credit,

    CASE 
        WHEN (oldbalanceOrg - newbalanceOrig) != amount THEN 1 
        ELSE 0 
    END AS debit_mismatch_flag,

    CASE 
        WHEN (newbalanceDest - oldbalanceDest) != amount THEN 1 
        ELSE 0 
    END AS credit_mismatch_flag

FROM {{ source('fraud_dataset', 'transactions_raw') }}