resource "aws_codestarconnections_connection" "github" {
  # count         = local.vcs.is_github ? 1 : 0
  name          = "${var.customization_name}-invoke-gh"
  provider_type = "GitHub"
}
# TODO, make this configurable from variable to use existing connection