terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["./keys"]
  profile                  = "default"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
