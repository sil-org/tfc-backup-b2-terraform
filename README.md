# tfc-backup-b2 supporting infrastructure

Creates the AWS and Restic resources (CloudWatch log group and generated Restic
repo password) used by the Terraform Cloud backup to Backblaze B2. The backup
itself now runs in Lightsail, not ECS.

## Variables

* `aws_region` - AWS region to run in, default: `us-east-1`
* `aws_access_key` - AWS access key
* `aws_secret_key` - corresponding AWS secret
* `app_name` - application name, default: `tfcbackup`
* `tf_remote_organization` - 
* `tf_remote_common_workspace` - 
* `tags` - map of strings containing tags to be applied, default: `{}`
* `b2_fsbackup_enabled` - One of `true`, `false`, default: `true`
* `b2_fsbackup_schedule` - When backups should start, default (every day at 05:21 UTC): `21 05 * * ? *`
* `customer` - Customer name, used in AWS tags

## Other setup required

* Obtain a Terraform Cloud access token.
* Obtain a Backblaze Application Key.
* Create a Backblaze B2 bucket.
