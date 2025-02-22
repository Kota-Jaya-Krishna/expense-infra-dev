terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

backend "s3" {
  bucket = "remote-state-tf1-dev"
  key = "expense-dev-web-alb"
  region = "us-east-1"
  dynamodb_table = "terraform-state-locking"
}
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}