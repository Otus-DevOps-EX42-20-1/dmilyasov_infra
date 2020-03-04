module "storage-bucket" {
  source   = "SweetOps/storage-bucket/google"
  version  = "0.3.0"
  name     = "bucket-test04032202001"
  location = var.region

}

output storage-bucket_url {
  value = module.storage-bucket.url
}

provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}
