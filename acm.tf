resource "aws_acm_certificate" "cert" {
    domain_name       = var.acm_domain
    validation_method = "DNS"

    tags = {
        Environment = var.ENV_NAME
    }

    lifecycle {
        create_before_destroy = true
    }
}