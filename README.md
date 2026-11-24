# tfc-backup-b2 supporting infrastructure

Creates the generated Restic repo password used by the Terraform Cloud backup to Backblaze B2. The backup
itself now runs in Lightsail, not ECS.

## Variables

* `aws_region` - AWS region to run in, default: `us-east-1`
* `aws_access_key` - AWS access key
* `aws_secret_key` - corresponding AWS secret
* `tags` - map of strings containing tags to be applied, default: `{}`

## Other setup required

* Obtain a Terraform Cloud access token.
* Obtain a Backblaze Application Key.
* Create a Backblaze B2 bucket.
