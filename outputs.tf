output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection"
  value       = aws_codestarconnections_connection.github.arn
}

output "codepipeline_bucket_name" {
  description = "Name of the S3 bucket to store the CodePipeline artifacts"
  value       = aws_s3_bucket.codepipeline_bucket.bucket
}

output "codepipeline_bucket_arn" {
  description = "ARN of the S3 bucket to store the CodePipeline artifacts"
  value       = aws_s3_bucket.codepipeline_bucket.arn
}

output "invokation_kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the CodePipeline artifacts"
  value       = aws_kms_key.invoke.arn
}

output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.codestar_customization_invoker.arn
}
