# Insurance Fraud Analytics Data Pipeline

## 🎯 Objective
Build a full end-to-end data pipeline to analyze insurance/financial fraud transactions using a large-scale synthetic dataset (~21M rows). This project demonstrates cloud-based data engineering workflows, transformations, and dashboard visualization.

## Architecture
Synthetic Fraud Dataset (21M rows) 
-> Kestra Workflow
-> GCS Data Lake
-> BigQuery Data Warehouse
-> dbt Transformations
-> Dashboard (Looker Studio / Streamlit)

## Tools
- Docker
- Terraform
- Kestra
- GCP (GCS + BigQuery)
- dbt Core
- Dashboard (Looker Studio / Streamlit)

**Workflow Summary:**
1. Download dataset from Hugging Face automatically via Kestra.
2. Upload dataset to GCS (data lake).
3. Load raw data into BigQuery tables.
4. Transform and aggregate data using dbt (staging + fact models).
5. Visualize insights via dashboard with two key tiles:
   - Fraud distribution by transaction type
   - Fraud trends over time


## Steps
1. Run Terraform to create GCP infra.
2. Launch Docker (Kestra + dbt) locally.
3. Execute Kestra workflow to:
   - Download dataset
   - Upload to GCS
   - Load into BigQuery
4. Run dbt transformations.
5. Build a dashboard with 2 tiles:
   - Fraud by transaction type
   - Fraud over time


Dashboard description: two tiles
Tile 1: Fraud by transaction type
Tile 2: Fraud over time

Dataset source & info: synthetic Cifer 21M dataset (https://huggingface.co/datasets/CiferAI/Cifer-Fraud-Detection-Dataset-AF)
- Type: Synthetic but modeled on real banking/fintech fraud transactions  
- Size: ~21,000,000 rows  
- Key columns:
  - `step` — time step
  - `type` — transaction type (PAYMENT, TRANSFER, CASH_OUT, etc.)
  - `amount` — transaction value
  - `nameOrig`, `nameDest` — anonymized sender/receiver IDs
  - `oldbalanceOrg`, `newbalanceOrig`, `oldbalanceDest`, `newbalanceDest`
  - `isFraud` — fraud label
  - `isFlaggedFraud` — flagged transactions

  
---
## 🛠 Tools & Technologies

| Component                     | Tool / Service                                |
|--------------------------------|-----------------------------------------------|
| Cloud Platform                 | GCP (GCS + BigQuery)                          |
| Workflow Orchestration         | Kestra                                        |
| Infrastructure as Code (IaC)  | Terraform                                     |
| Data Transformation            | dbt Core + dbt Cloud                          |
| Local Development / Testing    | Docker                                        |
| Analytics & Dashboard          | Looker Studio or Streamlit                     |
| Data Processing (Optional)     | Spark, DuckDB (for local testing)             |
| Dataset                        | Synthetic financial fraud dataset (~21M rows) |

---

## ⚡ Pipeline Steps

1. **Infrastructure (Terraform)**
   - Create GCS bucket (`fraud-data-lake`)
   - Create BigQuery dataset (`fraud_dataset`)

2. **Workflow (Kestra)**
   - Download dataset from Hugging Face
   - Upload dataset to GCS
   - Load dataset into BigQuery table `transactions_raw`

3. **Data Transformation (dbt)**
   - `stg_transactions` — staging table
   - `fct_fraud_summary` — aggregate metrics for dashboard:
     - Fraud counts by transaction type
     - Total transaction amounts
     - Fraud rate per type

4. **Dashboard**
   - Tile 1: Bar chart — fraud distribution by transaction type  
   - Tile 2: Line chart — fraud over time (by `step`)  



## 🚀 Running the Project

1. **Clone the repo**
   
```bash
git clone https://github.com/<your-username>/insurance-fraud-data-pipeline.git
cd insurance-fraud-data-pipeline
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

This downloads the dataset, uploads to GCS, and loads into BigQuery.

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
Tile	Description
Tile 1	Fraud by transaction type (categorical distribution)
Tile 2	Fraud over time (temporal trend)
---


**📚 Notes**
This project uses a synthetic dataset for privacy reasons but mimics real-world financial fraud.
Designed to showcase full-scale data engineering workflow with 21M rows, cloud storage, data warehouse, transformations, and dashboard visualization.
Reproducible using Docker, Terraform, and Kestra.

**References**

Cifer-Fraud-Detection-Dataset-AF (Hugging Face)
Zoomcamp 2023 DE Capstone Guidelines
