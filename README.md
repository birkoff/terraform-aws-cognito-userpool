# terraform-aws-cognito-userpool

Terragrunt module to create a Cognito User Pool
```hcl

include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  env      = local.env_vars.locals.aws_env
}

terraform {
  source = "../../../modules//cognito-userpool"
}

inputs = {
  cognito_domain         = "domain"
  ses_domain_name        = "domain.com"
  client_name            = "domain-client"
  service_name            = "domain-service"
  from_email_address      = "noreply@domain.com"
  cognito_user_pool_name = "domain-user-pool"

  user_attributes = {
    zoneinfo       = "CST"
    locale         = "en_US"
    email          = "foo@bar.com"
    email_verified = true
  }

  dev_users = [
    {
      organization = "One"
      username     = "hector"
      email        = "foo@bar.com"
    },
    {
      organization = "Two"
      username     = "victor"
      email        = "foo@bar.com"
    },
  ]
}
```