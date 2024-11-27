output "bkup_cron_schedule" {
  value = var.b2_fsbackup_enabled ? var.b2_fsbackup_schedule : ""
}

output "b2_restic_repo_password" {
  description = "The (generated) password for your Restic repo on Backblaze"
  sensitive   = true
  value       = random_password.b2_repo_password.result
}
