resource "google_cloud_run_v2_service" "default" {
  name                = var.name
  location            = var.location
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      # ここではリソースを作成するのみで、以後のデプロイは GitHub Actions で行う
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }

  # リソース作成後はすべての変更を無視する
  lifecycle {
    ignore_changes = [template, traffic]
  }
}