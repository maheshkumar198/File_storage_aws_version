resource "aws_s3_bucket" "uploads" {

  bucket = "${var.project_name}-${var.environment}-uploads-1981"

  tags = {
    Name = "${var.project_name}-${var.environment}-uploads"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {

  bucket = aws_s3_bucket.uploads.id

  block_public_acls       = true
  block_public_policy     = true

  ignore_public_acls      = true
  restrict_public_buckets = true
}