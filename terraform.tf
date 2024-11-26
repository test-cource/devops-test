terraform {
    backend "s3" {
        encrypt = true
        key = "terraform.tfstate"
        region = "us-east-2"
    }
}