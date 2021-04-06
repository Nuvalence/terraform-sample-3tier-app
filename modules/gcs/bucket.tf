variable "bucket_name" {}

resource "google_storage_bucket" "workshop" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true
}

output "bucket_name" {
  value = google_storage_bucket.workshop.name
}
