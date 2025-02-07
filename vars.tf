variable "aws_region" {
  description = "AWS region to run in (e.g. us-east-1)"
  default     = "us-east-1"
}

variable "aws_access_key" {
  default = null
}

variable "aws_secret_key" {
  default = null
}

variable "app_name" {
  default = "tfcbackup"
}

variable "cpu" {
  default = 200
}

variable "memory" {
  default = 128
}

variable "tf_remote_organization" {
}

variable "tf_remote_common_workspace" {
}

variable "tfc_access_token" {
}

variable "tfc_organization_name" {
}

variable "backup_path" {
  default = "/tmp/tfcbackup"
}

variable "docker_tag" {
  default = "latest"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "b2_fsbackup_mode" {
  default     = "backup"
  description = "valid values: init, backup"
}

variable "b2_account_id" {
  default     = null
  description = "Backblaze Application Key ID"
}

variable "b2_account_key" {
  default     = null
  description = "Backblaze Application Key (the secret)"
}

variable "b2_fsbackup_args" {
  default = ""
}

# e.g., "--keep-daily 7 --keep-weekly 5  --keep-monthly 3"
variable "b2_fsbackup_forget_args" {
  default = "--keep-daily 45"
}

variable "b2_fsbackup_host" {
  default = "restic_host"
}

variable "b2_fsbackup_enabled" {
  default = true
}

variable "b2_fsbackup_schedule" {
  default = "21 05 * * ? *" # Every day at 05:21 UTC
}

variable "customer" {
  description = "Customer name, used in AWS tags"
  type        = string
}

variable "tf_backup_sentry_dsn" {
  description = "Sentry logs Data Source Name (i.e. where to send the data)"
  type        = string
  default     = ""
}
