resource "aws_s3_bucket" "nextcloud-s3" {
  bucket = var.bucket_name
  force_destroy = true
  acl    = "private"

  tags = {
    Name        = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "nextcloud-s3-a" {
  bucket = aws_s3_bucket.nextcloud-s3.id

  ignore_public_acls = true
  restrict_public_buckets = true
  block_public_acls   = true
  block_public_policy = true
}