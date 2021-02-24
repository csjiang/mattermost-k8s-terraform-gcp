terraform {
  backend "gcs" {
    bucket  = "csjiang-mattermost-tf-state"
    prefix  = "terraform/state"
  }
}