resource "aws_iam_user" "nextcloud-iam" {
  name = "nextcloud-s3-iam"

  tags = {
      Name = "nextcloud-iam"
  }
}

resource "aws_iam_access_key" "nextcloud-ak" {
  user = aws_iam_user.nextcloud-iam.name
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.nextcloud-iam.name
  policy_arn = aws_iam_policy.nextcloud-s3-policy.arn
}

resource "aws_iam_policy" "nextcloud-s3-policy" {
  name = "nextcloud-s3-policy"
  policy = data.aws_iam_policy_document.nextcloud-s3-policy-doc.json
}

data "aws_iam_policy_document" "nextcloud-s3-policy-doc" {
  statement {
    actions = [
      "s3:*",
      "s3-object-lambda:*",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.nextcloud-s3.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.nextcloud-s3.bucket}/*",
    ]
  }
}