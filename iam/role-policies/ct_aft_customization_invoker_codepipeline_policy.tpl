{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:List*",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket_aft_codepipeline_customizations_bucket_arn}",
        "${aws_s3_bucket_aft_codepipeline_customizations_bucket_arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
        "Resource": "arn:${data_aws_partition_current_partition}:codebuild:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:*invoker*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GetBranch",
        "codecommit:GetRepository",
        "codecommit:GetCommit",
        "codecommit:GitPull",
        "codecommit:UploadArchive",
        "codecommit:GetUploadArchiveStatus",
        "codecommit:CancelUploadArchive"
      ],
      "Resource": "arn:${data_aws_partition_current_partition}:codecommit:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:*account-request*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey"
      ],
      "Resource": [
        "${data_aws_kms_alias_aft_key_target_key_arn}",
        "${data_aws_kms_key_aft_arn}"
      ]
    },
    {
        "Effect": "Allow",
        "Action": "codestar-connections:UseConnection",
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Resource": "arn:${data_aws_partition_current_partition}:logs:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:log-group:/aws/codebuild/account-customization-invoker*",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter"
      ],
      "Resource": "arn:aws:ssm:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:parameter/aft/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:Scan"
      ],
      "Resource": "arn:aws:dynamodb:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:table/aft-request-metadata"
    },
    {
      "Effect": "Allow",
      "Action": [
        "states:StartExecution"
      ],
      "Resource": "arn:aws:states:${data_aws_region_current_name}:${data_aws_caller_identity_current_account_id}:stateMachine:aft-invoke-customizations"
    }
  ]
}

