locals {
  app_name_and_env = "${var.app_name}-${data.terraform_remote_state.common.outputs.app_env}"
  app_env          = data.terraform_remote_state.common.outputs.app_env
  app_environment  = data.terraform_remote_state.common.outputs.app_environment
  name_tag_suffix  = "${var.app_name}-${var.customer}-${local.app_environment}"
}

/*
 * Create cloudwatch log group for app logs
 */
resource "aws_cloudwatch_log_group" "cw_b2_fsbackup" {
  name              = local.app_name_and_env
  retention_in_days = 14

  tags = {
    name = "cloudwatch_log_group-${local.name_tag_suffix}"
  }
}

/*
 * Create required passwords
 */
resource "random_id" "b2_repo_password" {
  byte_length = 16
}

/*
 * Create task definition for file system backup
 */
locals {
  task_def = templatefile("${path.module}/task-definition-b2-backup.tftpl",
    {
      atlas_token           = var.tfc_access_token
      b2_account_id         = data.terraform_remote_state.b2-bucket.outputs.application_key_id
      b2_account_key        = data.terraform_remote_state.b2-bucket.outputs.application_key_secret
      fsbackup_mode         = var.b2_fsbackup_mode
      tfc_organization_name = var.tfc_organization_name
      backup_args           = var.b2_fsbackup_args
      forget_args           = var.b2_fsbackup_forget_args
      restic_host           = var.b2_fsbackup_host
      repo_pw               = random_id.b2_repo_password.hex
      repo_string           = var.b2_fsbackup_repo
      restic_tag            = "${local.app_name_and_env}-b2-fs-backup"
      source_path           = var.backup_path
      cpu                   = var.cpu
      memory                = var.memory
      docker_image          = "silintl/tfc-backup-b2"
      docker_tag            = var.docker_tag
      aws_region            = var.aws_region
      aws_access_key_id     = var.aws_access_key
      aws_secret_access_key = var.aws_secret_key
      app_name              = var.app_name
      cw_log_group          = aws_cloudwatch_log_group.cw_b2_fsbackup.name
      cw_stream_prefix      = "B2_FS_backup-${local.app_name_and_env}"
    }
  )
}

resource "aws_ecs_task_definition" "b2_fstd" {
  family                = "${var.app_name}-b2-fsbackup-${local.app_env}"
  container_definitions = local.task_def
  task_role_arn         = ""
  network_mode          = "bridge"
}

/*
 * Create role for scheduled running of backup task definitions.
 */
resource "aws_iam_role" "ecs_events" {
  name = "ecs_events-${local.app_name_and_env}"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC

}

/*
 * CloudWatch configuration to start file system backup.
 */
resource "aws_cloudwatch_event_rule" "b2_fsbackup_rule" {
  name        = "b2_fsbackup-${local.app_name_and_env}"
  description = "Start B2 file system backup on cron schedule"

  schedule_expression = "cron(${var.b2_fsbackup_schedule})"
  is_enabled          = var.b2_fsbackup_enabled

  tags = {
    app_name = var.app_name
    app_env  = local.app_env
  }
}

resource "aws_cloudwatch_event_target" "b2_fsbackup" {
  target_id = "run-b2-fsbackup-${local.app_name_and_env}"
  rule      = aws_cloudwatch_event_rule.b2_fsbackup_rule.name
  arn       = data.terraform_remote_state.common.outputs.ecs_cluster_id
  role_arn  = aws_iam_role.ecs_events.arn

  ecs_target {
    task_count          = 1
    launch_type         = "EC2"
    task_definition_arn = aws_ecs_task_definition.b2_fstd.arn
  }
}
