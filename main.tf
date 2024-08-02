
resource "aws_cognito_user_pool" "this" {
  name = var.cognito_user_pool_name
  #  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length                   = 8
    temporary_password_validity_days = 7
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  # Custom attribute for membership type
  schema {
    attribute_data_type = "String"
    name                = "organization"
    required            = false #  InvalidParameterException: Required custom attributes are not supported currently.
    mutable             = true
    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }
  auto_verified_attributes = ["email"]
  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }
  email_configuration {
   email_sending_account = "COGNITO_DEFAULT"
#     email_sending_account = "DEVELOPER"
#     from_email_address    = var.from_email_address
  }

  lifecycle {
    ignore_changes = [
      schema,
      name
    ]
  }

}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.cognito_domain
  user_pool_id = aws_cognito_user_pool.this.id
}

module "ssm_params" {
  source = "../ssm-parameters-store"
  parameters = {
    "cognito_userpool_arn" = {
      name  = "/platform/cognito_userpool_arn"
      value = aws_cognito_user_pool.this.arn
    }
    "cognito_userpool_id" = {
      name  = "/platform/cognito_userpool_id"
      value = aws_cognito_user_pool.this.id
    }
    "cognito_userpool_client_id" = {
      name  = "/platform/cognito_userpool_client_id"
      value = aws_cognito_user_pool_client.this.id
    }
    "lh_cognito_userpool_arn" = {
      name  = "/${var.service_name}/cognito_userpool_arn"
      value = aws_cognito_user_pool.this.arn
    }
    "lh_cognito_userpool_id" = {
      name  = "/${var.service_name}/cognito_userpool_id"
      value = aws_cognito_user_pool.this.id
    }
    "lh_cognito_userpool_client_id" = {
      name  = "/${var.service_name}/cognito_userpool_client_id"
      value = aws_cognito_user_pool_client.this.id
    }
  }
}
