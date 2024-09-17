resource "random_string" "codepipeline_bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  count  = var.codepipeline_s3_bucket_name == "" ? 1 : 0
  bucket = "${var.customization_name}-codepipeline-bucket-${random_string.codepipeline_bucket_suffix.id}"
}

resource "aws_s3_bucket_public_access_block" "aft-codepipeline-customizations-block-public-access" {
  count  = var.codepipeline_s3_bucket_name == "" ? 1 : 0
  bucket = aws_s3_bucket.codepipeline_bucket[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "codepipeline_bucket" {
  count  = var.codepipeline_s3_bucket_name == "" ? 1 : 0
  bucket = aws_s3_bucket.codepipeline_bucket[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aft-codepipeline-customizations-bucket-encryption" {
  count  = var.codepipeline_s3_bucket_name == "" ? 1 : 0
  bucket = aws_s3_bucket.codepipeline_bucket[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}
