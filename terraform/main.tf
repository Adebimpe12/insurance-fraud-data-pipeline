provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "fraud_data_lake" {
  name     = "fraud-data-lake"
  location = var.region

  uniform_bucket_level_access = true
  force_destroy               = true
}

resource "google_bigquery_dataset" "fraud_dataset" {
  dataset_id = "fraud_dataset"
  location   = var.region
}
