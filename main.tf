module "tfc_backup_to_b2" {
  source = "github.com/silinternational/terraform-aws-tfc-backup-to-b2?ref=main"

  app_env                 = data.terraform_remote_state.common.outputs.app_env
  app_environment         = data.terraform_remote_state.common.outputs.app_environment
  app_name                = var.app_name
  backup_path             = var.backup_path
  b2_application_key      = data.terraform_remote_state.b2-bucket.outputs.application_key_secret
  b2_application_key_id   = data.terraform_remote_state.b2-bucket.outputs.application_key_id
  b2_fsbackup_args        = var.b2_fsbackup_args
  b2_fsbackup_enabled     = var.b2_fsbackup_enabled
  b2_fsbackup_forget_args = var.b2_fsbackup_forget_args
  b2_fsbackup_host        = var.b2_fsbackup_host
  b2_fsbackup_mode        = var.b2_fsbackup_mode
  b2_fsbackup_schedule    = var.b2_fsbackup_schedule
  cpu                     = var.cpu
  customer                = var.customer
  docker_tag              = var.docker_tag
  ecs_cluster_arn         = data.terraform_remote_state.common.outputs.ecs_cluster_id
  memory                  = var.memory
  repo_string             = "b2:${data.terraform_remote_state.b2-bucket.outputs.b2_bucket_name}:restic"
  tfc_access_token        = var.tfc_access_token
  tfc_organization_name   = var.tfc_organization_name
}
