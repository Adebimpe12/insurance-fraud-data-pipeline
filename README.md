# Financial Fraud Analytics Pipeline

## 🎯 Objective
Build a full end-to-end data pipeline to analyze financial fraud transactions using a large-scale synthetic dataset (~21M rows). This project demonstrates cloud-based data engineering workflows, transformations and dashboard visualization.

## Architecture Overview
Synthetic Fraud Dataset (21M rows) 
-> Kestra Workflow
-> GCS Data Lake
-> BigQuery Data Warehouse
-> dbt Transformations
-> Dashboard (Looker Studio / Streamlit)

---
## 🛠 Tools & Technologies

| Component                     | Tool / Service                                | Description |
|--------------------------------|-----------------------------------------------|
| Cloud Platform                 | GCP (GCS + BigQuery)                          | Storage and data warehouse |
| Workflow Orchestration         | Kestra                                        | ETL orchestration and automation |
| Infrastructure as Code (IaC)  | Terraform                                     | Provision GCP resources |
| Data Transformation            | dbt Core + dbt Cloud                          | Staging, intermediate, and fact models |
| Local Development / Testing    | Docker                                        | Run Kestra + dbt locally |
| Analytics & Dashboard          | Looker Studio or Streamlit                     | Visualize fraud insights |
| Data Processing (Optional)     | Spark, DuckDB (for local testing)             |                                 |
| Dataset                        | Synthetic financial fraud dataset (~21M rows) | Source of transaction data |

---

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

  

## ⚡ Pipeline Steps

1. **Infrastructure (Terraform)**
   - Create GCS bucket (`fraud-data-lake`)
   - Create BigQuery dataset (`fraud_dataset`)

2. **Workflow (Kestra)**
   - Download dataset from Hugging Face
   - Upload dataset to GCS
   - Load dataset into BigQuery table `transactions_raw`

3. **Data Transformation (dbt)**
- Staging Models (stg_transactions.sql) — Standardize raw data
- Intermediate Models (intermediate/int_fraud_transactions.sql) — Fraud flags & metrics
- Fact Models (marts/fct_fraud_summary.sql) — Aggregated data for dashboard:
- Fraud counts by transaction type
- Total transaction amounts
- Fraud rate per type

4. **Dashboard**
   - Tile 1: Bar chart — fraud distribution by transaction type  
   - Tile 2: Line chart — fraud trends over time (by `step`)  



## 🚀 Running the Project

1. **Clone the repo**
   
```bash
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

6. **Build dashboard**

Connect to BigQuery or export dbt models to Looker Studio / Streamlit

Create two tiles as described above

✅ Expected Dashboard
---
|Tile |	Description|
|--------------------------------|-----------------------------------------------|
|Tile 1 |	Fraud by transaction type (categorical distribution)|
|Tile 2 |	Fraud over time (temporal trend)|
---


**📚 Notes**
This project uses a synthetic dataset for privacy reasons but mimics real-world financial fraud.
Designed to showcase full-scale data engineering workflow with 21M rows, cloud storage, data warehouse, transformations and dashboard visualization.
Reproducible using Docker, Terraform, and Kestra.

**References**

Cifer-Fraud-Detection-Dataset-AF (https://huggingface.co/datasets/CiferAI/Cifer-Fraud-Detection-Dataset-AF)
Zoomcamp 2026 DE Capstone Guidelines
