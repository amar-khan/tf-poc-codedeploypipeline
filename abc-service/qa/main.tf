provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "project-tf-store-abc"
    key    = "tf-states/qa/"
    region = "us-east-1"
  }
}