locals {
  kms_key_arn              = var.key_arn == "" ? aws_kms_key.invoke[0].arn : var.key_arn
  codestar_connection_arn  = var.codestar_connection_arn == "" ? aws_codestarconnections_connection.github[0].arn : var.codestar_connection_arn
  codepipeline_bucket_name = var.codepipeline_s3_bucket_name == "" ? aws_s3_bucket.codepipeline_bucket[0].bucket : var.codepipeline_s3_bucket_name
}
