resource "aws_kms_key" "invoke" {
  count               = var.key_arn == "" ? 1 : 0
  description         = "AFT customization invokation KMS key"
  enable_key_rotation = "true"
}
