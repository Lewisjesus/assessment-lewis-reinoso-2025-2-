output "s3_buckets" {
  description = "Map of S3 buckets details"
  value = {
    for key, bucket in aws_s3_bucket.bucket : key => {
      id                    = bucket.id
      arn                  = bucket.arn
      bucket_domain_name   = bucket.bucket_domain_name
      bucket_regional_domain_name = bucket.bucket_regional_domain_name
      region              = bucket.region
    }
  }
}