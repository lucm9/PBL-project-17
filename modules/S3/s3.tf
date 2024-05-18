# S3 Bucket resource
resource "aws_s3_bucket" "bucket"  {
  bucket = var.bucket_name

  tags = var.tags
}


# S3 Bucket Versioning resource
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_status
  }

}
