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
