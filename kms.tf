resource "aws_kms_key" "invoke" {
  count               = var.key_arn == "" ? 1 : 0
  description         = "AFT customization invokation KMS key for ${var.customization_name}"
  enable_key_rotation = "true"
}

resource "aws_kms_alias" "invoke" {
  count         = var.key_arn == "" ? 1 : 0
  name          = "alias/${var.customization_name}-invoke"
  target_key_id = aws_kms_key.invoke[0].arn
}
