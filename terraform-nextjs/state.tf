terraform {
    backend "s3" {
        bucket = "my-terraform-state-16-10"
        key = "global/s3/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table ="terraform-lock-file"

    }
}