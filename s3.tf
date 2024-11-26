resource "aws_s3_bucket" "tfstate" {
    bucket = "${var.ENV_NAME}-state"
    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}
