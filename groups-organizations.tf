#############################################################x
###  Groups
#############################################################
resource "aws_cognito_user_group" "admin" {
  name         = "Admin"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Administrator"
  precedence   = 42
}

resource "aws_cognito_user_group" "member" {
  name         = "Member"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Member"
  precedence   = 52
}