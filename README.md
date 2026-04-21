# Financial Fraud Analytics Pipeline

## Objective
Build a full end-to-end data pipeline to analyze financial fraud transactions using a large-scale synthetic dataset (~21M rows). This project demonstrates cloud-based data engineering workflows, transformations and dashboard visualization.

## Architecture Overview
Dataset (21M rows)
   ↓
Kestra (Orchestration)
   ↓
GCS (Data Lake)
   ↓
BigQuery (Warehouse)
   ↓
dbt (Transformations)
   ↓
Dashboard (Looker Studio)
   ↓
Real-time Pipeline (Pub/Sub → BigQuery)
---
## Tools & Technologies

Component	Tool	Description
Cloud	GCP (GCS + BigQuery)	Storage + warehouse
Orchestration	Kestra	Batch pipeline automation
IaC	Terraform	Infrastructure provisioning
Transformations	dbt	Data modeling
Streaming	GCP Pub/Sub	Real-time ingestion
Dashboard	Looker Studio / Streamlit	Visualization
Processing	DuckDB	Local testing
Containerization	Docker	Local environment

## Features
   -Anomalies in Debit and Credit Payment.png
   -Average Amount of Fraud by Transaction Type.png
   -Total Amount.png

## Key Insights
   CASH_OUT transactions show the highest fraud concentration
   Fraud likelihood increases with transaction anomalies
   High-value transactions are more likely to trigger alerts

## Business Value:
This dashboard helps financial institutions:
- Detect suspicious transaction patterns
- Monitor fraud trends in real time
- Prioritize high-risk transaction types
- Trigger alerts for further investigation

**Dataset Details**
Dataset source: https://huggingface.co/datasets/CiferAI/Cifer-Fraud-Detection-Dataset-AF
- Type: Synthetic Cifer dataset but modeled on real banking/fintech fraud transactions  
- Size: ~21,000,000 rows  
- Columns:
  - `step` — time step
  - `type` — transaction type (PAYMENT, TRANSFER, CASH_OUT, etc.)
  - `amount` — transaction value
  - `nameOrig`, `nameDest` — anonymized sender/receiver IDs
  - `oldbalanceOrg`, `newbalanceOrig`, `oldbalanceDest`, `newbalanceDest`
  - `isFraud` — fraud label
  - `isFlaggedFraud` — flagged transactions

  

## Pipeline Steps

1. **Infrastructure (Terraform)**
   - Create GCS bucket (`fraud-data-lake`)
   - Create BigQuery BigQuery datasets:

      -fraud_dataset
      -fraud_dataset_stg
      -fraud_dataset_int
      -fraud_dataset_marts

2. **Workflow (Kestra)**
   - Download dataset from Hugging Face
   - Upload dataset to GCS
   - Load dataset into BigQuery table `transactions_raw`

3. **Data Transformation (dbt)**
   -Staging
      -stg_transactions
      -Cleans and standardizes raw data
   -Intermediate
      -int_fraud_transactions
      -Aggregates transactions
      -Creates fraud metrics
   -Marts
      -fct_fraud_summary
      -Final analytical table

4. **Streaming Pipeline**

   A real-time streaming pipeline was implemented using Pub/Sub.
   A Python producer simulates transactions and publishes messages.
   A consumer subscribes and streams data into BigQuery.


### How to run
```
cd streaming
docker-compose up -d

# start consumer
python consumer.py

# start producer
python producer.py
```

## Data Warehouse Optimization

The BigQuery tables are optimized using:

- Partitioning by `step` (time-based transaction progression)
- Clustering by `type` (transaction category)

This improves query performance for fraud analysis and reduces query cost.


##  Running the Project

1. **Clone the repo**
   
```
git clone https://github.com/<your-username>/fraud-data-pipeline.git
cd fraud-data-pipeline
```

2. **Run Terraform**
   
```
cd terraform
terraform init
terraform apply
```

3. **Launch Docker (Kestra + dbt)**

```
docker-compose up -d
```

4. **Run Kestra workflow**

This downloads the dataset, uploads to GCS and loads into BigQuery.

5. **Run dbt transformations**

```
cd dbt
dbt run
```
6. **Run streaming**
```
cd streaming
python consumer.py
python producer.py
```

7. **Build dashboard**

Connect to BigQuery or export dbt models to Looker Studio



**Notes**
This project uses a synthetic dataset for privacy reasons but mimics real-world financial fraud.
Designed to showcase full-scale data engineering workflow with 21M rows, cloud storage, data warehouse, transformations and dashboard visualization.
Reproducible using Docker, Terraform, and Kestra.

**References**

Cifer-Fraud-Detection-Dataset-AF (https://huggingface.co/datasets/CiferAI/Cifer-Fraud-Detection-Dataset-AF)
Zoomcamp 2026 DE Capstone Guidelines
