data "archive_file" "workshop" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "/tmp/${var.application}.zip"
}

resource "google_storage_bucket_object" "workshop" {
  name   = "${var.stack_name}/${var.application}.zip"
  source = data.archive_file.workshop.output_path
  bucket = var.bucket_name
}

resource "google_project_service" "workshop" {
  project = var.project
  service = "appengineflex.googleapis.com"

  disable_dependent_services = false
}

resource "google_app_engine_flexible_app_version" "workshop" {
  project    = var.project
  service    = "${var.stack_name}-${var.application}"
  runtime    = "nodejs"
  version_id = "v1"
  delete_service_on_destroy = true
  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${var.bucket_name}/${google_storage_bucket_object.workshop.name}"
    }
  }

  liveness_check {
    path = "/"
  }

  readiness_check {
    path = "/"
  }

  manual_scaling {
    instances = 1
  }

  beta_settings = {
    cloud_sql_instances = var.connection_name
  }
}
