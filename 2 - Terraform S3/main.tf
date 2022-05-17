terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.13.0"
    }
  }
}

provider "aws" {
	region = var.region
	access_key = var.my_access_key
	secret_key = var.my_secret_key
}
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "test-bucket" {
  bucket_prefix = var.bucket_prefix
  acl = var.acl

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

    versioning {
    enabled = var.versioning
  }
  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    noncurrent_version_expiration {
      days = 15
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_object" "object" {

  bucket = aws_s3_bucket.test-bucket.id

  key    = "profile"

  acl    = "private"

  source = "hola.txt"

  etag = filemd5("hola.txt")

}




