terraform {
    backend "s3" {
        bucket = "cloud-academy-week7-static-project-16-10"
        key = "global/s3/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table ="Dymano-static-nextjs-tb"

    }
}

