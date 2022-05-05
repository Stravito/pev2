resource "aws_s3_bucket" "pev2" {
  bucket = "stravito-pev2"
}

data "aws_iam_policy_document" "origin_identity_access_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.pev2.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.pev2.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "add_policy_to_bucket" {
  bucket = aws_s3_bucket.pev2.id
  policy = data.aws_iam_policy_document.origin_identity_access_policy.json
}
