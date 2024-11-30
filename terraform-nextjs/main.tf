provider "aws" {
    region = "us-east-1"
}

#creating a s3 bucket
resource "aws_s3_bucket_website_configuration" "nextjs_website" {
  bucket = aws_s3_bucket-cloud_academy_w-7project

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

#ownership control
resource "aws_s3_bucket_ownership_control" "nextjs_bucket_ownership_control" {
  bucket = aws_s3_bucket-cloud_academy_w-7project.id
  rule {
    object_ownership = "BucketOwnerprefferred"
  }
}

#block_public_acls
resource "aws_s3_bucket_public_access_block" "nextjs_bucket_public_access_block" {
  bucket = aws_s3_bucket-cloud_academy_w-7project.id
  
  
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
  
}

#bucketACL
resource "aws_s3_bucket_acl" "nextjs_bucket_acl" {
  bucket = aws_s3_bucket-cloud_academy_w-7project.id
  acl = "public-read"
  depends_on = [ 
    aws_s3_bucket_ownership_control.nextjs,
    aws_s3_bucket_public_access_block.nextjs_bucket_public_access_block
   ]
  
}





#creating a s3 bucket policy

# Step 3: Create the S3 Bucket Policy to allow public read access
resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
  bucket = aws_s3_bucket-cloud_academy_w-7project.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        sid = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket-cloud_academy_w-7project.arn}/*"
      }
    ]
  })
}

  

# Step 4: Create the CloudFront Distribution to serve the S3 website

resource "aws_cloudfront_distribution" "nextjs_distribution" {
  origin {
    domain_name = aws_s3_bucket-cloud_academy_w-7project.id.website_endpoint
    origin_id   = "s3-website-origin"

    s3_origin_config {
      origin_access_identity = ""  # You can leave it blank for public access
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "s3-website-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true  # Use the default CloudFront certificate for HTTPS
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"  # No geo restrictions, you can modify this if needed
    }
  }

  tags = {
    Name        = "NextJS Website"
    Environment = "Production"
  }
}
