##  Terraform 
terraform {
  required_version = ">= 0.14.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.59"
    }
  }
  backend "gcs" {
    bucket = "EXAMPLE_BUCKET"
    prefix = "EXAMPLE_PREFIX"
  }
}

provider "google" {
  region  = "us-east1"
  project = "EXAMPLE_PROJECT"
}

module "gcpinfo" {
  source = "git::https://gitlab.com/aardvarq/gcpinfo.git"
}

module "mysql" {
  source        = "./modules/mysql"
  stack_name    = var.stack_name
  instance_type = var.db_instance_type
  project       = var.project
  secret_name   = var.secret_name
  username      = var.username
}

module "app_bucket" {
  source      = "./modules/gcs"
  bucket_name = var.bucket_name
}

module "api" {
  source          = "./modules/app_engine"
  application     = "api"
  bucket_name     = module.app_bucket.bucket_name
  connection_name = module.mysql.connection_name
  location_id     = var.location_id
  project         = var.project
  source_dir      = "./node/api"
  stack_name      = var.stack_name
}

module "client" {
  source          = "./modules/app_engine"
  application     = "client"
  bucket_name     = module.app_bucket.bucket_name
  connection_name = module.mysql.connection_name
  location_id     = var.location_id
  project         = var.project
  source_dir      = "./node/client"
  stack_name      = var.stack_name
}
