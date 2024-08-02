resource "aws_cognito_user" "dev" {
  for_each = { for user in var.dev_users : user.username => user }
  user_pool_id = aws_cognito_user_pool.this.id
  username     = each.value.username
  password     = "TEMPORARY_PASSWORD"
  attributes = merge(var.user_attributes, {
    organization = each.value.organization,
    email        = each.value.email
  })
}

resource "aws_cognito_user_in_group" "junctionnet" {
  for_each     = aws_cognito_user.dev
  user_pool_id = aws_cognito_user_pool.this.id
  group_name   = aws_cognito_user_group.admin.name
  username     = each.value.username
}