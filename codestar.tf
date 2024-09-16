resource "aws_codestarconnections_connection" "github" {
  count         = var.codestar_connection_arn == "" ? 1 : 0
  name          = "${var.customization_name}-invoke-gh"
  provider_type = "GitHub"
}
