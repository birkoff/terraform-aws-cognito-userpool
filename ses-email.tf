#variable "ses_domain_name" {
#  default = ""
#}
#
#data "aws_route53_zone"  "main" {
#  name         = var.ses_domain_name
#  private_zone = false
#}
#
#resource "aws_ses_domain_identity" "main" {
#  domain = var.ses_domain_name
#}
#
#resource "aws_route53_record" "amazonses_verification_record" {
#  zone_id = data.aws_route53_zone.main.zone_id
#  name    = "_amazonses.${var.ses_domain_name}"
#  type    = "TXT"
#  ttl     = "600"
#  records = [aws_ses_domain_identity.main.verification_token]
#
#}
#resource "aws_ses_domain_mail_from" "main" {
#  domain           = aws_ses_domain_identity.main.domain
#  mail_from_domain = "bounce.${aws_ses_domain_identity.main.domain}"
#}
#
# resource "aws_ses_email_identity" "noreply_junctionnet" {
#   email = ""
# }