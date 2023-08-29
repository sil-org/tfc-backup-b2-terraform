# Run tfc-backup-b2 via schedule in existing AWS ECS Cluster

Creates the infrastructure on AWS to run a backup of the Terraform Cloud
data on a scheduled basis.

## Variables

* `aws_region` - AWS region to run in, default: `us-east-1`
* `aws_access_key` - AWS access key
* `aws_secret_key` - corresponding AWS secret
* `app_env` - application environment, default: `prod`
* `app_name` - application name, default: `tfcbackup`
* `cpu` - amount of CPU to allocate to the container, default: `200`
* `memory` - amount of memory to allocate (MB), default: `128`
* `tf_remote_common_organization` - 
* `tf_remote_common_workspace` - 
* `tfc_access_token` - Terraform Cloud access token
* `tfc_organization_name` - Terraform Cloud organization name
* `backup_path` - path in container to be backed up, default: `/tmp/tfcbackup`
* `docker_tag` - Docker image tag, default: `latest`
* `tags` - map of strings containing tags to be applied, default: `{}`
* `b2_fsbackup_mode` - One of `init`, `backup`, default: `backup`
* `b2_account_id` - Backblaze Application Key ID (`keyID`)
* `b2_account_key` - Backblaze Application Key secret (`applicationKey`)
* `b2_fsbackup_args` - Additional arguments to the `restic backup` command, default: ""
* `b2_fsbackup_forget_args` - Arguments to the `restic forget` command, default: `--keep-daily 45`
* `repo_string` - Restic repository name, e.g., `b2:bucketname:directory`
* `b2_fsbackup_host` - Hostname to use in Restic backups, default: `restic_host`
* `b2_fsbackup_enabled` - One of `true`, `false`, default: `true`
* `b2_fsbackup_schedule` - When backups should start, default (every day at 05:21 UTC): `21 05 * * ? *`
* `customer` - Customer name, used in AWS tags

## Other setup required

* Obtain a Terraform Cloud access token.
* Obtain a Backblaze Application Key.
* Create a Backblaze B2 bucket.
