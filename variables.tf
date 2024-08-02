variable "client_name" {
  default = ""
}

variable "cognito_domain" {
  default = ""
}

variable "cognito_user_pool_name" {
  default = ""
}

variable "user_attributes" {
  type = any
  default = {}
}

variable "service_name" {}

variable "dev_users" {
  type = list(object({
    organization = string
    username     = string
    email        = string
  }))
  default = []
}
