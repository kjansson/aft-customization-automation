resource "aws_iam_role" "customization_invoker_codepipeline_role" {
  name = "${var.customization_name}-invoker-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codepipeline.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codebuild.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}
resource "aws_iam_role_policy" "customization_invoker_codepipeline_policy" {
  name = "${var.customization_name}-invoker-policy"
  role = aws_iam_role.customization_invoker_codepipeline_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:List*",
            "s3:PutObjectAcl",
            "s3:PutObject"
          ],
          "Resource" : [
            "${aws_s3_bucket.codepipeline_bucket[0].arn}",
            "${aws_s3_bucket.codepipeline_bucket[0].arn}/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
          ],
          "Resource" : "arn:${data.aws_partition.current.partition}:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*invoker*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "codecommit:GetBranch",
            "codecommit:GetRepository",
            "codecommit:GetCommit",
            "codecommit:GitPull",
            "codecommit:UploadArchive",
            "codecommit:GetUploadArchiveStatus",
            "codecommit:CancelUploadArchive"
          ],
          "Resource" : "arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*account-request*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kms:Decrypt",
            "kms:Encrypt",
            "kms:GenerateDataKey"
          ],
          "Resource" : [
            "${aws_kms_key.invoke[0].arn}",
            "${data.aws_kms_key.aft.arn}"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "codestar-connections:UseConnection",
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Resource" : "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/account-customization-invoker*",
          "Action" : [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:GetParameter"
          ],
          "Resource" : "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/aft/*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:Scan"
          ],
          "Resource" : "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/aft-request-metadata"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "states:StartExecution"
          ],
          "Resource" : "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:aft-invoke-customizations"
        }
      ]
    }
  )
}
