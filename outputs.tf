output "b2_restic_repo_password" {
  description = "The (generated) password for your Restic repo on Backblaze"
  sensitive   = true
  value       = random_password.b2_repo_password.result
}
