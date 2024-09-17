resource "aws_codepipeline" "codestar_customization_invoker" {
  name     = "${var.customization_name}-invoker"
  role_arn = aws_iam_role.customization_invoker_codepipeline_role.arn

  artifact_store {
    location = local.codepipeline_bucket_name
    type     = "S3"

    encryption_key {
      id   = local.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = var.customization_name
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = [var.customization_name]

      configuration = {
        ConnectionArn        = local.codestar_connection_arn
        FullRepositoryId     = var.customizations_repo_name
        BranchName           = var.customizations_repo_branch
        DetectChanges        = true
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "customization-invoker"

    action {
      name             = "customization-invoker"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = [var.customization_name]
      output_artifacts = ["${var.customization_name}-output"]
      version          = "1"
      run_order        = "2"
      configuration = {
        ProjectName = aws_codebuild_project.account_customization_invoker_pipeline.name
      }
    }
  }
}
