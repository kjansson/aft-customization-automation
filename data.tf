data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "codepipeline_bucket" {
  count  = var.codepipeline_s3_bucket_name != "" ? 1 : 0
  bucket = var.codepipeline_s3_bucket_name
}

data "aws_kms_key" "aft" {
  key_id = var.aft_kms_key_alias
}