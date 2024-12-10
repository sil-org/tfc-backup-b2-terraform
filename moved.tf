moved {
  from = module.tfc_backup_to_b2.aws_cloudwatch_log_group.cw_b2_fsbackup
  to   = aws_cloudwatch_log_group.cw_b2_fsbackup
}

moved {
  from = module.tfc_backup_to_b2.random_password.b2_repo_password
  to   = random_password.b2_repo_password
}

moved {
  from = module.tfc_backup_to_b2.aws_ecs_task_definition.b2_fstd
  to   = aws_ecs_task_definition.b2_fstd
}

moved {
  from = module.tfc_backup_to_b2.aws_iam_role.ecs_events
  to   = aws_iam_role.ecs_events
}

moved {
  from = module.tfc_backup_to_b2.aws_iam_role_policy.ecs_events_run_task_with_any_role
  to   = aws_iam_role_policy.ecs_events_run_task_with_any_role
}

moved {
  from = module.tfc_backup_to_b2.aws_cloudwatch_event_rule.b2_fsbackup_rule
  to   = aws_cloudwatch_event_rule.b2_fsbackup_rule
}

moved {
  from = module.tfc_backup_to_b2.aws_cloudwatch_event_target.b2_fsbackup
  to   = aws_cloudwatch_event_target.b2_fsbackup
}
