# terraform.tfvars
project_id             = "spatial-rig-493920-b5"
region                 = "us-central1"
bigquery_dataset       = "fraud_dataset"
raw_data_bucket        = "fraud-data-lake"
processed_data_bucket  = "fraud-processed-data"
airflow_env_name       = "fraud-airflow-env"
# If you are overriding Kestra or Docker settings, you can set them here
# kestra_workflow_path   = "kestra/workflows"
# docker_image           = "gcr.io/my-project/fraud-airflow:latest"
enable_debug           = true
