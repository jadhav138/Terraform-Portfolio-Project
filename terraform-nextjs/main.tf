provider "aws" {
    region = "us-east-1"
}

#creating a s3 bucket
resource "aws_s3_bucket" "cloud_academy_w_7project" {
  bucket = "cloud-academy-w7-static-web-1610" # Replace with your desired bucket name
}

#ownership control
resource "aws_s3_bucket_ownership_controls" "static_bucket_ownership_control" {
  bucket = aws_s3_bucket.cloud_academy_w_7project.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#block_public_acls
 # Block public ACLs and policies for the S3 bucket
resource "aws_s3_bucket_public_access_block" "static_bucket_public_access_block" {
  bucket = aws_s3_bucket.cloud_academy_w_7project.id

  block_public_acls     = false
  block_public_policy   = false  # Set to false to allow the bucket policy
  ignore_public_acls    = false
  restrict_public_buckets = false
}


#bucketACL
#bucketACL
resource "aws_s3_bucket_acl" "static_bucket_acl" {
  bucket = aws_s3_bucket.cloud_academy_w_7project.id
  acl    = "public-read"
  depends_on = [ 
    aws_s3_bucket_ownership_controls.static_bucket_ownership_control,
    aws_s3_bucket_public_access_block.static_bucket_public_access_block
  ]
}


#creating a s3 bucket policy
resource "aws_s3_bucket_policy" "static_bucket_policy" {
  bucket = aws_s3_bucket.cloud_academy_w_7project.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
       Resource  = "${aws_s3_bucket.cloud_academy_w_7project.arn}/*"
      }
    ]
  })
}

  #origin AccessIdentity

 
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "OAI for next.js portfolio site"
}

resource "aws_cloudfront_distribution" "static_distribution" {
  origin {
    domain_name = aws_s3_bucket.cloud_academy_w_7project.bucket_regional_domain_name
    origin_id   = "s3-static-portfolio-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled      = true
  comment             = "Next.js portfolio site"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods    = ["GET", "HEAD", "OPTIONS"]
    cached_methods     = ["GET", "HEAD"]
    target_origin_id   = "s3-static-portfolio-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "static Website"
    Environment = "Production"
  }
}


