resource "aws_cognito_user_group" "platform_admins" {
  name         = "PlatformAdmins"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Platform Administrators"
  precedence   = 32
}
