variable "bucket_name" {
  type = string
  description = "The name of the bucket to store application artifacts"
}

variable "db_instance_type" {
  type = string
  description = "The database instance type"
}

variable "location_id" {
  type = string
  description = "The region the database will reside in"
}

variable "project" {
  type = string
  description = "The name of the GCP project"
}

variable "secret_name" {
  type = string
  description = "The name of the secret containing the mysql password"
}

variable "stack_name" {
  type = string
  description = "The name that project resources will use as a base name"
}

variable "username" {
  type = string
  description = "The mysql admin username"
}
