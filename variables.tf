variable "customization_name" {
  description = "The name of the customization"
  type        = string
}

variable "codepipeline_s3_bucket_name" {
  description = "The name of the S3 bucket to store the CodePipeline artifacts. If not given one will be created."
  type        = string
  default     = ""
}
variable "key_arn" {
  description = "The ARN of the KMS key to use for encrypting the CodePipeline artifacts. If not given one will be created."
  type        = string
  default     = ""
}

variable "customizations_repo_name" {
  description = "The name of the repository containing the customizations"
  type        = string
}

variable "customizations_repo_branch" {
  description = "The branch of the repository containing the customizations"
  type        = string
}

variable "global_codebuild_timeout" {
  description = "The timeout in minutes for the CodeBuild project"
  type        = number
  default     = 300
}

variable "aft_kms_key_alias" {
  description = "The alias of the KMS key used by AFT."
  type        = string
  default     = "alias/aft"
}

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection"
  type        = string
  default     = ""
}
