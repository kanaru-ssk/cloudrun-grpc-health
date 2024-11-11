provider "google" {
  project = var.project_id
  region  = var.region
}

module "cloud-run-service" {
  source = "../../modules/cloud_run_service"

  name        = "health-check"
  location    = var.region
}