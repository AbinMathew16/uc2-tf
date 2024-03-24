# Define the S3 bucket resource
resource "aws_s3_bucket" "tf-uc2-bucket" {
  bucket = "tf-uc2-bucket-a1"
}

# Define S3 object for each file in the local directory
resource "aws_s3_object" "file" {
  for_each = fileset("C:\\Users\\abin.mathew\\Desktop\\tf-uc2-site\\", "*")

  bucket = aws_s3_bucket.tf-uc2-bucket.bucket
  key    = each.value
  source = "C:\\Users\\abin.mathew\\Desktop\\tf-uc2-site\\${each.value}"
}
