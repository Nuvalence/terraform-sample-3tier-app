data "google_secret_manager_secret_version" "workshop" {
  provider = google
  project  = var.project
  secret   = var.secret_name
}

resource "google_sql_user" "workshop" {
  name     = var.username
  instance = google_sql_database_instance.workshop.name
  type     = "BUILT_IN"
  password = data.google_secret_manager_secret_version.workshop.secret_data
}

resource "google_sql_database" "workshop" {
  name     = var.stack_name
  instance = google_sql_database_instance.workshop.name
}

resource "google_sql_database_instance" "workshop" {
  name                = "mysql-${var.username}"
  database_version    = "MYSQL_8_0"
  region              = "us-west2"
  deletion_protection = false
  settings {
    tier              = var.db_instance_type
    availability_type = "ZONAL"
  }
}

output "connection_name" {
  value = google_sql_database_instance.workshop.connection_name
}
