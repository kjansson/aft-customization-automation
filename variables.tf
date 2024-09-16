variable "customization_name" {
  type = string
}

variable "codepipeline_s3_bucket_name" {
  type = string
  default = ""
}
variable "key_arn" {
  type = string
  default = ""
}

variable "customizations_repo_name" {
  type = string
}

variable "customizations_repo_branch" {
  type = string
}

variable "global_codebuild_timeout" {
  type = number
  default = 300
}

variable "aft_kms_key_alias" {
  type = string
  default = "alias/aft"
}