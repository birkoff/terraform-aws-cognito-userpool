resource "aws_cognito_user_pool_client" "this" {
  name                = var.client_name
  user_pool_id        = aws_cognito_user_pool.this.id
  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH"]
  allowed_oauth_flows_user_pool_client = false
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
  access_token_validity                         = 60
  id_token_validity                             = 60
  refresh_token_validity                        = 30
  auth_session_validity                         = 3
  write_attributes                              = ["email"]
  enable_token_revocation                       = true
  enable_propagate_additional_user_context_data = false
}