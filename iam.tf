resource "aws_iam_role" "customization_invoker_codepipeline_role" {
  name               = "ct-aft-customization-invoker-role"
  assume_role_policy = templatefile("${path.module}/iam/trust-policies/invoke.tpl", { none = "none" })
}


resource "aws_iam_role_policy" "customization_invoker_codepipeline_policy" {
  name = "ct-aft-customization-invoker-policy"
  role = aws_iam_role.customization_invoker_codepipeline_role.id

  policy = templatefile("${path.module}/iam/role-policies/ct_aft_customization_invoker_codepipeline_policy.tpl", {
    aws_s3_bucket_aft_codepipeline_customizations_bucket_arn = var.codepipeline_s3_bucket_name == "" ? aws_s3_bucket.codepipeline_bucket[0].arn : data.aws_s3_bucket.codepipeline_bucket[0].arn
    data_aws_partition_current_partition                     = data.aws_partition.current.partition
    data_aws_region_current_name                             = data.aws_region.current.name
    data_aws_caller_identity_current_account_id              = data.aws_caller_identity.current.account_id
    data_aws_kms_alias_aft_key_target_key_arn                = var.key_arn == "" ? aws_kms_key.invoke[0].arn : var.key_arn
    data_aws_kms_key_aft_arn                                 = data.aws_kms_key.aft.arn
  })
}
