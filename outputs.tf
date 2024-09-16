output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection"
  value       = aws_codestarconnections_connection.github[0].arn
}

output "codepipeline_bucket_name" {
  description = "Name of the S3 bucket to store the CodePipeline artifacts"
  value       = aws_s3_bucket.codepipeline_bucket[0].bucket
}

output "codepipeline_bucket_arn" {
  description = "ARN of the S3 bucket to store the CodePipeline artifacts"
  value       = aws_s3_bucket.codepipeline_bucket[0].arn
}

output "invokation_kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the CodePipeline artifacts"
  value       = aws_kms_key.invoke[0].arn
}

output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.codestar_customization_invoker.arn
}
