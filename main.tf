
locals {
  app_name_and_env = "${var.app_name}-${data.terraform_remote_state.common.outputs.app_env}"
  name_tag_suffix  = "${var.app_name}-${var.customer}-${data.terraform_remote_state.common.outputs.app_environment}"
}

/*
 * Create cloudwatch log group for app logs
 */
resource "aws_cloudwatch_log_group" "cw_b2_fsbackup" {
  name              = local.app_name_and_env
  retention_in_days = 60

  tags = {
    name = "cloudwatch_log_group-${local.name_tag_suffix}"
  }
}

/*
 * Create required passwords
 */
resource "random_password" "b2_repo_password" {
  length  = 32
  lower   = true
  numeric = true
  special = true
  upper   = true
}
