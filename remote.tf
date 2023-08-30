data "terraform_remote_state" "common" {
  backend = "remote"

  config = {
    organization = var.tf_remote_organization
    workspaces = {
      name = var.tf_remote_common_workspace
    }
  }
}

data "terraform_remote_state" "b2-bucket" {
  backend = "remote"

  config = {
    organization = var.tf_remote_organization
    workspaces = {
      name = "b2-${var.app_name}-${data.terraform_remote_state.common.outputs.app_env}"
    }
  }
}

