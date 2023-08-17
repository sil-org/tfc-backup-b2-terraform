output "bkup_cron_schedule" {
  value = var.b2_fsbackup_enabled ? var.b2_fsbackup_schedule : ""
}
