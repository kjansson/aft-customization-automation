data "local_file" "account_request_buildspec" {
  filename = "${path.module}/buildspecs/ct-aft-customization-invoker.yml"
}

resource "aws_codebuild_project" "account_customization_invoker_pipeline" {
  name           = "${var.customization_name}-invoker"
  description    = "Deploys account customizations"
  build_timeout  = tostring(var.global_codebuild_timeout)
  service_role   = aws_iam_role.customization_invoker_codepipeline_role.arn
  encryption_key = local.kms_key_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_PARTITION"
      value = data.aws_partition.current.partition
      type  = "PLAINTEXT"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.account-customization-invoker.name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.account_request_buildspec.content
  }

  lifecycle {
    ignore_changes = [project_visibility]
  }

}
resource "aws_cloudwatch_log_group" "account-customization-invoker" {
  name              = "/aws/codebuild/${var.customization_name}-invoker"
  retention_in_days = var.log_retention_days
}
